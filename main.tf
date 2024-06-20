provider "aws" {
  region = var.region
}

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "pb_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_cidr
}

resource "aws_subnet" "pr_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_cidr

}

resource "aws_subnet" "db_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.db_subnet_cidr
}

resource "aws_internet_gateway" "main_igt" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "pb_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igt.id

  }
}

resource "aws_route_table_association" "pb_rt_asso" {
  subnet_id      = aws_subnet.pb_subnet.id
  route_table_id = aws_route_table.pb_rt.id

}

resource "aws_security_group" "main_sg" {
  vpc_id = aws_vpc.main_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "main_server" {
  ami             = "ami-0c0e147c706360bd7"
  instance_type   = "t3.micro"
  subnet_id       = aws_subnet.pb_subnet.id
  security_groups = [aws_security_group.main_sg.name]
  key_name        = var.key_pair

  user_data = file("./scripts/install_java_app.sh")

}

resource "aws_db_instance" "database" {
  allocated_storage      = 15
  storage_type           = "gp2"
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.db_subnet.id]
}

resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.main_vpc.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.main_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

