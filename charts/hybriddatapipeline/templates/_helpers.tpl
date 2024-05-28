{{/*
Expand the name of the chart.
*/}}
{{- define "hybriddatapipeline.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "hybriddatapipeline.namespace" -}}
  {{- printf "%s" .Release.Namespace -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hybriddatapipeline.fullname" -}}
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
{{- define "hybriddatapipeline.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hybriddatapipeline.labels" -}}
helm.sh/chart: {{ include "hybriddatapipeline.chart" . }}
{{ include "hybriddatapipeline.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hybriddatapipeline.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hybriddatapipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hybriddatapipeline.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hybriddatapipeline.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Helper function to retrieve a value from a Kubernetes Secret
Arguments in Order - namespace, secretname, secretkey
Usage: {{ include "hybriddatapipeline.secretValue" (list "default" "hdp-secrets" "userpwd") | trim | b64dec}}
*/}}
{{- define "hybriddatapipeline.secretValue" -}}
{{- $namespace := index . 0 }}
{{- $secretName := index . 1 }}
{{- $key := index . 2 }}
{{- $existingSecret := (lookup "v1" "Secret" $namespace $secretName) }}
{{- if $existingSecret.data }}
{{- $userPassword := index $existingSecret.data $key}}
{{ $userPassword  | b64dec}}
{{- end -}}
{{- end }}
