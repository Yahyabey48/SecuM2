//Déclaration du VPC 

resource "aws_vpc" "GRP6AYYSRC1" {
  cidr_block = "10.80.0.0/16"
}

//Déclartion du Subnet Public

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.GRP6AYYSRC1.id
  cidr_block              = "10.80.1.0/24"
  map_public_ip_on_launch = true  # Attribue automatiquement une IP publique aux instances
}

//Déclaration de Gateway Internet 

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.GRP6AYYSRC1.id

  }

//Déclaration de la RouteTable

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.GRP6AYYSRC1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}




