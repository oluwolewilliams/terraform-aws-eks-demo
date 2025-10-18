resource "aws_instance" "web" {
  count = 2
  ami   = data.aws_ami.amzn_linux_2.id

  instance_type               = var.instance_type_list[count.index]
  associate_public_ip_address = true

  monitoring             = true
  vpc_security_group_ids = [aws_security_group.vpc_ssh.id]

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    yum -y update
    yum -y install httpd
    systemctl enable --now httpd

    echo '<h1>Welcome to oluwolewilliams.com terraform demo - APP-${count.index + 1}</h1>' > /var/www/html/index.html

    mkdir -p /var/www/html/app1
    cat > /var/www/html/app1/index.html <<HTML
    <!DOCTYPE html>
    <html>
      <body style="background-color:rgb(250,210,210);">
        <h1>Welcome to oluwolewilliams.com terraform demo- APP-${count.index + 1}</h1>
        <p>Terraform Demo</p>
        <p>Application Version: V1</p>
      </body>
    </html>
    HTML

    # IMDSv2 token + instance identity doc
    TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
      -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    curl -s -H "X-aws-ec2-metadata-token: $${TOKEN}" \
      http://169.254.169.254/latest/dynamic/instance-identity/document \
      -o /var/www/html/app1/metadata.html
  EOF

  tags = {
    Name = "count-demo-${count.index}"
  }
}
