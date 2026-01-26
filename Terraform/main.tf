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
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes NodePort range"
    from_port   = 30000
    to_port     = 32767
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
  ami           = "ami-088e3774a557a94ed" 
  instance_type = "c7i-flex.large"
  key_name = "test"

  #  subnet_id              = "subnet-0f293e5bc184e7692"
  #  vpc_security_group_ids = ["sg-0678c60b34ac72be4"]

  vpc_security_group_ids = [aws_security_group.telco_sg.id]

  associate_public_ip_address = true
  tags = {
    Name = "Demo"
    Role = "telcocloud"
  }


}
