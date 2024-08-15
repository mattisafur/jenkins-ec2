terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.62.0"
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

resource "aws_security_group" "jenkins" {
  name = "jenkins test instance"
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_jenkins_web" {
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = var.web_panel_access_cidr_ipv4
  from_port         = 8080
  to_port           = 8080
  ip_protocol       = "TCP"
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_ssh" {
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = var.ssh_access_cidr_ipv4
  from_port         = 22
  to_port           = 22
  ip_protocol       = "TCP"
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_all" {
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = -1
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [ aws_security_group.jenkins.id ]

  root_block_device {
    volume_type = "gp3"
    volume_size = var.storage_size
  }
}
