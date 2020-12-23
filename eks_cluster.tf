data "aws_subnet_ids" "selected" {
  vpc_id = var.vpc_id
}

resource "aws_eks_cluster" "eks" {
  name     = var.name
  role_arn = aws_iam_role.eks_iam.arn

  vpc_config {
    subnet_ids = data.aws_subnet_ids.selected.ids
  }

  tags = local.tags

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.amazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.amazonEKSVPCResourceController,
  ]
}

