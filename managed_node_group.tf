resource "aws_eks_node_group" "eks_node_group" {

  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = each.value.name
  node_role_arn   = aws_iam_role.node_group_iam.arn
  subnet_ids      = data.aws_subnet_ids.selected.ids

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  disk_size = each.value.disk_size

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.amazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.amazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.amazonEC2ContainerRegistryReadOnly,
  ]
}
