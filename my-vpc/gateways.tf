resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_igw"
  }
}

resource "aws_nat_gateway" "my_nat" {
  count         = length(var.private_subnet_list)
  allocation_id = aws_eip.my_eip[count.index].id
  subnet_id     = aws_subnet.private_subnet[count.index].id
  tags={
    Name = "nat_gate_${count.index+1}"
  }
}
resource "aws_eip" "my_eip" {
  depends_on = [ aws_internet_gateway.igw ]
  count = length(var.private_subnet_list)
}
