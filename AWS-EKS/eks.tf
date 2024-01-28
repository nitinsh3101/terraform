data "aws_iam_role" "eks-role" {
  name = "Nitin_EKS_Custer"
}

data "aws_iam_role" "node-role" {
  name = "nitin-role-workernode"
}

resource "aws_eks_cluster" "eks" {
  name = "nitin-tf-eks"
  role_arn =  data.aws_iam_role.eks-role.arn
  vpc_config {
    subnet_ids = aws_subnet.subnet-private[*].id
    #subnet_ids = [ "${element(aws_subnet.subnet-private[*].id, count.index)}" ]
    security_group_ids = [ aws_security_group.sg.id ]
    endpoint_private_access = true
    endpoint_public_access = false
  }
  depends_on = [ aws_subnet.subnet-private ] 
}

resource "aws_eks_node_group" "eks-node" {
  cluster_name = aws_eks_cluster.eks.name
  node_group_name = "nitin-ng"
  subnet_ids = aws_subnet.subnet-private[*].id
  node_role_arn = data.aws_iam_role.node-role.arn
  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 2
  }
  instance_types = ["t2.medium"]
}

output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}