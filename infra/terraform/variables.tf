variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "jenkins-key"
}

variable "jenkins_ami" {
  default = "ami-0ded8326293d3201b" # Amazon Linux 2 AMI for ap-south-1
}
