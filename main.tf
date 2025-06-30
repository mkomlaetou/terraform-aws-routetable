
# Create a new route table with route entries
resource "aws_route_table" "new" {
  count  = var.create_rt_table ? 1 : 0
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block                = route.value["destination_cidr_block"]
      ipv6_cidr_block           = route.value["destination_ipv6_cidr_block"]
      gateway_id                = route.value["gw_id"] # for igw or vgw
      network_interface_id      = route.value["nic_id"]
      egress_only_gateway_id    = route.value["eogw_id"]
      nat_gateway_id            = route.value["ngw_id"]
      transit_gateway_id        = route.value["tgw_id"]
      vpc_endpoint_id           = route.value["vpc_e_id"]
      vpc_peering_connection_id = route.value["vpc_p_id"]

    }
  }

  tags = {
    Name = var.rt_table_name
  }
}

# Create route entries for existing route table 
resource "aws_route" "existing" {
  for_each = var.create_rt_table ? {} : { for x, route in var.routes : x => route }

  route_table_id = var.existing_rt_table_id

  destination_cidr_block      = each.value["destination_cidr_block"]
  destination_ipv6_cidr_block = each.value["destination_ipv6_cidr_block"]
  gateway_id                  = each.value["gw_id"] # for igw or vgw
  network_interface_id        = each.value["nic_id"]
  egress_only_gateway_id      = each.value["eogw_id"]
  nat_gateway_id              = each.value["ngw_id"]
  transit_gateway_id          = each.value["tgw_id"]
  vpc_endpoint_id             = each.value["vpc_e_id"]
  vpc_peering_connection_id   = each.value["vpc_p_id"]
}

