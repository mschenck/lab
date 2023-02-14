
data "aws_ami" "perimeterAMI" {
  owners = ["self"]

  filter {
    name   = "name"
    values = ["perimeter-AMI"]
  }
}

resource "aws_eip" "proxy" {
  count = var.number_instances

  network_interface = aws_network_interface.proxy[count.index].id
}

resource "aws_network_interface" "proxy" {
  count = var.number_instances

  subnet_id   = var.subnets[count.index].id
    security_groups = [aws_security_group.perimeter_node_sg.id]

  tags = {
    Name = "public_${count.index}"
    Type = "Perimeter"
  }
}

resource "aws_eip" "mgmt" {
  count = var.number_instances
  network_interface = aws_network_interface.mgmt[count.index].id
}

resource "aws_network_interface" "mgmt" {
  count = var.number_instances

  subnet_id   = var.subnets[count.index].id
  security_groups = [aws_security_group.perimeter_node_sg.id]

  tags = {
    Name = "mgmt_${count.index}"
    Type = "Perimeter"
  }
}

resource "aws_instance" "perimeter_node" {
  count = var.number_instances

  instance_type = var.instance_type
  ami           = var.ami_id != "<DEFAULT>" ? var.ami_id : data.aws_ami.perimeterAMI.id
  key_name      = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.mgmt[count.index].id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.proxy[count.index].id
    device_index         = 1
  }

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


