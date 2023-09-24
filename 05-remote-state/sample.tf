provider "aws" {
    region  = "us-east-1"
 }
data "aws_ami" "centos8" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

resource "aws_instance" "web" {
   ami              = data.aws_ami.centos8.id
   vpc_security_group_ids = [aws_security_group.allow_tls.id]

   tags = {
     Name = "test-centos8"
  }
}

terraform {
   backend "s3" {
     bucket = "terraform-s70"
     key    = "05-remote-state/terraform.tfstate"
     region = "us-east-1"
   }
}

resource "aws_security_group" "allow_tls" {
       name  = "allow_tls"
       description  = "Allow TLS inbound traffic"
     ingress  {
        description  = "TLS from VPC"
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
        ipv6_cidr_blocks = [": :/0"]
     }
     tags = {
        Name = "allow_tls"

     }
}
