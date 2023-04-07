resource "random_password" "k3s_token" {
  count   = var.token != "" ? 0 : 1
  length  = 64
  special = false
}

resource "random_password" "k3s_agent_token" {
  count   = var.agent_token != "" ? 0 : 1
  length  = 64
  special = false
}

module "node_groups" {
  count = length(var.node_groups)

  source = "./modules/node-group"

  # node-group
  nodes = var.node_groups[count.index].nodes

  # butane custom
  secret_encryption_key      = var.secret_encryption_key
  qemu_agent                 = var.node_groups[count.index].qemu_agent != null ? var.node_groups[count.index].qemu_agent : var.qemu_agent
  butane_snippets_additional = var.node_groups[count.index].butane_snippets_additional != null ? var.node_groups[count.index].butane_snippets_additional : var.butane_snippets_additional
  systemd_pager              = var.node_groups[count.index].systemd_pager != null ? var.node_groups[count.index].systemd_pager : var.systemd_pager
  # butane common
  ssh_authorized_key      = var.node_groups[count.index].ssh_authorized_key != null ? var.node_groups[count.index].ssh_authorized_key : var.ssh_authorized_key
  etc_hosts               = local.generated_etc_hosts
  etc_hosts_extra         = var.node_groups[count.index].etc_hosts_extra != null ? var.node_groups[count.index].etc_hosts_extra : var.etc_hosts_extra
  rollout_wariness        = var.node_groups[count.index].rollout_wariness != null ? var.node_groups[count.index].rollout_wariness : var.rollout_wariness
  updates_periodic_window = var.node_groups[count.index].updates_periodic_window != null ? var.node_groups[count.index].updates_periodic_window : var.updates_periodic_window
  nameservers             = var.node_groups[count.index].nameservers != null ? var.node_groups[count.index].nameservers : var.nameservers
  timezone                = var.node_groups[count.index].timezone != null ? var.node_groups[count.index].timezone : var.timezone
  keymap                  = var.node_groups[count.index].keymap != null ? var.node_groups[count.index].keymap : var.keymap
  additional_rpms         = var.node_groups[count.index].additional_rpms != null ? var.node_groups[count.index].additional_rpms : var.additional_rpms
  sync_time_with_host     = var.node_groups[count.index].sync_time_with_host != null ? var.node_groups[count.index].sync_time_with_host : var.sync_time_with_host
  do_not_countme          = var.node_groups[count.index].do_not_countme != null ? var.node_groups[count.index].do_not_countme : var.do_not_countme

  # butane k3s
  mode          = var.node_groups[count.index].mode
  k3s_channel   = var.node_groups[count.index].k3s_channel != null ? var.node_groups[count.index].k3s_channel : var.k3s_channel
  origin_server = local.origin_server
  token         = local.token
  agent_token   = local.agent_token
  k3s_config    = var.node_groups[count.index].k3s_config

  # libvirt node
  cpu_mode              = var.node_groups[count.index].cpu_mode != null ? var.node_groups[count.index].cpu_mode : var.cpu_mode
  vcpu                  = var.node_groups[count.index].vcpu != null ? var.node_groups[count.index].vcpu : var.vcpu
  memory                = var.node_groups[count.index].memory != null ? var.node_groups[count.index].memory : var.memory
  root_volume_pool      = var.node_groups[count.index].root_volume_pool != null ? var.node_groups[count.index].root_volume_pool : var.root_volume_pool
  root_volume_size      = var.node_groups[count.index].root_volume_size != null ? var.node_groups[count.index].root_volume_size : var.root_volume_size
  root_base_volume_name = var.node_groups[count.index].root_base_volume_name != null ? var.node_groups[count.index].root_base_volume_name : var.root_base_volume_name
  root_base_volume_pool = var.node_groups[count.index].root_base_volume_pool != null ? var.node_groups[count.index].root_base_volume_pool : var.root_base_volume_pool
  log_volume_size       = var.node_groups[count.index].log_volume_size != null ? var.node_groups[count.index].log_volume_size : var.log_volume_size
  log_volume_pool       = var.node_groups[count.index].log_volume_pool != null ? var.node_groups[count.index].log_volume_pool : var.log_volume_pool
  data_volume_pool      = var.node_groups[count.index].data_volume_pool != null ? var.node_groups[count.index].data_volume_pool : var.data_volume_pool
  data_volume_size      = var.node_groups[count.index].data_volume_size != null ? var.node_groups[count.index].data_volume_size : var.data_volume_size
  backup_volume_pool    = var.node_groups[count.index].backup_volume_pool != null ? var.node_groups[count.index].backup_volume_pool : var.backup_volume_pool
  backup_volume_size    = var.node_groups[count.index].backup_volume_size != null ? var.node_groups[count.index].backup_volume_size : var.backup_volume_size
  ignition_pool         = var.node_groups[count.index].ignition_pool != null ? var.node_groups[count.index].ignition_pool : var.ignition_pool
  autostart             = var.node_groups[count.index].autostart != null ? var.node_groups[count.index].autostart : var.autostart
  wait_for_lease        = var.node_groups[count.index].wait_for_lease != null ? var.node_groups[count.index].wait_for_lease : var.wait_for_lease
  network_id            = var.node_groups[count.index].network_id != null ? var.node_groups[count.index].network_id : var.network_id
  network_bridge        = var.node_groups[count.index].network_bridge != null ? var.node_groups[count.index].network_bridge : var.network_bridge
  network_name          = var.node_groups[count.index].network_name != null ? var.node_groups[count.index].network_name : var.network_name
}