provider "aws" {
  region     = "ap-south-1"
  profile = "Sibu02"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "telco_sg" {
  name        = "telco_sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Demo" {
  ami           = "ami-0e3addcf2a4624dfb"
  instance_type = "t3.small"
  key_name = "test"

  #  subnet_id              = "subnet-0f293e5bc184e7692"
  #  vpc_security_group_ids = ["sg-0678c60b34ac72be4"]

  vpc_security_group_ids = [aws_security_group.telco_sg.id]

  associate_public_ip_address = true
  tags = {
    Name = "Demo"
  }


}
