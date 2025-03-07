resource "aws_instance" "servers" {
  count                       = 3
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = element(var.subnets, count.index)
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install  httpd -y
    echo "I am from dlr-server${count.index + 1}" > /var/www/html/index.html
    systemctl start httpd
    systemctl enable httpd
  EOF

  tags = {
    Name = "dlr-server${count.index + 1}"
  }
}
