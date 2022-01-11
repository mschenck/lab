k8s "stack" notes
=================

Setup/Teardown
--------------

## Start up cluster with Terraform

    terraform apply --auto-approve


## Shutdown cluster

    terraform destroy --auto-approve


Fetch kubeconfig
----------------

This pulls an kubeconfig (stored as `kube.config`) from AWS EKS

    aws eks update-kubeconfig --name stack-cluster --kubeconfig=kube.config


NOTE: optionally set KUBECONFIG via `export KUBECONFIG=$(pwd)/kube.config`


Deploy k8s dashboard
--------------------

NOTE: docs for [reference](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)

## Deploy the dashboard

    kubectl --kubeconfig=kube.config apply \
            -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml

## Enable a proxy

    kubectl --kubeconfig=kube.config proxy


NOTE: [Dashboard URL](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=default)


Authenticate dashboard
----------------------
Get a 1-time use token from awk eks

    aws eks get-token --cluster-name stack-cluster



----

Helm
====

NOTE: [reference URL](https://helm.sh/docs/intro/quickstart/)

Checkout [ArtifactHUB](https://artifacthub.io/packages/search?kind=0) for repositories



## Add a helm chart repository

    helm repo add bitnami https://charts.bitnami.com/bitnami


## Search repo for charts

    helm search repo bitnami


## Install a helm chart

    helm --kubeconfig=kube.config install bitnami/kube-prometheus --generate-name


## expose prometheus and alertmanager

    kubectl --kubeconfig=kube.config port-forward \
            --namespace default svc/kube-prometheus-prometheus 9090:9090 &
    kubectl --kubeconfig=kube.config port-forward \
            --namespace default svc/kube-prometheus-alertmanager 9093:9093 &



