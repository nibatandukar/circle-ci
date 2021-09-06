output "vpc_id" {
  description = "The VPC ID"
  value       = join("", aws_vpc.this[*].id)
}

output "vpc_arn" {
  description = "The VPC ARN"
  value       = join("", aws_vpc.this[*].arn)
}

output "public_subnets_id" {
  description = "List of public subnet ID"
  value       = aws_subnet.public[*].id
}

output "public_route_tables_id" {
  description = "List of public route tables ID"
  value       = aws_route_table.public[*].id
}

output "private_route_tables_id" {
  description = "List of private route tables ID"
  value       = aws_route_table.private[*].id
}

output "private_subnets_id" {
  description = "List of private subnet ID"
  value       = aws_subnet.private[*].id
}
