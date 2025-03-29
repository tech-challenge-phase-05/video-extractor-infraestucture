variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "techchallenge"
  type        = string
  default     = "techchallenge-eks-cluster"
}

variable "node_instance_type" {
  description = "Tipo de instância para os nós do EKS"
  type        = string
  default     = "t3.medium"
}

variable "node_group_size" {
  description = "Tamanho do grupo de nós EKS"
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Capacidade desejada de nós no cluster"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Capacidade máxima de nós no cluster"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Capacidade mínima de nós no cluster"
  type        = number
  default     = 1
}

variable "load_balancer" {
  description = "Url do loadBalancer da video extractor"
}
