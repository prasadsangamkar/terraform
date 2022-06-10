resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "dev1" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dev1"
  }
}

resource "aws_subnet" "dev2" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "dev2"
  }
}

resource "aws_subnet" "dev3" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "dev3"
  }
}

resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "dev"
  }
}

resource "aws_route_table" "dev" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
  }

  tags = {
    Name = "dev"
  }
}


resource "aws_route_table_association" "dev" {
  subnet_id      = aws_subnet.dev1.id
  route_table_id = aws_route_table.dev.id
}

resource "aws_network_interface" "dev" {
  subnet_id       = aws_subnet.dev1.id

}

resource "aws_eip" "dev" {
  vpc                       = true
}

resource "aws_nat_gateway" "dev" {
  allocation_id = aws_eip.dev.id
  subnet_id     = aws_subnet.dev1.id

  tags = {
    Name = "DEV"
  }

}

resource "aws_route_table" "dev_nat" {
   vpc_id = aws_vpc.dev.id
 
   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_nat_gateway.dev.id
   }
 
   tags = {
     Name = "dev_nat"
   }
 }


resource "aws_route_table_association" "dev_nat" {
   subnet_id      = aws_subnet.dev2.id
   route_table_id = aws_route_table.dev_nat.id
 }
