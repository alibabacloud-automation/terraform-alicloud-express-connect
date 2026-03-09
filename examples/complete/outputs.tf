output "virtual_border_router_id" {
  description = "The ID of the virtual border router"
  value       = module.express_connect.virtual_border_router_id
}

output "virtual_border_router_route_table_id" {
  description = "The route table ID of the virtual border router"
  value       = module.express_connect.virtual_border_router_route_table_id
}

output "bgp_group_id" {
  description = "The ID of the BGP group"
  value       = module.express_connect.bgp_group_id
}

output "bgp_peer_id" {
  description = "The ID of the BGP peer"
  value       = module.express_connect.bgp_peer_id
}

output "router_interface_id" {
  description = "The ID of the router interface"
  value       = module.express_connect.router_interface_id
}

output "express_connect_router_id" {
  description = "The ID of the Express Connect Router"
  value       = module.express_connect.express_connect_router_id
}