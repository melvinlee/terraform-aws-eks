variable "name" {
  description = "(Required) The name of the EKS Cluster to create."
  type        = string
}

variable "vpc_id" {
  description = "(Required) The VPC subnets for your EKS cluster to use."
  type        = string
}

variable "node_groups" {
  description = "(Required) List of EKS managed node group"
}

variable "tags" {
  description = "(Required) Map of tags for the deployment"
}
