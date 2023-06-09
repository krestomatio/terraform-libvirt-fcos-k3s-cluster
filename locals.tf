locals {
  origin_server      = coalesce(var.origin_server, "https://${var.node_groups[0].nodes[0].fqdn}:6443")
  generate_etc_hosts = var.etc_hosts == null && var.generate_etc_hosts != null ? var.generate_etc_hosts : false
  generated_etc_hosts = local.generate_etc_hosts ? flatten([
    for node_group in var.node_groups :
    [
      for node in node_group.nodes :
      {

        ip       = split("/", node.cidr_ip_address)[0],
        hostname = split(".", node.fqdn)[0],
        fqdn     = node.fqdn
      }
    ]
  ]) : var.etc_hosts
}
