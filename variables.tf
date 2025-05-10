variable "availability_zone" {
  default     = "us-east-1a"
  description = "Availability zone to use when filtering subnets"
}

# Keep the rest as-is
variable "aws_region" {
  default     = "us-east-1"
}

variable "ami_id" {
  default     = "ami-0230bd60aa48260c6"
}

variable "instance_type" {
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of your existing EC2 key pair"
  default     = "ECTwoInstanceKeyPairToRunFromMacbookAir2017"
}
