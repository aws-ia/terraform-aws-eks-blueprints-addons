variable "name" {
  description = "Define the name for AWS resources that will be created. Default `multi-tenancy-with-teams`"
  type        = string
  default     = "eks-with-blueprints-addons"
}

variable "region" {
  description = "Define the AWS region to deploy the Amazon EKS Cluster. Default `us-west-2`"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "Define the CIDR block for the VPC that will be created to deploy the Amazon EKS Cluster. Default `10.0.0.0/16`"
  type        = string
  default     = "10.0.0.0/16"
}
