

output "new_rt_table_id" {
  description = "route_table_id"
  value = var.create_rt_table == true ? aws_route_table.new[0].id : var.existing_rt_table_id
}



