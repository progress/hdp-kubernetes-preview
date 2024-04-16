{{/*
Expand the name of the chart.
*/}}
{{- define "hdp-lb-server-deploy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hdp-lb-server-deploy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hdp-lb-server-deploy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hdp-lb-server-deploy.labels" -}}
helm.sh/chart: {{ include "hdp-lb-server-deploy.chart" . }}
{{ include "hdp-lb-server-deploy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hdp-lb-server-deploy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hdp-lb-server-deploy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hdp-lb-server-deploy.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hdp-lb-server-deploy.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Helper function to retrieve a value from a Kubernetes Secret
Arguments in Order - namespace, secretname, secretkey
Usage: {{ include "hdp-lb-server-deploy.secretValue" (list "default" "hdp-secrets" "userpwd") | trim | b64dec}}
*/}}
{{- define "hdp-lb-server-deploy.secretValue" -}}
{{- $namespace := index . 0 }}
{{- $secretName := index . 1 }}
{{- $key := index . 2 }}
{{- $existingSecret := (lookup "v1" "Secret" $namespace $secretName) }}
{{- if $existingSecret.data }}
{{- $userPassword := index $existingSecret.data $key}}
{{ $userPassword  | b64dec}}
{{- end -}}
{{- end }}
