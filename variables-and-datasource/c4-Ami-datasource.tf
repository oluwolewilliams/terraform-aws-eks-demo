# Default VPC
data "aws_vpc" "default" {
  default = true
}

# Default subnets in that VPC (replaces deprecated aws_subnet_ids)
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  # Use default-for-az = true to pick the default subnets (typically public)
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

# Amazon Linux 2 AMI (HVM, x86_64, gp2) — adjust if needed
data "aws_ami" "amzn_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
