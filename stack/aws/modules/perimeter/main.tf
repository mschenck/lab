
resource "aws_instance" "perimeter_node" {
  count = var.number_instances

  instance_type = var.instance_type
  ami           = var.ami_id
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.perimeter_node_sg.id]
  subnet_id              = var.subnets[count.index].id

  tags = {
    Name = "PerimeterNode_${count.index}"
    Type = "Perimeter"
  }
}


resource "aws_security_group" "perimeter_node_sg" {
  name        = "perimeter_node"
  description = "Ruleset for perimeter_node"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow all inbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


