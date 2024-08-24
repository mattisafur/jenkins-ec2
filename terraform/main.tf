terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.62.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~>4.0.5"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "tls_private_key" "jenkins_node_creation" {
  algorithm = "ED25519"
}

resource "aws_instance" "jenkins_master" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [ aws_security_group.jenkins.id ]

  root_block_device {
    volume_type = "gp3"
    volume_size = var.storage_size
  }
}
