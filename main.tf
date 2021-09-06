data "aws_availability_zones" "this" {}

resource "aws_vpc" "this" {
  count      = var.enable ? 1 : 0
  cidr_block = var.vpc_cidr_block
  tags       = var.tags
}

resource "aws_internet_gateway" "this" {
  count  = var.enable ? 1 : 0
  vpc_id = join("", aws_vpc.this[*].id)
  tags   = var.tags
}

resource "aws_subnet" "public" {
  count             = var.enable ? length(var.public_subnet_cidr_blocks) : 0
  vpc_id            = join("", aws_vpc.this[*].id)
  availability_zone = sort(data.aws_availability_zones.this.names)[count.index]
  cidr_block        = sort(var.public_subnet_cidr_blocks)[count.index]
  tags              = var.tags
}

resource "aws_route_table" "public" {
  count  = var.enable ? length(var.public_subnet_cidr_blocks) : 0
  vpc_id = join("", aws_vpc.this[*].id)

  route {
	cidr_block = "0.0.0.0/0"
	gateway_id = join("", aws_internet_gateway.this[*].id)
  }

  tags = var.tags
}

resource "aws_route_table_association" "public" {
  count          = var.enable ? length(var.public_subnet_cidr_blocks) : 0
  route_table_id = aws_route_table.public[count.index].id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_subnet" "private" {
  count             = var.enable ? length(var.private_subnet_cidr_blocks) : 0
  vpc_id            = join("", aws_vpc.this[*].id)
  availability_zone = sort(data.aws_availability_zones.this.names)[count.index]
  cidr_block        = sort(var.private_subnet_cidr_blocks)[count.index]
  tags              = var.tags
}

resource "aws_route_table" "private" {
  count  = var.enable ? length(var.private_subnet_cidr_blocks) : 0
  vpc_id = join("", aws_vpc.this[*].id)
  tags   = var.tags
}

resource "aws_route_table_association" "private" {
  count          = var.enable ? length(var.private_subnet_cidr_blocks) : 0
  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}

resource "aws_default_route_table" "this" {
  count                  = var.enable ? 1 : 0
  default_route_table_id = join("", aws_vpc.this[*].default_route_table_id)
  tags                   = var.tags
}
