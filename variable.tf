variable "vpc_id" {
  description = "vpc id"
  type    = string
  default = ""
}

variable "create_rt_table" {
  description = "to create a new route table"
  type    = bool
  default = false
}

variable "rt_table_name" {
  description = "new route table name"
  type    = string
  default = ""
}

variable "existing_rt_table_id" {
  description = "existing route table id"
  type    = string
  default = ""
}

variable "routes" {
  description = "route entries value"
  type = list(object({
    destination_cidr_block      = optional(string)
    destination_ipv6_cidr_block = optional(string)
    gw_id                      = optional(string) # igw_id or vgw_id
    nic_id                      = optional(string)
    eogw_id                     = optional(string)
    ngw_id                      = optional(string)
    tgw_id                      = optional(string)
    vpc_e_id                    = optional(string)
    vpc_p_id                    = optional(string)
  }))
  default = [{}]
}