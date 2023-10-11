provider "aws" {
   region = "us-east-1"
}

data "aws_ami" "centos8" {
    most_recent = true
    name_regex = "Centos8-DevOps-Practice"
    owners     = ["973714476881"]
}
resource "aws_instance" "web" {
    ami        = data.aws_ami.centos8.id
    instance_type   = "t3.micro"

    tags = {
       Name = "test-centos8"
}

provisioner "remote-exec" {
    connection {
        host = self.public_ip
        user = "centos"
        password = "DevOps321"
    }
    inline = [
        "false"
        ]
}
}

resource "aws_securoty_group" "allow_tls" {
   name   = "allow_tls"
   description = "Allow TLS inbound traffic"

   ingress {
      description = "TLS" from VPC"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
     ipv6_cidr_blocks = ["::/0"]
   }

   tgs = {
     Name = "allow_tls"
   }
}