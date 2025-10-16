variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

# Your key pair (you said it's "terraform-key1")
variable "instance_keypair" {
  type        = string
  default     = "terraform-key1"
  description = "Existing EC2 key pair name"
}

# For SSH; RESTRICT THIS to your IP/CIDR in real use
variable "admin_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
