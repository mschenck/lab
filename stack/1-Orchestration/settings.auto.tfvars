# Tier 1-Orchestration settings

orchestration_vendor = "GCP" # Options: "AWS", "GCP"
orchestration_name   = "lab-stack"

pods_subnet_cidr = "192.168.0.0/18"
svcs_subnet_cidr = "192.168.64.0/18"

# AWS-specific settings

ec2_instance_type = "t3.micro" # AWS Free Tier pricing
ec2_key_name      = "mbpro15"

# GCP-specific settings

gcp_project              = "stack-348418"
gcp_service_account_name = "stack-gke-service-account"

gcp_region   = "us-central1"
gke_location = "us-central1-a"
