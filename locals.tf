locals {
  origin_server = coalesce(var.origin_server, "https://${var.node_groups[0].nodes[0].fqdn}:6443")
  token         = coalesce(var.token, random_password.k3s_token[0].result)
  agent_token   = coalesce(var.agent_token, random_password.k3s_agent_token[0].result)
  generated_etc_hosts = var.generate_etc_hosts ? flatten([
    for node_group in var.node_groups :
    [
      for node in node_group.nodes :
      {

        ip       = split("/", node.cidr_ip_address)[0],
        hostname = split(".", node.fqdn)[0],
        fqdn     = node.fqdn
      }
    ]
  ]) : null
}
