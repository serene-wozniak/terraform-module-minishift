resource "aws_security_group" "minishift-access" {
  description = "UI Access to the ${var.name} Minishift"
  name        = "${var.name} - Minishift Access"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
