variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role ARN for EKS cluster"
}

variable "node_role_arn" {
  type        = string
  description = "IAM role ARN for EKS worker nodes"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for EKS"
}

variable "cluster_version" {
  type        = string
  default     = "1.30"
}

variable "desired_size" {
  type        = number
  default     = 2
}

variable "max_size" {
  type        = number
  default     = 3
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
}

variable "cluster_role_dependency" {
  description = "Dependency for cluster IAM role"
}

variable "node_role_dependency" {
  description = "Dependency for node IAM role"
}
