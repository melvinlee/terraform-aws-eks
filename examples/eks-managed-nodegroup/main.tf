
module "eks" {

  source = "../.."

  name   = "myEKS"
  vpc_id = "vpc-af7efacb"

  node_groups = {
    node_group1 = {
      name         = "example1"
      desired_size = 3
      max_size     = 5
      min_size     = 3
      disk_size    = 30
    },
    node_group2 = {
      name         = "example2"
      desired_size = 1
      max_size     = 1
      min_size     = 1
      disk_size    = 100
    }
  }

  tags = {
    env        = "staging"
    costCentre = "8888"
  }
}
