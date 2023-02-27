# TODO: Designate a cloud provider, region, and credentials
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "udacity"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity_t2" {
  count                  = 4
  ami                    = "ami-0dfcb1ef8550277af"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-034e22964d8cb349d"
  vpc_security_group_ids = ["sg-00ab78cd070708049"]
  key_name               = "vockey"
  tags = {
    Name = "Udacity T2"
  }
}


# # TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "udacity_m4" {
  count                  = 2
  ami                    = "ami-0dfcb1ef8550277af"
  instance_type          = "m4.large"
  subnet_id              = "subnet-034e22964d8cb349d"
  vpc_security_group_ids = ["sg-00ab78cd070708049"]
  key_name               = "vockey"
  tags = {
    Name = "Udacity M4"
  }
}
