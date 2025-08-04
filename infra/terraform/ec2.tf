# Security Group for Jenkins
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow Jenkins access"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JenkinsSG"
  }
}

# Jenkins EC2 (Ubuntu)
resource "aws_instance" "jenkins_ec2" {
  ami                         = "ami-06a644026f43160a5"  # Ubuntu 22.04 LTS AMI in ap-south-1
  instance_type               = "t3.medium"              # Changed from variable to t3.medium
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  subnet_id                   = aws_subnet.eks_subnet[0].id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20           # 20 GB root volume
    volume_type = "gp2"
  }

  tags = {
    Name = "Jenkins-EC2"
  }
}