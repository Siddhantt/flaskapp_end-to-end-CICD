output "jenkins_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
