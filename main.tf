provider "aws" {
  region = var.region
}

resource "aws_instance" "webserver" {
  ami                    = "ami-09e67e426f25ce0d7"
  key_name               = var.key_name
  user_data              = file("script.sh")
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  tags                   = var.resource_tags
  vpc_security_group_ids = [aws_security_group.acesso_ssh.id]
}

#resource "aws_db_instance" "banco" {
#  allocated_storage    = 5
#  engine               = "mysql"
#  engine_version       = "5.7"
#  instance_class       = "db.t2.micro"
#  name                 = "teste"
#  username             = "admin"
#  password             = "yusuke!"
#  skip_final_snapshot  = true #impedir a criação do snapshot criado por padrão
#  db_subnet_group_name = aws_db_subnet_group.db_subnet.id
#  tags                 = var.resource_tags
#}
#resource "aws_db_subnet_group" "db_subnet" {
#  name       = "dbsubnet"
#  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
#}

#resource "aws_eip" "nat" {
#  vpc = true
#
#  depends_on = [aws_internet_gateway.igw]
#}
#resource "aws_internet_gateway" "igw" {
#  vpc_id = aws_vpc.vpc_webserver.id
#}
#
#resource "aws_nat_gateway" "nat_gw" {
#  allocation_id = aws_eip.nat.id
#  subnet_id     = aws_subnet.public_subnet_a.id
#  depends_on    = [aws_internet_gateway.igw]
#}
#resource "aws_route_table" "router" {
#  vpc_id = aws_vpc.vpc_webserver.id
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_nat_gateway.nat_gw.id
#  }
#}
#resource "aws_route_table_association" "assoc" {
#  subnet_id      = aws_subnet.public_subnet_a.id
#  route_table_id = aws_route_table.router.id
#}