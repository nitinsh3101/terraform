data "aws_iam_role" "eks-role" {
  name = "Nitin_EKS_Custer"
}

data "aws_iam_role" "node-role" {
  name = "nitin-role-workernode"
}