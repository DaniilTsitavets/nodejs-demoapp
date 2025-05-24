resource "aws_vpc" "task3_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "task3_vpc"
  }
}

resource "aws_subnet" "task3_public_subnet" {
  count = length(var.public_subnet_cidr_blocks)

  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.subnet_az[count.index % length(var.subnet_az)]
  vpc_id            = aws_vpc.task3_vpc.id

  tags = {
    Name = "task3_public_subnet-${count.index}"
  }
}

resource "aws_subnet" "task3_private_subnet" {
  count = length(var.private_subnet_cidr_blocks)

  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.subnet_az[count.index % length(var.subnet_az)]
  vpc_id            = aws_vpc.task3_vpc.id

  tags = {
    Name = "task3_private_subnet-${count.index}"
  }
}

resource "aws_route_table" "task3_rt" {
  vpc_id = aws_vpc.task3_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task3_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.task3_public_subnet)
  subnet_id      = aws_subnet.task3_public_subnet[count.index].id
  route_table_id = aws_route_table.task3_rt.id
}

resource "aws_internet_gateway" "task3_igw" {
  vpc_id = aws_vpc.task3_vpc.id
  tags = {
    Name = "task3_igw"
  }
}
