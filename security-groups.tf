resource "aws_security_group" "security_group" {
  name        = "${var.enviroment}-${var.name}-security-group"
  description = "${var.enviroment} ${var.name} Security group to allow controlled inbound traffic"
  vpc_id      = "${var.vpc_id}"


  tags {
    Name = "${var.enviroment} ${var.name}"
    Enviroment = "${terraform.workspace}"
  }
}

resource "aws_security_group_rule" "engine_editor_port_rule" {
  type = "ingress"
  count    = "${length(var.ingress_rules)}"
  description = "${lookup(var.ingress_rules[count.index], "description")}"
  from_port   = "${lookup(var.ingress_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.ingress_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.ingress_rules[count.index], "protocol")}"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "ssh_port_rule" {
  type = "ingress"
  description = "Open allow instance to be accessed via ssh"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.security_group.id}"
}


resource "aws_security_group_rule" "ec2_egress_rule_all" {
  type = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.security_group.id}"
}