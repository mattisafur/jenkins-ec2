variable "aws_region" {
  type        = string
  description = "The AWS region in which to create the jenkins instace"

  sensitive = false
}

variable "instance_type" {
  type        = string
  description = "The jenins instance type"

  sensitive = false
}

variable "web_panel_access_cidr_ipv4" {
  type        = string
  description = "The IPv4 CIDR block to which to allow access to the jenkins instance"

  sensitive = true
}

variable "ssh_access_cidr_ipv4" {
  type        = string
  description = "The IPv4 CIDR block to which allow SSH access to the jenkins instance"

  sensitive = true
}

variable "storage_size" {
  type        = number
  description = "Storage size of the jenkins instance"

  sensitive = false
}

variable "key_name" {
  type        = string
  description = "SSH key pair to be used for connecting to the jenkins instance"

  sensitive = true
}
