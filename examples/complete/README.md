# Complete Example

This example demonstrates how to use the Express Connect module to create a complete Express Connect setup including Virtual Border Router, BGP Group, and BGP Peer.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| alicloud | >= 1.132.0 |

## Providers

| Name | Version |
|------|---------|
| alicloud | >= 1.132.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | The region where resources will be created | `string` | `"cn-hangzhou"` | no |
| local_gateway_ip | The IPv4 address on the Alibaba Cloud side of the VBR instance | `string` | `"10.0.0.1"` | no |
| peer_gateway_ip | The IPv4 address of the client side of the VBR instance | `string` | `"10.0.0.2"` | no |
| peering_subnet_mask | The subnet masks of the Alibaba Cloud-side IPv4 and the customer-side IPv4 of the VBR instance | `string` | `"255.255.255.252"` | no |
| virtual_border_router_name | The name of the VBR instance | `string` | `"example-vbr"` | no |
| vlan_id | The VLAN ID of the VBR instance | `number` | `1001` | no |
| bgp_peer_asn | The ASN of the gateway device in the data center | `number` | `65001` | no |
| bgp_auth_key | The authentication key of the BGP group | `string` | `"YourPassword+12345678"` | no |
| bgp_group_name | The name of the BGP group | `string` | `"example-bgp-group"` | no |
| bgp_peer_ip_address | The IP address of the BGP peer | `string` | `"192.168.1.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| virtual_border_router_id | The ID of the virtual border router |
| virtual_border_router_name | The name of the virtual border router |
| bgp_group_id | The ID of the BGP group |
| bgp_peer_id | The ID of the BGP peer |