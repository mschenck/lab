resource "aws_security_group" "perimeter_node" {
  name        = "perimeter_node"
  description = "Ruleset for perimeter_node"
  vpc_id      = var.vpc_id
}
