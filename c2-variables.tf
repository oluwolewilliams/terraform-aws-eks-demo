terraform {
  required_version = "~> 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
variable "aws_region" {
  description = "region in whcich to create resources"
  type        = string
  default     = "us-east-1"

}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"


}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_keypair" {
  type        = string
  description = "Name of an existing EC2 key pair"
  default     = "terraform-keypair1"
}
