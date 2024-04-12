=========================
Building the HELM Project
=========================
This project uses PostgreSQL as HDP's account database by default, thus have a dependency on PostgreSQL Helm Chart project.

To build the project, use the command
>> helm dependency build hdp-server-deploy

===================
Configurable Values
===================
By default, this project installs PostgreSQL, runs a SQL Script to setup the user and admin accounts needed for HDP in a fresh install.
When the volumes are mounted, and a prior database exists, PostgreSQL will skip running the init SQL script.

In case of a need to use any other supported database like Oralce or SQLServer, configure .values.postgres.enabled to false.
This will skip creating the init sql script and the installation of PostgreSQL database.
In addition, config/hdpdeploy.properties need to be updated to the right account database information for a successful HDP installation.

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

You can refer to the hdp-secrets.yaml for the HDP Admin and User passwords. The passwords are base64 encoded in the file.