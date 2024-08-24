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
