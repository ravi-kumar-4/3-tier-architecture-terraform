resource "aws_route_table" "public_route_table" {
  # count = length(var.public_subnet_list)
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "public_route_table"
  }
}
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  count = length(var.private_subnet_list)
  tags = {
    Name = "private_route_table${count.index + 1}"
  }
}

resource "aws_route_table" "aws_bostion_route_table" {
  vpc_id = aws_vpc.my_vpc.id
    tags = {
    Name = "bostion_route_table_s3"
  }
}

####### Route Table Association ######

resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnet_list)
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id

}

resource "aws_route_table_association" "private_association" {
  count          = length(var.private_subnet_list)
  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}


resource "aws_route_table_association" "bostion_associations" {
  route_table_id = aws_route_table.aws_bostion_route_table.id
  subnet_id = aws_subnet.bostion_subnet.id
}
######## routes #######
resource "aws_route" "public_routes" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "bostion_routes" {
  route_table_id         = aws_route_table.aws_bostion_route_table.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_route" {
  count                  = length(var.private_subnet_list)
  route_table_id         = aws_route_table.private_route_table[count.index].id
  nat_gateway_id         = aws_nat_gateway.my_nat[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}


