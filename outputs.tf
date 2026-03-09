# Physical Connection Outputs
output "physical_connection_id" {
  description = "The ID of the physical connection"
  value       = var.create_physical_connection ? alicloud_express_connect_physical_connection.physical_connection[0].id : null
}

# Virtual Border Router Outputs
output "virtual_border_router_id" {
  description = "The ID of the virtual border router"
  value       = var.create_virtual_border_router ? alicloud_express_connect_virtual_border_router.virtual_border_router[0].id : null
}

output "virtual_border_router_route_table_id" {
  description = "The route table ID of the virtual border router"
  value       = var.create_virtual_border_router ? alicloud_express_connect_virtual_border_router.virtual_border_router[0].route_table_id : null
}

# Router Interface Outputs
output "router_interface_id" {
  description = "The ID of the router interface"
  value       = var.create_router_interface ? alicloud_express_connect_router_interface.router_interface[0].id : null
}

# BGP Group Outputs
output "bgp_group_id" {
  description = "The ID of the BGP group"
  value       = var.create_bgp_group ? alicloud_vpc_bgp_group.bgp_group[0].id : null
}

# BGP Peer Outputs
output "bgp_peer_id" {
  description = "The ID of the BGP peer"
  value       = var.create_bgp_peer ? alicloud_vpc_bgp_peer.bgp_peer[0].id : null
}

# Express Connect Router Outputs
output "express_connect_router_id" {
  description = "The ID of the Express Connect Router"
  value       = var.create_express_connect_router ? alicloud_express_connect_router_express_connect_router.express_connect_router[0].id : null
}