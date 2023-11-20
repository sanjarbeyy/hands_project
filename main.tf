resource "aws_key_pair" "cloud_2023" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_eip" "cloud_2023" {
  instance = aws_instance.cloud_2023.id
  domain   = "vpc"
}

# resource "aws_security_group" "cloud_2023" {
#  for_each = var.security_groups
#  name        = "cloud_2023"
#  description = "Security Group for cloud_2021"
#  dynamic "ingress" {
#    for_each = [22, 80, 443]
#    content {
#      from_port   = ingress.value
#      to_port     = ingress.value
#      protocol    = "tcp"
#      cidr_blocks = ["0.0.0.0/0"]
#    }
#  }
#  dynamic "egress" {
#    for_each = [8000, 8080, 8888]
#    content {
#      from_port   = egress.value
#      to_port     = egress.value
#      protocol    = "tcp"
#      cidr_blocks = ["192.168.1.1/32"]
#    }
#  }
# }

resource "aws_instance" "cloud_2023" {

  ami           = var.ami["us-east-1"]
  instance_type = var.instance_types[0]
  key_name      = var.key_name
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [module.security_groups.security_group_id["cloud_2023_sg"]] #[aws_security_group.cloud_2023["cloud_2023_sg"] ]
  }
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
 
  tags = {
    Name = "cloud_2023"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
 
  map_public_ip_on_launch = true # To ensure the instance gets a public IP
 
  tags = {
    Name = "cloud_2023"
  }
}