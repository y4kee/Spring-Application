### PROVIDER CONFIGURATION ###
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69.0"
    }
  }
  backend "s3" {
    bucket = "<your S3 bucket name>"
    key = "dev/spring_app/terraform.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"
}


### VPC CONFIGURATION ###

resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "Main VPC"
  }
}

resource "aws_subnet" "Public_Subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "192.168.1.0/24"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "Main Public Subnet"
  }
}

resource "aws_internet_gateway" "Internet_Gateway" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rout_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }
  tags = {
    Name = "Main Route Table"
  }
}

### Security Group CONFIGURATION ###

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.Public_Subnet.id
  route_table_id = aws_route_table.rout_table.id
}

resource "aws_security_group" "main_security_group" {
  name = "Main Security Group"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Jenkins"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "APP"
    from_port = 8081
    to_port = 8081
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "spring_app" {
  ami = "ami-07652eda1fbad7432"
  instance_type = "t2.medium"
  subnet_id = aws_subnet.Public_Subnet.id
  vpc_security_group_ids = [aws_security_group.main_security_group.id]
  associate_public_ip_address = true
  key_name = "<your ssh-key name>"
  provisioner "file" {
    source = "scripts/installDocker.sh"
    destination =  "/home/ubuntu/installDocker.sh"

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("<path to your private ssh-key>")
      host = self.public_ip
    }
  }

  tags = {
    Name = "Sping APP instance"
    Owner = ""
  }
}