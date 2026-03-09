阿里云高速通道 Terraform 模块

# terraform-alicloud-express-connect

[English](https://github.com/alibabacloud-automation/terraform-alicloud-express-connect/blob/main/README.md) | 简体中文

该 Terraform 模块用于在阿里云上创建和管理高速通道资源，包括物理连接、虚拟边界路由器 (VBR)、路由器接口、BGP 组和 BGP 对等体。高速通道提供本地数据中心与阿里云之间的专用网络连接，支持构建高性能、高可靠性的混合云架构。有关高速通道解决方案的更多信息，请参阅 [Express Connect](https://www.alibabacloud.com/product/express-connect)。

## 使用方法

该模块提供了一种灵活的方式来创建高速通道资源。您可以使用它在本地基础设施和阿里云 VPC 之间建立专用连接。

```terraform
data "alicloud_express_connect_physical_connections" "example" {
  name_regex = "^preserved-NODELETING"
}

module "express_connect" {
  source = "alibabacloud-automation/express-connect/alicloud"

  # Virtual Border Router 配置
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

  # BGP 组配置
  create_bgp_group = true
  bgp_group_config = {
    peer_asn       = 65001
    auth_key       = "YourPassword+12345678"
    bgp_group_name = "example-bgp-group"
    description    = "Example BGP group for Express Connect"
    is_fake_asn    = true
  }

  # BGP 对等体配置
  create_bgp_peer = true
  bgp_peer_config = {
    peer_ip_address = "192.168.1.1"
    enable_bfd      = true
    bfd_multi_hop   = "10"
    ip_version      = "IPV4"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-express-connect/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## 要求

| Name | Version |
|------|------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.132.0 |

## 提供商

| Name | Version |
|------|------------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.132.0 |

## 模块

无模块。

## 资源

| Name | Type |
|------|------|
| [alicloud_express_connect_physical_connection.physical_connection](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_physical_connection) | resource |
| [alicloud_express_connect_router_express_connect_router.express_connect_router](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_router_express_connect_router) | resource |
| [alicloud_express_connect_router_interface.router_interface](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_router_interface) | resource |
| [alicloud_express_connect_virtual_border_router.virtual_border_router](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_virtual_border_router) | resource |
| [alicloud_vpc_bgp_group.bgp_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_bgp_group) | resource |
| [alicloud_vpc_bgp_peer.bgp_peer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_bgp_peer) | resource |

## 输入

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_group_config"></a> [bgp\_group\_config](#input\_bgp\_group\_config) | BGP 组配置。属性 'peer\_asn' 是必需的 | <pre>object({<br>    peer_asn       = number<br>    auth_key       = optional(string, null)<br>    bgp_group_name = optional(string, null)<br>    clear_auth_key = optional(bool, false)<br>    description    = optional(string, null)<br>    ip_version     = optional(string, "IPv4")<br>    is_fake_asn    = optional(bool, false)<br>    local_asn      = optional(number, 45104)<br>    route_limit    = optional(number, 110)<br>  })</pre> | <pre>{<br>  "peer_asn": null<br>}</pre> | no |
| <a name="input_bgp_group_id"></a> [bgp\_group\_id](#input\_bgp\_group\_id) | 现有 BGP 组的 ID。当 create\_bgp\_group 为 false 时必需 | `string` | `null` | no |
| <a name="input_bgp_peer_config"></a> [bgp\_peer\_config](#input\_bgp\_peer\_config) | BGP 对等体配置 | <pre>object({<br>    peer_ip_address = optional(string, null)<br>    bfd_multi_hop   = optional(string, null)<br>    enable_bfd      = optional(bool, false)<br>    ip_version      = optional(string, "IPV4")<br>  })</pre> | `{}` | no |
| <a name="input_create_bgp_group"></a> [create\_bgp\_group](#input\_create\_bgp\_group) | 是否创建 BGP 组 | `bool` | `false` | no |
| <a name="input_create_bgp_peer"></a> [create\_bgp\_peer](#input\_create\_bgp\_peer) | 是否创建 BGP 对等体 | `bool` | `false` | no |
| <a name="input_create_express_connect_router"></a> [create\_express\_connect\_router](#input\_create\_express\_connect\_router) | 是否创建 Express Connect Router | `bool` | `false` | no |
| <a name="input_create_physical_connection"></a> [create\_physical\_connection](#input\_create\_physical\_connection) | 是否创建物理连接 | `bool` | `false` | no |
| <a name="input_create_router_interface"></a> [create\_router\_interface](#input\_create\_router\_interface) | 是否创建路由器接口 | `bool` | `false` | no |
| <a name="input_create_virtual_border_router"></a> [create\_virtual\_border\_router](#input\_create\_virtual\_border\_router) | 是否创建虚拟边界路由器 | `bool` | `false` | no |
| <a name="input_express_connect_router_config"></a> [express\_connect\_router\_config](#input\_express\_connect\_router\_config) | Express Connect Router 配置。属性 'alibaba\_side\_asn' 是必需的 | <pre>object({<br>    alibaba_side_asn  = string<br>    description       = optional(string, null)<br>    ecr_name          = optional(string, null)<br>    resource_group_id = optional(string, null)<br>    tags              = optional(map(string), {})<br>    regions = optional(list(object({<br>      region_id    = optional(string, null)<br>      transit_mode = optional(string, null)<br>    })), [])<br>  })</pre> | <pre>{<br>  "alibaba_side_asn": null<br>}</pre> | no |
| <a name="input_physical_connection_config"></a> [physical\_connection\_config](#input\_physical\_connection\_config) | 物理连接配置。属性 'access\_point\_id' 和 'line\_operator' 是必需的 | <pre>object({<br>    access_point_id          = string<br>    line_operator            = string<br>    peer_location            = optional(string, null)<br>    physical_connection_name = optional(string, null)<br>    type                     = optional(string, "VPC")<br>    description              = optional(string, null)<br>    port_type                = optional(string, null)<br>    bandwidth                = optional(number, null)<br>    circuit_code             = optional(string, null)<br>    period                   = optional(number, null)<br>    pricing_cycle            = optional(string, "Month")<br>    status                   = optional(string, null)<br>  })</pre> | <pre>{<br>  "access_point_id": null,<br>  "line_operator": null<br>}</pre> | no |
| <a name="input_physical_connection_id"></a> [physical\_connection\_id](#input\_physical\_connection\_id) | 现有物理连接的 ID。当 create\_physical\_connection 为 false 时必需 | `string` | `null` | no |
| <a name="input_router_interface_config"></a> [router\_interface\_config](#input\_router\_interface\_config) | 路由器接口配置。属性 'router\_type'、'role'、'spec' 和 'opposite\_region\_id' 是必需的 | <pre>object({<br>    router_type                 = string<br>    role                        = string<br>    spec                        = string<br>    opposite_region_id          = string<br>    opposite_router_type        = optional(string, null)<br>    opposite_router_id          = optional(string, null)<br>    opposite_interface_owner_id = optional(string, null)<br>    access_point_id             = optional(string, null)<br>    auto_renew                  = optional(bool, false)<br>    description                 = optional(string, null)<br>    fast_link_mode              = optional(bool, false)<br>    hc_rate                     = optional(number, null)<br>    hc_threshold                = optional(number, null)<br>    health_check_source_ip      = optional(string, null)<br>    health_check_target_ip      = optional(string, null)<br>    opposite_access_point_id    = optional(string, null)<br>    payment_type                = optional(string, "PayAsYouGo")<br>    period                      = optional(number, null)<br>    pricing_cycle               = optional(string, "Month")<br>    resource_group_id           = optional(string, null)<br>    router_interface_name       = optional(string, null)<br>    status                      = optional(string, null)<br>    tags                        = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "opposite_region_id": null,<br>  "role": null,<br>  "router_type": null,<br>  "spec": null<br>}</pre> | no |
| <a name="input_virtual_border_router_config"></a> [virtual\_border\_router\_config](#input\_virtual\_border\_router\_config) | 虚拟边界路由器配置。属性 'local\_gateway\_ip'、'peer\_gateway\_ip'、'peering\_subnet\_mask' 和 'vlan\_id' 是必需的 | <pre>object({<br>    local_gateway_ip           = string<br>    peer_gateway_ip            = string<br>    peering_subnet_mask        = string<br>    virtual_border_router_name = optional(string, null)<br>    vlan_id                    = number<br>    bandwidth                  = optional(number, null)<br>    circuit_code               = optional(string, null)<br>    description                = optional(string, null)<br>    detect_multiplier          = optional(number, 10)<br>    enable_ipv6                = optional(bool, false)<br>    local_ipv6_gateway_ip      = optional(string, null)<br>    min_rx_interval            = optional(number, 1000)<br>    min_tx_interval            = optional(number, 1000)<br>    mtu                        = optional(number, null)<br>    peer_ipv6_gateway_ip       = optional(string, null)<br>    peering_ipv6_subnet_mask   = optional(string, null)<br>    resource_group_id          = optional(string, null)<br>    sitelink_enable            = optional(bool, null)<br>    status                     = optional(string, null)<br>    tags                       = optional(map(string), {})<br>    vbr_owner_id               = optional(string, null)<br>  })</pre> | <pre>{<br>  "local_gateway_ip": null,<br>  "peer_gateway_ip": null,<br>  "peering_subnet_mask": null,<br>  "vlan_id": null<br>}</pre> | no |
| <a name="input_virtual_border_router_id"></a> [virtual\_border\_router\_id](#input\_virtual\_border\_router\_id) | 现有虚拟边界路由器的 ID。当 create\_virtual\_border\_router 为 false 时必需 | `string` | `null` | no |

## 输出

| Name | Description |
|------|-------------|
| <a name="output_bgp_group_id"></a> [bgp\_group\_id](#output\_bgp\_group\_id) | BGP 组的 ID |
| <a name="output_bgp_group_name"></a> [bgp\_group\_name](#output\_bgp\_group\_name) | BGP 组的名称 |
| <a name="output_bgp_group_status"></a> [bgp\_group\_status](#output\_bgp\_group\_status) | BGP 组的状态 |
| <a name="output_bgp_peer_id"></a> [bgp\_peer\_id](#output\_bgp\_peer\_id) | BGP 对等体的 ID |
| <a name="output_bgp_peer_name"></a> [bgp\_peer\_name](#output\_bgp\_peer\_name) | BGP 对等体的名称 |
| <a name="output_bgp_peer_status"></a> [bgp\_peer\_status](#output\_bgp\_peer\_status) | BGP 对等体的状态 |
| <a name="output_express_connect_router_create_time"></a> [express\_connect\_router\_create\_time](#output\_express\_connect\_router\_create\_time) | Express Connect Router 的创建时间 |
| <a name="output_express_connect_router_id"></a> [express\_connect\_router\_id](#output\_express\_connect\_router\_id) | Express Connect Router 的 ID |
| <a name="output_express_connect_router_name"></a> [express\_connect\_router\_name](#output\_express\_connect\_router\_name) | Express Connect Router 的名称 |
| <a name="output_express_connect_router_status"></a> [express\_connect\_router\_status](#output\_express\_connect\_router\_status) | Express Connect Router 的状态 |
| <a name="output_physical_connection_id"></a> [physical\_connection\_id](#output\_physical\_connection\_id) | 物理连接的 ID |
| <a name="output_physical_connection_name"></a> [physical\_connection\_name](#output\_physical\_connection\_name) | 物理连接的名称 |
| <a name="output_physical_connection_status"></a> [physical\_connection\_status](#output\_physical\_connection\_status) | 物理连接的状态 |
| <a name="output_router_interface_bandwidth"></a> [router\_interface\_bandwidth](#output\_router\_interface\_bandwidth) | 路由器接口的带宽 |
| <a name="output_router_interface_id"></a> [router\_interface\_id](#output\_router\_interface\_id) | 路由器接口的 ID |
| <a name="output_router_interface_name"></a> [router\_interface\_name](#output\_router\_interface\_name) | 路由器接口的名称 |
| <a name="output_router_interface_status"></a> [router\_interface\_status](#output\_router\_interface\_status) | 路由器接口的状态 |
| <a name="output_virtual_border_router_id"></a> [virtual\_border\_router\_id](#output\_virtual\_border\_router\_id) | 虚拟边界路由器的 ID |
| <a name="output_virtual_border_router_name"></a> [virtual\_border\_router\_name](#output\_virtual\_border\_router\_name) | 虚拟边界路由器的名称 |
| <a name="output_virtual_border_router_route_table_id"></a> [virtual\_border\_router\_route\_table\_id](#output\_virtual\_border\_router\_route\_table\_id) | 虚拟边界路由器的路由表 ID |
| <a name="output_virtual_border_router_vlan_id"></a> [virtual\_border\_router\_vlan\_id](#output\_virtual\_border\_router\_vlan\_id) | 虚拟边界路由器的 VLAN ID |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)