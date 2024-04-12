=========
Overview
=========
This is a HELM chart project to do a simple single node HDP deployment.
By default, uses PostgreSQL as account database - the required user accounts will be setup automatically during the project install.

Optionally, we can use any other database as account database, but the required configurations need to be updated correctly.
Refer to the hdp-server-deploy/ReadMe.txt for more details.

==============
Installing HDP
==============

By running the following two commands HDP should be setup successfully.

Steps:
1) Create the secrets used for this project setup

    kubectl create -f <root>\hdp-server-deploy\secrets\hdp-secrets.yaml

    kubectl create -f <root>\hdp-server-deploy\secrets\postgres-secrets.yaml
2) Setup HDP
    helm install hdp-server-deploy hdp-server-deploy

==============
Accessing HDP
==============
Access Hybrid Data Pipeline (HDP) using https://<EXTERNAL-IP>:8443>/hdpui or http://<EXTERNAL-IP>:8080>/hdpui

To know the EXTERNAL-IP for the hdp-service, run the following command   
kubectl get svc

There are two users created by default named d2cadmin and d2cuser.
The passwords are created as part of hdpsecrets with the keys hdpAdminPwd and hdpUserPwd.

