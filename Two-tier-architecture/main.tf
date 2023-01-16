# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

# Create a public subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

# Create an RDS MySQL database
resource "aws_db_instance" "database" {
  engine = "mysql"
  engine_version = "5.7.22"
  instance_class = "db.t2.micro"
  db_name = "mydatabase"
  username = "admin"
  password = "password"
  allocated_storage = 20
  vpc_security_group_ids = [aws_security_group.rds.id]
  
  parameter_group_name = aws_db_parameter_group.main.name
}

# Create a security group for the RDS database
resource "aws_security_group" "rds" {
  name = "rds-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a subnet group for the RDS database
resource "aws_db_subnet_group" "main" {
  name = "db-subnet-group"
  subnet_ids = [aws_subnet.public.id]
  description = "Public subnet group for RDS"
}

# Create a parameter group for the RDS database
resource "aws_db_parameter_group" "main" {
  name = "db-parameter-group"
  family = "mysql5.7"
  parameter {
      name = "character_set_server"
      value = "utf8"
    }
}
#Create ec2 instance
resource "aws_instance" "web" {
 ami = "ami-01cc34ab2709337aa"
 instance_type = "t2.micro"

 subnet_id = aws_subnet.public.id
vpc_security_group_ids = ["sg-0f19288ccf5a47cc3"]

tags = {
 "Terraform" = "true"
 }
 }
