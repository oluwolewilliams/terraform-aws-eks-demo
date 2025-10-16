resource "aws_security_group" "vpc_ssh" {
  name        = "vpc-web"
  description = "Allow SSH and HTTP inbound"
  vpc_id      = data.aws_vpc.default.id

  # SSH — tighten admin_cidr in real deployments
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  # HTTP for Apache
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # (Optional) HTTPS
  # ingress {
  #   description       = "HTTPS"
  #   from_port         = 443
  #   to_port           = 443
  #   protocol          = "tcp"
  #   cidr_blocks       = ["0.0.0.0/0"]
  #   ipv6_cidr_blocks  = ["::/0"]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = { Name = "vpc-web" }
}
