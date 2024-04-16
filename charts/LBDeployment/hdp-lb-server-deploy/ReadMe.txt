========
Overview
========

This HELM project wraps PostgreSQL helm chart as a dependency, when installed - this will setup a PostgreSQL database.

To build this project, run -
    helm dep up hdp-lb-server-deploy

This will download the chart to /charts

The .values.yaml has the defaults for the HAProxy HELM project setup.  Based on the need, values can be finetuned.

Note: This project does not configure the Ingress Controller to run over SSL yet.

================
Steps to Install
================

helm install hdp-lb-server-deploy hdp-lb-server-deploy --namespace hdp-deployment -create-namespace -f values.yaml

This would install necessary resources.

================
Useful Commands
================

helm install hdp-lb-server-deploy hdp-lb-server-deploy --namespace hdp-deployment --create-namespace -f values.yaml

helm list --namespace hdp-deployment

kubectl get svc --namespace hdp-deployment

kubectl get pods --namespace hdp-deployment

kubectl logs hdp-0 --namespace hdp-deployment

kubectl exec -it hdp-0 --namespace hdp-deployment -- bash

helm uninstall hdp-lb-server-deploy --namespace hdp-deployment

