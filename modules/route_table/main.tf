resource "aws_route_table" "public_table" {
  vpc_id = var.public_route_table_tags["vpc_id"]
  tags = {
    Name = var.public_route_table_tags["name"]
  }
}

resource "aws_route" "public_route" {
  route_table_id         = var.public_route["route_table_id"]
  destination_cidr_block = var.public_route["cidr_block"]
  gateway_id             = var.public_route["gateway_id"]
}



# resource "aws_route_table_association" "public_subnet_association" {
#   subnet_id      = var.public_route_table_association["subnet_id"]
#   route_table_id = var.public_route_table_association["route_table_id"]
# }