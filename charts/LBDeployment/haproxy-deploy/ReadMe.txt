========
Overview
========

This HELM project wraps Haproxy Ingress Controller helm chart as a dependency, when installed - this will setup a HAProxy Ingress Controller with two pods and a service.

To build this project, run -
    helm dep up hdp-lb-server-deploy

This will download the chart to /charts directory.

The .values.yaml has the basic configuration needed for the HAProxy Ingress Controller HELM project setup.  Based on the need, values can be finetuned further.

Refer to this wiki page for more details - https://progresssoftware.atlassian.net/wiki/spaces/DataDirectRandD/pages/541753550/Deploying+HDP+Server+on+Azure+Kubernetes+Service+AKS

================
Steps to Install
================

helm install haproxy-deploy haproxy-deploy --namespace haproxy-controller -create-namespace -f values.yaml

This would install necessary resources, to get the external IP for the HAProxy Controller Service,
run the command kubectl get svc and check the External - IP column.

'A' record should be mapped to this IP address for the valid dns hostname in a valid dns zone.

As an example, this is the default dns zone offerred by Azure AKS accessible over public internet.
To access HDP would be something like - http://hdp.2565fbe255034c49a07b.eastus.aksapp.io/

================
Useful Commands
================

helm install haproxy-deploy haproxy-deploy --namespace haproxy-controller --create-namespace -f values.yaml

helm list --namespace haproxy-controller

kubectl get svc --namespace haproxy-controller

kubectl get pods --namespace haproxy-controller

helm uninstall haproxy-deploy --namespace haproxy-controller

