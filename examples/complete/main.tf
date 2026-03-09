provider "alicloud" {
  region = var.region
}

data "alicloud_express_connect_physical_connections" "example" {
  name_regex = "^preserved-NODELETING"
}

module "express_connect" {
  source = "../../"

  # Virtual Border Router configuration
  create_virtual_border_router = true
  physical_connection_id       = data.alicloud_express_connect_physical_connections.example.connections[0].id
  virtual_border_router_config = {
    local_gateway_ip           = var.local_gateway_ip
    peer_gateway_ip            = var.peer_gateway_ip
    peering_subnet_mask        = var.peering_subnet_mask
    virtual_border_router_name = var.virtual_border_router_name
    vlan_id                    = var.vlan_id
    min_rx_interval            = var.min_rx_interval
    min_tx_interval            = var.min_tx_interval
    detect_multiplier          = var.detect_multiplier
  }

  # BGP Group configuration
  create_bgp_group = true
  bgp_group_config = {
    peer_asn       = var.bgp_peer_asn
    auth_key       = var.bgp_auth_key
    bgp_group_name = var.bgp_group_name
    description    = var.bgp_group_description
    is_fake_asn    = var.bgp_is_fake_asn
  }

  # BGP Peer configuration
  create_bgp_peer = true
  bgp_peer_config = {
    peer_ip_address = var.bgp_peer_ip_address
    enable_bfd      = var.bgp_enable_bfd
    bfd_multi_hop   = var.bgp_bfd_multi_hop
    ip_version      = var.bgp_ip_version
  }

  # Express Connect Router configuration
  create_express_connect_router = true
  express_connect_router_config = {
    alibaba_side_asn = var.ecr_alibaba_side_asn
    ecr_name         = var.ecr_name
    description      = var.ecr_description
    regions          = []
  }
}