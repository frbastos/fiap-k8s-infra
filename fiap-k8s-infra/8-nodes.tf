# resource "aws_iam_role" "nodes" {
#   name = "${local.env}-${local.eks_name}-eks-nodes"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.nodes.name
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.nodes.name
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.nodes.name
# }

resource "aws_eks_node_group" "general" {
  cluster_name    = "${local.env}-${local.eks_name}"
  version         = local.eks_version
  node_group_name = "general"
  node_role_arn   = local.role_arn

  subnet_ids = [
    # aws_subnet.private_zone1.id,
    # aws_subnet.private_zone2.id,
    aws_subnet.public_zone1.id,
    aws_subnet.public_zone2.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }

  # launch_template {
  #   name    = aws_launch_template.eks-with-disks.name
  #   version = aws_launch_template.eks-with-disks.latest_version
  # }

  depends_on = [
    # aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    # aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    # aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.eks
  ]

  # Allor external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

}
