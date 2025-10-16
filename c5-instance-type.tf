resource "aws_instance" "web" {
  ami                    = data.aws_ami.amzn_linux_2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc_ssh.id, ]
  user_data              = file("${path.module}/pp-install.sh")

  tags = {
    Name = "EC2 Demo"
  }
}
