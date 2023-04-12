locals {
  data_volume                = "/var/lib/rancher/k3s"
  os_additional_rpms         = var.qemu_agent ? { list = concat(var.additional_rpms.list, ["qemu-guest-agent"]), cmd_post = concat(var.additional_rpms.cmd_post, ["/usr/bin/systemctl enable --now qemu-guest-agent.service"]), cmd_pre = var.additional_rpms.cmd_pre } : var.additional_rpms
  butane_snippets_additional = concat([module.butane_k3s_snippets.config], var.butane_snippets_additional)
}
