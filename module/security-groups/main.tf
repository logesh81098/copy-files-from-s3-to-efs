###########################################################################################################
#                                 Creating Security group
###########################################################################################################
resource "aws_security_group" "efs-sg" {
  name = "EFS-security-group"
  description = "${var.project-name} Security group for EFS"
  vpc_id = var.vpc-id
  ingress {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    cidr_blocks = [var.subnet1-cidr, var.subnet2-cidr]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
