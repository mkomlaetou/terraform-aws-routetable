
## Overview

This module manages AWS route tables and route entries. It can create a new route table with specified routes or add routes to an existing route table, based on input variables.

---

## Features

- **Create New Route Table:**
  - Provisions a new AWS route table in a specified VPC.
  - Adds multiple route entries as defined in the `routes` variable.
  - Tags the route table with a custom name.
- **Add Routes to Existing Table:**
  - Adds route entries to an existing route table if creation is not required.

---

## Variables

- `create_rt_table` (`bool`):
  - If `true`, creates a new route table.
  - If `false`, adds routes to an existing table.
- `vpc_id` (`string`):
  - The VPC ID for the new route table.
- `existing_rt_table_id` (`string`):
  - The ID of the existing route table to add routes to.
- `rt_table_name` (`string`):
  - Name tag for the new route table.
- `routes` (`list(map)`):
  - List of route definitions. Each route can specify:
    - `destination_cidr_block`
    - `destination_ipv6_cidr_block`
    - `gw_id` (IGW or VGW ID)
    - `nic_id` (network interface ID)
    - `eogw_id` (egress-only gateway ID)
    - `ngw_id` (NAT gateway ID)
    - `tgw_id` (transit gateway ID)
    - `vpc_e_id` (VPC endpoint ID)
    - `vpc_p_id` (VPC peering connection ID)




## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.new](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_rt_table"></a> [create\_rt\_table](#input\_create\_rt\_table) | to create a new route table | `bool` | `false` | no |
| <a name="input_existing_rt_table_id"></a> [existing\_rt\_table\_id](#input\_existing\_rt\_table\_id) | existing route table id | `string` | `""` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | route entries value | <pre>list(object({<br/>    destination_cidr_block      = optional(string)<br/>    destination_ipv6_cidr_block = optional(string)<br/>    gw_id                      = optional(string) # igw_id or vgw_id<br/>    nic_id                      = optional(string)<br/>    eogw_id                     = optional(string)<br/>    ngw_id                      = optional(string)<br/>    tgw_id                      = optional(string)<br/>    vpc_e_id                    = optional(string)<br/>    vpc_p_id                    = optional(string)<br/>  }))</pre> | <pre>[<br/>  {}<br/>]</pre> | no |
| <a name="input_rt_table_name"></a> [rt\_table\_name](#input\_rt\_table\_name) | new route table name | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_new_rt_table_id"></a> [new\_rt\_table\_id](#output\_new\_rt\_table\_id) | route\_table\_id |


## SAMPLE ROOT MODULE

```hcl

// add route to existing route table "priv_rt"
module "route" {
  source             = "mkomlaetou/routetable/aws"

  existing_rt_table_id = module.vpc-01.vpc_details["priv_rt"]
  routes               = local.routes 
}

// route variable
locals {
  routes = [
    {
      destination_cidr_block = "10.250.250.0/24"
      gw_id                 = module.vpc-01.vpc_details.vgw_id # replace with actual VGW ID
    }
  ]
}


// add new routing table
module "route_table" {
  source             = "mkomlaetou/routetable/aws"

  create_rt_table      = true
  rt_table_name        = "priv-rt-table"
  routes               = var.routes
  vpc_id               = module.vpc-01.vpc_details.vpc_id

}

// route variable
variable "routes" {
  default = [
    {
      destination_cidr_block = "10.250.250.0/24"
      gw_id                 = "vgw-0d2b6c7d6029c577e"  # replace with actual VGW ID
    },
    {
      destination_cidr_block = "10.250.250.0/24"
      tgw_id                 = "tgw-0d2b6c7d6029c577e"  # replace with actual TGW ID
    }
  ]
}

```