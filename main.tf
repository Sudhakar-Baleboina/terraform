resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow SSH and nginx (80)"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "nginx Web"
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "nginx_server" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true

  user_data = file("./nginx.sh")

  tags = {
    Name = "nginx-Server"
  }
}
