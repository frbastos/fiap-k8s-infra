# resource "aws_iam_role" "eks" {
#   name = "${local.env}-${local.eks_name}-eks-cluster"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action : "sts:AssumeRole"
#       Effect : "Allow",
#       Principal : {
#         Service : "eks.amazonaws.com"
#       },
#     }]
#     Version = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks.name
# }

resource "aws_eks_cluster" "eks" {
  name     = "${local.env}-${local.eks_name}"
  version  = local.eks_version
  role_arn = local.role_arn

  upgrade_policy {
    support_type = "STANDARD"
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids = [
      # aws_subnet.private_zone1.id,
      # aws_subnet.private_zone2.id,
      aws_subnet.public_zone1.id,
      aws_subnet.public_zone2.id
    ]
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  # depends_on = [aws_iam_role_policy_attachment.eks]
}


