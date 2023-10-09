module "sg" {
   source = "./sg"
}

module "ec2" {
    source = "./ec2"
    security_group_id = module.sg.security_group_id
}

terraform {
backend "s3"{
  bucket = "terraform-b10"
  key    = "06-modules/terraform.tfstate"
  region = "us-east-1"
}
}

provider "aws" {
   region = "us-east-1"
}