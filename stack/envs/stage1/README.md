GCP - k8s "stack" notes
=======================

Goals:
1. Easily setup/teardown k8s experiments
2. Limit usage of cloud resources to [free tier](https://cloud.google.com/free)

Setup/Teardown
--------------

## Setup Terraform state/locking

    cd terraform-init
    terraform apply --auto-approve
    cd ..

## Start up network with Terraform

    cd network
    terraform apply --auto-approve
    cd ..


## Start up cluster with Terraform

    cd k8s-cluster
    terraform apply --auto-approve


## Shutdown cluster

    terraform destroy --auto-approve


Local Configuration
-------------------

## Configure `gcloud`

    gcloud config set project stack-348418
    gcloud config set compute/region us-central1
    gcloud config set compute/zone us-central1-a

## Configure `kubectl`

    gcloud container clusters get-credentials staging-gke-cluster


Setup Issues
------------

## ServiceConsumerManager

Error:

    Failed precondition when calling the ServiceConsumerManager: ... should enable service:container.googleapis.com before generating a service account.


Fix:

    gcloud services enable container.googleapis.com


TODOs
-----

[] Attach gke service account "staging-gke-service-account@stack-348418.iam.gserviceaccount.com" to container artifact repository


Reference
---------
- [GCP cost calculator](https://cloud.google.com/products/calculator)
