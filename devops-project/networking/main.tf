
# setting up vpc block
resource "aws_vpc" "main_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

# setting up  public subnet
resource "aws_subnet" "public_subnet" {
  count = 2  # Creating two private subnets

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = var.az_public_subnet[count.index]

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


# setting up  private subnet
resource "aws_subnet" "private_subnet" {
  count = 2 
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.cidr_private_subent[count.index]     
  availability_zone = var.az_private_subnet[count.index]
  tags = {         
    Name = var.private_subnet
  }
}

# setting up internet gateway

resource "aws_internet_gateway" "vega_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.ig_name
  }
}

# setting up public route table
resource "aws_route_table" "public_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vega_gw.id
  }

  tags = {
    Name = var.public_subnet_rt_1
  }
}

# route table association with public subnet

resource "aws_route_table_association" "public_subnet_association_rt" {
  count = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet_rt.id
}


# setting up private route table
resource "aws_route_table" "private_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     # gateway_id = aws_internet_gateway.vega_gw.id
#   }

  tags = {
    Name = var.private_subnet_rt_1
  }
}

# route table association with private subnet
resource "aws_route_table_association" "private_subnet_association_rt" {
  count = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_rt.id
}
