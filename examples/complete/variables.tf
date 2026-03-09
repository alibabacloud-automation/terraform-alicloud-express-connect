variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "cn-hangzhou"
}

# Virtual Border Router variables
variable "local_gateway_ip" {
  description = "The IPv4 address on the Alibaba Cloud side of the VBR instance"
  type        = string
  default     = "10.0.0.1"
}

variable "peer_gateway_ip" {
  description = "The IPv4 address of the client side of the VBR instance"
  type        = string
  default     = "10.0.0.2"
}

variable "peering_subnet_mask" {
  description = "The subnet masks of the Alibaba Cloud-side IPv4 and the customer-side IPv4 of the VBR instance"
  type        = string
  default     = "255.255.255.252"
}

variable "virtual_border_router_name" {
  description = "The name of the VBR instance"
  type        = string
  default     = "example-vbr"
}

variable "vlan_id" {
  description = "The VLAN ID of the VBR instance"
  type        = number
  default     = 1001
}

variable "min_rx_interval" {
  description = "Configure the receiving interval of BFD packets"
  type        = number
  default     = 1000
}

variable "min_tx_interval" {
  description = "Configure the sending interval of BFD packets"
  type        = number
  default     = 1000
}

variable "detect_multiplier" {
  description = "Multiple of detection time"
  type        = number
  default     = 10
}

# BGP Group variables
variable "bgp_peer_asn" {
  description = "The ASN of the gateway device in the data center"
  type        = number
  default     = 65001
}

variable "bgp_auth_key" {
  description = "The authentication key of the BGP group"
  type        = string
  default     = "YourPassword+12345678"
}

variable "bgp_group_name" {
  description = "The name of the BGP group"
  type        = string
  default     = "example-bgp-group"
}

variable "bgp_group_description" {
  description = "The description of the BGP group"
  type        = string
  default     = "Example BGP group for Express Connect"
}

variable "bgp_is_fake_asn" {
  description = "Specifies whether to use a fake AS number"
  type        = bool
  default     = true
}

# BGP Peer variables
variable "bgp_peer_ip_address" {
  description = "The IP address of the BGP peer"
  type        = string
  default     = "192.168.1.1"
}

variable "bgp_enable_bfd" {
  description = "Specifies whether to enable the Bidirectional Forwarding Detection (BFD) feature"
  type        = bool
  default     = true
}

variable "bgp_bfd_multi_hop" {
  description = "The BFD hop count"
  type        = string
  default     = "10"
}

variable "bgp_ip_version" {
  description = "The IP version"
  type        = string
  default     = "IPV4"
}

# Express Connect Router variables
variable "ecr_alibaba_side_asn" {
  description = "The ASN on the Alibaba Cloud side"
  type        = string
  default     = "65533"
}

variable "ecr_name" {
  description = "The name of the Express Connect Router"
  type        = string
  default     = "example-ecr"
}

variable "ecr_description" {
  description = "The description of the Express Connect Router"
  type        = string
  default     = "Example Express Connect Router"
}