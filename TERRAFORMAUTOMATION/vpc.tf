# Create VPC
resource "aws_vpc" "multi_tenant_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MultiTenant-VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.multi_tenant_vpc.id
  tags = {
    Name = "MultiTenant-IGW"
  }
}

# Public Subnet for TenantA
resource "aws_subnet" "tenant_a_subnet" {
  vpc_id                  = aws_vpc.multi_tenant_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name   = "TenantA-Subnet"
    Tenant = "TenantA"
  }
}

# Public Subnet for TenantB
resource "aws_subnet" "tenant_b_subnet" {
  vpc_id                  = aws_vpc.multi_tenant_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name   = "TenantB-Subnet"
    Tenant = "TenantB"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.multi_tenant_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "MultiTenant-Public-RT"
  }
}

# Associate Subnets to Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.tenant_a_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.tenant_b_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
