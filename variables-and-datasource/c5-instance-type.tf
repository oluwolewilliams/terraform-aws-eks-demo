resource "aws_instance" "web" {
  ami                         = data.aws_ami.amzn_linux_2.id
  instance_type               = var.instance_type
  key_name                    = var.instance_keypair
  associate_public_ip_address = true
  monitoring                  = true

  # Use one of the default (typically public) subnets
  subnet_id = data.aws_subnets.default.ids[0]

  vpc_security_group_ids      = [aws_security_group.vpc_ssh.id]
  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd

    echo '<h1>Welcome to oluwolewilliams.com terraform demo1 - APP-1</h1>' | tee /var/www/html/index.html
    mkdir -p /var/www/html/app1
    echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to oluwolewilliams.com terraform demo- APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | tee /var/www/html/app1/index.html

    TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    curl -s -H "X-aws-ec2-metadata-token: $${TOKEN}" \
      http://169.254.169.254/latest/dynamic/instance-identity/document \
      -o /var/www/html/app1/metadata.html
  EOF

  tags = { " Name" = "count-demo-${count.index}"
  }
}
