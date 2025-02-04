resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_security_group" "my_security_group" {
  name_prefix = "my-sg"
  vpc_id      = aws_vpc.my_vpc.id

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

resource "aws_instance" "my_instance" {
  ami           = "ami-0cafb04477a984411"  # Replace with an available AMI ID in your region
  instance_type = "t2.micro"  # Choose the desired instance type
  subnet_id     = aws_subnet.my_subnet.id
  security_groups = ["mysecuritygroup"]

  tags = {
    Name = "my-instance"
  }

  # Optional: Associate an elastic IP (EIP)
  associate_public_ip_address = true
}
