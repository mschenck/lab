terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.2.0"
    }
  }
}

#provider "helm" {
#  kubernetes {
#    config_path = "./kube.config"
#  }
#}
provider "helm" {
  kubernetes {
    host                   = var.k8s_host
    cluster_ca_certificate = base64decode(var.k8s_ca_cert)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", var.k8s_cluster_name]
      command     = "aws"
    }
  }
}
