terraform {
  backend "s3" {
    bucket = "stack-tfstate"
    key    = "terraform-toplevel"
    region = "us-east-1"

    dynamodb_table = "stack-tflocking"
  }
}

module "container-infra" {
  source = "./container-infra"
}

module "k8s-infra" {
  source = "./k8s-infra"
}

module "prometheus" {
  source           = "./prometheus"
  k8s_host         = module.k8s-infra.endpoint
  k8s_cluster_name = module.k8s-infra.cluster-name
  k8s_ca_cert      = module.k8s-infra.ca-data
}
