locals {
  env         = "dev"
  profile     = "fiap"
  region      = "us-east-1"
  zone1       = "us-east-1a"
  zone2       = "us-east-1b"
  eks_name    = "fiap-eks-cluster"
  eks_version = "1.30"
  s3_rds_name = "terraform-state-rds"
  s3_eks_name = "terraform-state-eks"
  # role_arn = "arn:aws:iam::345594575392:role/role-admin"
}
