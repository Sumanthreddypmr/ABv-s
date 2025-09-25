terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "abvs-s3-bucket-009"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "abvs-dynamodb"
    encrypt        = true
  }
}

# 🔹 VPC
module "vpc" {
  source          = "../../modules/vpc"
  vpc_name        = "abvs-vpc"
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
}

# 🔹 IAM
module "iam" {
  source       = "../../modules/iam"
  cluster_name = "abvs-cluster"
}

# 🔹 EKS
module "eks" {
  source = "../../modules/eks"

  cluster_name     = "abvs-cluster"
  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn    = module.iam.eks_node_role_arn
  subnet_ids       = module.vpc.private_subnets

  cluster_role_dependency = module.iam
  node_role_dependency    = module.iam

  cluster_version = "1.30"
  desired_size    = 2
  max_size        = 3
  min_size        = 1
  instance_type   = "t3.medium"
}
