variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0230bd60aa48260c6" # Amazon Linux 2 (update if needed)
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of the AWS key pair to use"
  default     = "your-existing-keypair-name"
}
