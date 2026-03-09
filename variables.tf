# Physical Connection Configuration
variable "create_physical_connection" {
  type        = bool
  description = "Whether to create a physical connection"
  default     = false
}

variable "physical_connection_id" {
  type        = string
  description = "ID of an existing physical connection. Required when create_physical_connection is false"
  default     = null
}

variable "physical_connection_config" {
  type = object({
    access_point_id          = string
    line_operator            = string
    peer_location            = optional(string, null)
    physical_connection_name = optional(string, null)
    type                     = optional(string, "VPC")
    description              = optional(string, null)
    port_type                = optional(string, null)
    bandwidth                = optional(number, null)
    circuit_code             = optional(string, null)
    period                   = optional(number, null)
    pricing_cycle            = optional(string, "Month")
    status                   = optional(string, null)
  })
  description = "Configuration for physical connection. The attributes 'access_point_id' and 'line_operator' are required"
  default = {
    access_point_id = null
    line_operator   = null
  }
}

# Virtual Border Router Configuration
variable "create_virtual_border_router" {
  type        = bool
  description = "Whether to create a virtual border router"
  default     = false
}

variable "virtual_border_router_id" {
  type        = string
  description = "ID of an existing virtual border router. Required when create_virtual_border_router is false"
  default     = null
}

variable "virtual_border_router_config" {
  type = object({
    local_gateway_ip           = string
    peer_gateway_ip            = string
    peering_subnet_mask        = string
    virtual_border_router_name = optional(string, null)
    vlan_id                    = number
    bandwidth                  = optional(number, null)
    circuit_code               = optional(string, null)
    description                = optional(string, null)
    detect_multiplier          = optional(number, 10)
    enable_ipv6                = optional(bool, false)
    local_ipv6_gateway_ip      = optional(string, null)
    min_rx_interval            = optional(number, 1000)
    min_tx_interval            = optional(number, 1000)
    mtu                        = optional(number, null)
    peer_ipv6_gateway_ip       = optional(string, null)
    peering_ipv6_subnet_mask   = optional(string, null)
    resource_group_id          = optional(string, null)
    sitelink_enable            = optional(bool, null)
    status                     = optional(string, null)
    tags                       = optional(map(string), {})
    vbr_owner_id               = optional(string, null)
  })
  description = "Configuration for virtual border router. The attributes 'local_gateway_ip', 'peer_gateway_ip', 'peering_subnet_mask', and 'vlan_id' are required"
  default = {
    local_gateway_ip    = null
    peer_gateway_ip     = null
    peering_subnet_mask = null
    vlan_id             = null
  }
}

# Router Interface Configuration
variable "create_router_interface" {
  type        = bool
  description = "Whether to create a router interface"
  default     = false
}

variable "router_interface_config" {
  type = object({
    router_type                 = string
    role                        = string
    spec                        = string
    opposite_region_id          = string
    opposite_router_type        = optional(string, null)
    opposite_router_id          = optional(string, null)
    opposite_interface_owner_id = optional(string, null)
    access_point_id             = optional(string, null)
    auto_renew                  = optional(bool, false)
    description                 = optional(string, null)
    fast_link_mode              = optional(bool, false)
    hc_rate                     = optional(number, null)
    hc_threshold                = optional(number, null)
    health_check_source_ip      = optional(string, null)
    health_check_target_ip      = optional(string, null)
    opposite_access_point_id    = optional(string, null)
    payment_type                = optional(string, "PayAsYouGo")
    period                      = optional(number, null)
    pricing_cycle               = optional(string, "Month")
    resource_group_id           = optional(string, null)
    router_interface_name       = optional(string, null)
    status                      = optional(string, null)
    tags                        = optional(map(string), {})
  })
  description = "Configuration for router interface. The attributes 'router_type', 'role', 'spec', and 'opposite_region_id' are required"
  default = {
    router_type        = null
    role               = null
    spec               = null
    opposite_region_id = null
  }
}

# BGP Group Configuration
variable "create_bgp_group" {
  type        = bool
  description = "Whether to create a BGP group"
  default     = false
}

variable "bgp_group_id" {
  type        = string
  description = "ID of an existing BGP group. Required when create_bgp_group is false"
  default     = null
}

variable "bgp_group_config" {
  type = object({
    peer_asn       = number
    auth_key       = optional(string, null)
    bgp_group_name = optional(string, null)
    clear_auth_key = optional(bool, false)
    description    = optional(string, null)
    ip_version     = optional(string, "IPv4")
    is_fake_asn    = optional(bool, false)
    local_asn      = optional(number, 45104)
    route_limit    = optional(number, 110)
  })
  description = "Configuration for BGP group. The attribute 'peer_asn' is required"
  default = {
    peer_asn = null
  }
}

# BGP Peer Configuration
variable "create_bgp_peer" {
  type        = bool
  description = "Whether to create a BGP peer"
  default     = false
}

variable "bgp_peer_config" {
  type = object({
    peer_ip_address = optional(string, null)
    bfd_multi_hop   = optional(string, null)
    enable_bfd      = optional(bool, false)
    ip_version      = optional(string, "IPV4")
  })
  description = "Configuration for BGP peer"
  default     = {}
}

# Express Connect Router Configuration
variable "create_express_connect_router" {
  type        = bool
  description = "Whether to create an Express Connect Router"
  default     = false
}

variable "express_connect_router_config" {
  type = object({
    alibaba_side_asn  = string
    description       = optional(string, null)
    ecr_name          = optional(string, null)
    resource_group_id = optional(string, null)
    tags              = optional(map(string), {})
    regions = optional(list(object({
      region_id    = optional(string, null)
      transit_mode = optional(string, null)
    })), [])
  })
  description = "Configuration for Express Connect Router. The attribute 'alibaba_side_asn' is required"
  default = {
    alibaba_side_asn = null
  }
}