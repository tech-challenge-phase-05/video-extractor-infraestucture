module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  version      = "20.31.0"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets

  # Configuração de endpoint do cluster
  cluster_endpoint_private_access          = false # Desabilita acesso privado ao endpoint
  cluster_endpoint_public_access           = true  # Habilita acesso público ao endpoint
  enable_cluster_creator_admin_permissions = true
}

resource "kubernetes_config_map" "aws_auth" {
  depends_on = [module.eks]
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamlencode([
      {
        userarn  = "arn:aws:iam::767397844498:user/github-actions-user"
        username = "github-actions-user"
        groups   = ["system:masters"]
      },
      {
        userarn  = "arn:aws:iam::767397844498:user/terraform-user"
        username = "terraform-user"
        groups   = ["system:masters"]
      }
    ])
  }
}
