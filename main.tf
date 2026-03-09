# Physical Connection
resource "alicloud_express_connect_physical_connection" "physical_connection" {
  count = var.create_physical_connection ? 1 : 0

  access_point_id          = var.physical_connection_config.access_point_id
  line_operator            = var.physical_connection_config.line_operator
  peer_location            = var.physical_connection_config.peer_location
  physical_connection_name = var.physical_connection_config.physical_connection_name
  type                     = var.physical_connection_config.type
  description              = var.physical_connection_config.description
  port_type                = var.physical_connection_config.port_type
  bandwidth                = var.physical_connection_config.bandwidth
  circuit_code             = var.physical_connection_config.circuit_code
  period                   = var.physical_connection_config.period
  pricing_cycle            = var.physical_connection_config.pricing_cycle
  status                   = var.physical_connection_config.status
}

# Virtual Border Router
resource "alicloud_express_connect_virtual_border_router" "virtual_border_router" {
  count = var.create_virtual_border_router ? 1 : 0

  physical_connection_id     = var.create_physical_connection ? alicloud_express_connect_physical_connection.physical_connection[0].id : var.physical_connection_id
  local_gateway_ip           = var.virtual_border_router_config.local_gateway_ip
  peer_gateway_ip            = var.virtual_border_router_config.peer_gateway_ip
  peering_subnet_mask        = var.virtual_border_router_config.peering_subnet_mask
  virtual_border_router_name = var.virtual_border_router_config.virtual_border_router_name
  vlan_id                    = var.virtual_border_router_config.vlan_id
  bandwidth                  = var.virtual_border_router_config.bandwidth
  circuit_code               = var.virtual_border_router_config.circuit_code
  description                = var.virtual_border_router_config.description
  detect_multiplier          = var.virtual_border_router_config.detect_multiplier
  enable_ipv6                = var.virtual_border_router_config.enable_ipv6
  local_ipv6_gateway_ip      = var.virtual_border_router_config.local_ipv6_gateway_ip
  min_rx_interval            = var.virtual_border_router_config.min_rx_interval
  min_tx_interval            = var.virtual_border_router_config.min_tx_interval
  mtu                        = var.virtual_border_router_config.mtu
  peer_ipv6_gateway_ip       = var.virtual_border_router_config.peer_ipv6_gateway_ip
  peering_ipv6_subnet_mask   = var.virtual_border_router_config.peering_ipv6_subnet_mask
  resource_group_id          = var.virtual_border_router_config.resource_group_id
  sitelink_enable            = var.virtual_border_router_config.sitelink_enable
  status                     = var.virtual_border_router_config.status
  tags                       = var.virtual_border_router_config.tags
  vbr_owner_id               = var.virtual_border_router_config.vbr_owner_id
}

# Router Interface
resource "alicloud_express_connect_router_interface" "router_interface" {
  count = var.create_router_interface ? 1 : 0

  router_id                   = var.create_virtual_border_router ? alicloud_express_connect_virtual_border_router.virtual_border_router[0].id : var.virtual_border_router_id
  router_type                 = var.router_interface_config.router_type
  role                        = var.router_interface_config.role
  spec                        = var.router_interface_config.spec
  opposite_region_id          = var.router_interface_config.opposite_region_id
  opposite_router_type        = var.router_interface_config.opposite_router_type
  opposite_router_id          = var.router_interface_config.opposite_router_id
  opposite_interface_owner_id = var.router_interface_config.opposite_interface_owner_id
  access_point_id             = var.router_interface_config.access_point_id
  auto_renew                  = var.router_interface_config.auto_renew
  description                 = var.router_interface_config.description
  fast_link_mode              = var.router_interface_config.fast_link_mode
  hc_rate                     = var.router_interface_config.hc_rate
  hc_threshold                = var.router_interface_config.hc_threshold
  health_check_source_ip      = var.router_interface_config.health_check_source_ip
  health_check_target_ip      = var.router_interface_config.health_check_target_ip
  opposite_access_point_id    = var.router_interface_config.opposite_access_point_id
  payment_type                = var.router_interface_config.payment_type
  period                      = var.router_interface_config.period
  pricing_cycle               = var.router_interface_config.pricing_cycle
  resource_group_id           = var.router_interface_config.resource_group_id
  router_interface_name       = var.router_interface_config.router_interface_name
  status                      = var.router_interface_config.status
  tags                        = var.router_interface_config.tags
}

# BGP Group
resource "alicloud_vpc_bgp_group" "bgp_group" {
  count = var.create_bgp_group ? 1 : 0

  router_id      = var.create_virtual_border_router ? alicloud_express_connect_virtual_border_router.virtual_border_router[0].id : var.virtual_border_router_id
  peer_asn       = var.bgp_group_config.peer_asn
  auth_key       = var.bgp_group_config.auth_key
  bgp_group_name = var.bgp_group_config.bgp_group_name
  clear_auth_key = var.bgp_group_config.clear_auth_key
  description    = var.bgp_group_config.description
  ip_version     = var.bgp_group_config.ip_version
  is_fake_asn    = var.bgp_group_config.is_fake_asn
  local_asn      = var.bgp_group_config.local_asn
  route_limit    = var.bgp_group_config.route_limit
}

# BGP Peer
resource "alicloud_vpc_bgp_peer" "bgp_peer" {
  count = var.create_bgp_peer ? 1 : 0

  bgp_group_id    = var.create_bgp_group ? alicloud_vpc_bgp_group.bgp_group[0].id : var.bgp_group_id
  peer_ip_address = var.bgp_peer_config.peer_ip_address
  bfd_multi_hop   = var.bgp_peer_config.bfd_multi_hop
  enable_bfd      = var.bgp_peer_config.enable_bfd
  ip_version      = var.bgp_peer_config.ip_version
}

# Express Connect Router
resource "alicloud_express_connect_router_express_connect_router" "express_connect_router" {
  count = var.create_express_connect_router ? 1 : 0

  alibaba_side_asn  = var.express_connect_router_config.alibaba_side_asn
  description       = var.express_connect_router_config.description
  ecr_name          = var.express_connect_router_config.ecr_name
  resource_group_id = var.express_connect_router_config.resource_group_id
  tags              = var.express_connect_router_config.tags

  dynamic "regions" {
    for_each = var.express_connect_router_config.regions
    content {
      region_id    = regions.value.region_id
      transit_mode = regions.value.transit_mode
    }
  }
}