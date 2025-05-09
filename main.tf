provider "aws" {
  region  = var.aws_region
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get the subnet in us-east-1a from the default VPC
data "aws_subnet_ids" "default_subnets" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "use_this_one" {
  id = tolist(data.aws_subnet_ids.default_subnets.ids)[0]
  # Optional: Add filter for availability_zone = us-east-1a if needed
}

# Security group for SSH and HTTP
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.use_this_one.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              usermod -aG docker ec2-user
              docker run -d -p 80:3000 kimcharli/nodejs-hello-world:latest
              EOF

  tags = {
    Name = "SupriyaMutharasanApp"
  }
}
[ec2-user@ip-172-31-88-200 ~]$ mkdir src
[ec2-user@ip-172-31-88-200 ~]$ mv main.tf src
[ec2-user@ip-172-31-88-200 ~]$ cd src/
[ec2-user@ip-172-31-88-200 src]$ terraform fmt -recursive
main.tf
[ec2-user@ip-172-31-88-200 src]$ cat main.tf
provider "aws" {
  region = var.aws_region
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get the subnet in us-east-1a from the default VPC
data "aws_subnet_ids" "default_subnets" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "use_this_one" {
  id = tolist(data.aws_subnet_ids.default_subnets.ids)[0]
  # Optional: Add filter for availability_zone = us-east-1a if needed
}

# Security group for SSH and HTTP
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.use_this_one.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              usermod -aG docker ec2-user
              docker run -d -p 80:3000 kimcharli/nodejs-hello-world:latest
              EOF

  tags = {
    Name = "SupriyaMutharasanApp"
  }
}
