#user 1
resource "aws_instance" "demo_user1" {
  ami                         = "ami-0b6d9d3d33ba97d99"
  instance_type               = "t3.micro"
  key_name                    = "devops-key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.pub-subnet-1.id
  user_data = file("${path.module}/userdata.sh")
  vpc_security_group_ids      = [aws_security_group.sg.id]

  tags = {
    Name = "sjc-devops"
    name = "sjc-devops"
    team = "devops"
  }
}

#user 2
resource "aws_instance" "demo_user2" {
  ami                         = "ami-0b6d9d3d33ba97d99"
  instance_type               = "t3.micro"
  key_name                    = "devops-key"
  subnet_id                   = aws_subnet.pub-subnet-2.id
  associate_public_ip_address = true
  user_data = file("${path.module}/userdata.sh")
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "sjc-devops-2"
    name = "sjc-devops-2"
    team = "devops"
  }
}

resource "aws_security_group" "sg" {
  name        = "SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.demovpc.id

  tags = {
    Name = "Security_ec2"
  }
}
resource "aws_vpc_security_group_ingress_rule" "sg1" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "sg2" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "sg3" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}