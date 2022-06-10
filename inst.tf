terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "inst1" {
	ami = "ami-0ed9277fb7eb570c9"
        instance_type = "t2.micro"
        key_name = "test"
        security_groups = ["launch-wizard-11"]
        tags = {

    Name = "Terraform"

  }
}
