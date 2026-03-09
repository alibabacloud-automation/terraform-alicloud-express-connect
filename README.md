Alibaba Cloud Express Connect Terraform Module

# terraform-alicloud-express-connect

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-express-connect/blob/main/README-CN.md)

This Terraform module creates and manages Express Connect resources on Alibaba Cloud, including Physical Connections, Virtual Border Routers (VBR), Router Interfaces, BGP Groups, and BGP Peers. Express Connect provides dedicated network connections between on-premises data centers and Alibaba Cloud, enabling hybrid cloud architectures with high performance and reliability. For more information about Express Connect solutions, see [Express Connect](https://www.alibabacloud.com/product/express-connect).

## Usage

This module provides a flexible way to create Express Connect resources. You can use it to establish dedicated connections between your on-premises infrastructure and Alibaba Cloud VPCs.

```terraform
data "alicloud_express_connect_physical_connections" "example" {
  name_regex = "^preserved-NODELETING"
}

module "express_connect" {
  source = "alibabacloud-automation/express-connect/alicloud"

  # Virtual Border Router configuration
  create_virtual_border_router = true
  physical_connection_id       = data.alicloud_express_connect_physical_connections.example.connections[0].id
  virtual_border_router_config = {
    local_gateway_ip           = "10.0.0.1"
    peer_gateway_ip            = "10.0.0.2"
    peering_subnet_mask        = "255.255.255.252"
    virtual_border_router_name = "example-vbr"
    vlan_id                    = 1001
    min_rx_interval            = 1000
    min_tx_interval            = 1000
    detect_multiplier          = 10
  }

  # BGP Group configuration
  create_bgp_group = true
  bgp_group_config = {
    peer_asn       = 65001
    auth_key       = "YourPassword+12345678"
    bgp_group_name = "example-bgp-group"
    description    = "Example BGP group for Express Connect"
    is_fake_asn    = true
  }

  # BGP Peer configuration
  create_bgp_peer = true
  bgp_peer_config = {
    peer_ip_address = "192.168.1.1"
    enable_bfd      = true
    bfd_multi_hop   = "10"
    ip_version      = "IPV4"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-express-connect/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.132.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.132.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_express_connect_physical_connection.physical_connection](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_physical_connection) | resource |
| [alicloud_express_connect_router_express_connect_router.express_connect_router](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_router_express_connect_router) | resource |
| [alicloud_express_connect_router_interface.router_interface](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_router_interface) | resource |
| [alicloud_express_connect_virtual_border_router.virtual_border_router](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_virtual_border_router) | resource |
| [alicloud_vpc_bgp_group.bgp_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_bgp_group) | resource |
| [alicloud_vpc_bgp_peer.bgp_peer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_bgp_peer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_group_config"></a> [bgp\_group\_config](#input\_bgp\_group\_config) | Configuration for BGP group. The attribute 'peer\_asn' is required | <pre>object({<br>    peer_asn       = number<br>    auth_key       = optional(string, null)<br>    bgp_group_name = optional(string, null)<br>    clear_auth_key = optional(bool, false)<br>    description    = optional(string, null)<br>    ip_version     = optional(string, "IPv4")<br>    is_fake_asn    = optional(bool, false)<br>    local_asn      = optional(number, 45104)<br>    route_limit    = optional(number, 110)<br>  })</pre> | <pre>{<br>  "peer_asn": null<br>}</pre> | no |
| <a name="input_bgp_group_id"></a> [bgp\_group\_id](#input\_bgp\_group\_id) | ID of an existing BGP group. Required when create\_bgp\_group is false | `string` | `null` | no |
| <a name="input_bgp_peer_config"></a> [bgp\_peer\_config](#input\_bgp\_peer\_config) | Configuration for BGP peer | <pre>object({<br>    peer_ip_address = optional(string, null)<br>    bfd_multi_hop   = optional(string, null)<br>    enable_bfd      = optional(bool, false)<br>    ip_version      = optional(string, "IPV4")<br>  })</pre> | `{}` | no |
| <a name="input_create_bgp_group"></a> [create\_bgp\_group](#input\_create\_bgp\_group) | Whether to create a BGP group | `bool` | `false` | no |
| <a name="input_create_bgp_peer"></a> [create\_bgp\_peer](#input\_create\_bgp\_peer) | Whether to create a BGP peer | `bool` | `false` | no |
| <a name="input_create_express_connect_router"></a> [create\_express\_connect\_router](#input\_create\_express\_connect\_router) | Whether to create an Express Connect Router | `bool` | `false` | no |
| <a name="input_create_physical_connection"></a> [create\_physical\_connection](#input\_create\_physical\_connection) | Whether to create a physical connection | `bool` | `false` | no |
| <a name="input_create_router_interface"></a> [create\_router\_interface](#input\_create\_router\_interface) | Whether to create a router interface | `bool` | `false` | no |
| <a name="input_create_virtual_border_router"></a> [create\_virtual\_border\_router](#input\_create\_virtual\_border\_router) | Whether to create a virtual border router | `bool` | `false` | no |
| <a name="input_express_connect_router_config"></a> [express\_connect\_router\_config](#input\_express\_connect\_router\_config) | Configuration for Express Connect Router. The attribute 'alibaba\_side\_asn' is required | <pre>object({<br>    alibaba_side_asn  = string<br>    description       = optional(string, null)<br>    ecr_name          = optional(string, null)<br>    resource_group_id = optional(string, null)<br>    tags              = optional(map(string), {})<br>    regions = optional(list(object({<br>      region_id    = optional(string, null)<br>      transit_mode = optional(string, null)<br>    })), [])<br>  })</pre> | <pre>{<br>  "alibaba_side_asn": null<br>}</pre> | no |
| <a name="input_physical_connection_config"></a> [physical\_connection\_config](#input\_physical\_connection\_config) | Configuration for physical connection. The attributes 'access\_point\_id' and 'line\_operator' are required | <pre>object({<br>    access_point_id          = string<br>    line_operator            = string<br>    peer_location            = optional(string, null)<br>    physical_connection_name = optional(string, null)<br>    type                     = optional(string, "VPC")<br>    description              = optional(string, null)<br>    port_type                = optional(string, null)<br>    bandwidth                = optional(number, null)<br>    circuit_code             = optional(string, null)<br>    period                   = optional(number, null)<br>    pricing_cycle            = optional(string, "Month")<br>    status                   = optional(string, null)<br>  })</pre> | <pre>{<br>  "access_point_id": null,<br>  "line_operator": null<br>}</pre> | no |
| <a name="input_physical_connection_id"></a> [physical\_connection\_id](#input\_physical\_connection\_id) | ID of an existing physical connection. Required when create\_physical\_connection is false | `string` | `null` | no |
| <a name="input_router_interface_config"></a> [router\_interface\_config](#input\_router\_interface\_config) | Configuration for router interface. The attributes 'router\_type', 'role', 'spec', and 'opposite\_region\_id' are required | <pre>object({<br>    router_type                 = string<br>    role                        = string<br>    spec                        = string<br>    opposite_region_id          = string<br>    opposite_router_type        = optional(string, null)<br>    opposite_router_id          = optional(string, null)<br>    opposite_interface_owner_id = optional(string, null)<br>    access_point_id             = optional(string, null)<br>    auto_renew                  = optional(bool, false)<br>    description                 = optional(string, null)<br>    fast_link_mode              = optional(bool, false)<br>    hc_rate                     = optional(number, null)<br>    hc_threshold                = optional(number, null)<br>    health_check_source_ip      = optional(string, null)<br>    health_check_target_ip      = optional(string, null)<br>    opposite_access_point_id    = optional(string, null)<br>    payment_type                = optional(string, "PayAsYouGo")<br>    period                      = optional(number, null)<br>    pricing_cycle               = optional(string, "Month")<br>    resource_group_id           = optional(string, null)<br>    router_interface_name       = optional(string, null)<br>    status                      = optional(string, null)<br>    tags                        = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "opposite_region_id": null,<br>  "role": null,<br>  "router_type": null,<br>  "spec": null<br>}</pre> | no |
| <a name="input_virtual_border_router_config"></a> [virtual\_border\_router\_config](#input\_virtual\_border\_router\_config) | Configuration for virtual border router. The attributes 'local\_gateway\_ip', 'peer\_gateway\_ip', 'peering\_subnet\_mask', and 'vlan\_id' are required | <pre>object({<br>    local_gateway_ip           = string<br>    peer_gateway_ip            = string<br>    peering_subnet_mask        = string<br>    virtual_border_router_name = optional(string, null)<br>    vlan_id                    = number<br>    bandwidth                  = optional(number, null)<br>    circuit_code               = optional(string, null)<br>    description                = optional(string, null)<br>    detect_multiplier          = optional(number, 10)<br>    enable_ipv6                = optional(bool, false)<br>    local_ipv6_gateway_ip      = optional(string, null)<br>    min_rx_interval            = optional(number, 1000)<br>    min_tx_interval            = optional(number, 1000)<br>    mtu                        = optional(number, null)<br>    peer_ipv6_gateway_ip       = optional(string, null)<br>    peering_ipv6_subnet_mask   = optional(string, null)<br>    resource_group_id          = optional(string, null)<br>    sitelink_enable            = optional(bool, null)<br>    status                     = optional(string, null)<br>    tags                       = optional(map(string), {})<br>    vbr_owner_id               = optional(string, null)<br>  })</pre> | <pre>{<br>  "local_gateway_ip": null,<br>  "peer_gateway_ip": null,<br>  "peering_subnet_mask": null,<br>  "vlan_id": null<br>}</pre> | no |
| <a name="input_virtual_border_router_id"></a> [virtual\_border\_router\_id](#input\_virtual\_border\_router\_id) | ID of an existing virtual border router. Required when create\_virtual\_border\_router is false | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bgp_group_id"></a> [bgp\_group\_id](#output\_bgp\_group\_id) | The ID of the BGP group |
| <a name="output_bgp_group_name"></a> [bgp\_group\_name](#output\_bgp\_group\_name) | The name of the BGP group |
| <a name="output_bgp_group_status"></a> [bgp\_group\_status](#output\_bgp\_group\_status) | The status of the BGP group |
| <a name="output_bgp_peer_id"></a> [bgp\_peer\_id](#output\_bgp\_peer\_id) | The ID of the BGP peer |
| <a name="output_bgp_peer_name"></a> [bgp\_peer\_name](#output\_bgp\_peer\_name) | The name of the BGP peer |
| <a name="output_bgp_peer_status"></a> [bgp\_peer\_status](#output\_bgp\_peer\_status) | The status of the BGP peer |
| <a name="output_express_connect_router_create_time"></a> [express\_connect\_router\_create\_time](#output\_express\_connect\_router\_create\_time) | The creation time of the Express Connect Router |
| <a name="output_express_connect_router_id"></a> [express\_connect\_router\_id](#output\_express\_connect\_router\_id) | The ID of the Express Connect Router |
| <a name="output_express_connect_router_name"></a> [express\_connect\_router\_name](#output\_express\_connect\_router\_name) | The name of the Express Connect Router |
| <a name="output_express_connect_router_status"></a> [express\_connect\_router\_status](#output\_express\_connect\_router\_status) | The status of the Express Connect Router |
| <a name="output_physical_connection_id"></a> [physical\_connection\_id](#output\_physical\_connection\_id) | The ID of the physical connection |
| <a name="output_physical_connection_name"></a> [physical\_connection\_name](#output\_physical\_connection\_name) | The name of the physical connection |
| <a name="output_physical_connection_status"></a> [physical\_connection\_status](#output\_physical\_connection\_status) | The status of the physical connection |
| <a name="output_router_interface_bandwidth"></a> [router\_interface\_bandwidth](#output\_router\_interface\_bandwidth) | The bandwidth of the router interface |
| <a name="output_router_interface_id"></a> [router\_interface\_id](#output\_router\_interface\_id) | The ID of the router interface |
| <a name="output_router_interface_name"></a> [router\_interface\_name](#output\_router\_interface\_name) | The name of the router interface |
| <a name="output_router_interface_status"></a> [router\_interface\_status](#output\_router\_interface\_status) | The status of the router interface |
| <a name="output_virtual_border_router_id"></a> [virtual\_border\_router\_id](#output\_virtual\_border\_router\_id) | The ID of the virtual border router |
| <a name="output_virtual_border_router_name"></a> [virtual\_border\_router\_name](#output\_virtual\_border\_router\_name) | The name of the virtual border router |
| <a name="output_virtual_border_router_route_table_id"></a> [virtual\_border\_router\_route\_table\_id](#output\_virtual\_border\_router\_route\_table\_id) | The route table ID of the virtual border router |
| <a name="output_virtual_border_router_vlan_id"></a> [virtual\_border\_router\_vlan\_id](#output\_virtual\_border\_router\_vlan\_id) | The VLAN ID of the virtual border router |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)