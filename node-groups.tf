
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
  ssh_authorized_key  = var.node_groups[count.index].ssh_authorized_key != null ? var.node_groups[count.index].ssh_authorized_key : var.ssh_authorized_key
  etc_hosts           = local.generated_etc_hosts
  etc_hosts_extra     = var.node_groups[count.index].etc_hosts_extra != null ? var.node_groups[count.index].etc_hosts_extra : var.etc_hosts_extra
  rollout_wariness    = var.node_groups[count.index].rollout_wariness != null ? var.node_groups[count.index].rollout_wariness : var.rollout_wariness
  periodic_updates    = var.node_groups[count.index].periodic_updates != null ? var.node_groups[count.index].periodic_updates : var.periodic_updates
  nameservers         = var.node_groups[count.index].nameservers != null ? var.node_groups[count.index].nameservers : var.nameservers
  timezone            = var.node_groups[count.index].timezone != null ? var.node_groups[count.index].timezone : var.timezone
  keymap              = var.node_groups[count.index].keymap != null ? var.node_groups[count.index].keymap : var.keymap
  interface_name      = var.node_groups[count.index].interface_name != null ? var.node_groups[count.index].interface_name : var.interface_name
  additional_rpms     = var.node_groups[count.index].additional_rpms != null ? var.node_groups[count.index].additional_rpms : var.additional_rpms
  sync_time_with_host = var.node_groups[count.index].sync_time_with_host != null ? var.node_groups[count.index].sync_time_with_host : var.sync_time_with_host
  do_not_countme      = var.node_groups[count.index].do_not_countme != null ? var.node_groups[count.index].do_not_countme : var.do_not_countme

  # butane k3s
  mode          = var.node_groups[count.index].mode
  k3s_channel   = var.node_groups[count.index].k3s_channel != null ? var.node_groups[count.index].k3s_channel : var.k3s_channel
  origin_server = local.origin_server
  token         = var.token
  agent_token   = var.agent_token
  k3s_config    = var.node_groups[count.index].k3s_config

  # libvirt node
  cpu_mode              = var.node_groups[count.index].cpu_mode != null ? var.node_groups[count.index].cpu_mode : var.cpu_mode
  vcpu                  = var.node_groups[count.index].vcpu != null ? var.node_groups[count.index].vcpu : var.vcpu
  memory                = var.node_groups[count.index].memory != null ? var.node_groups[count.index].memory : var.memory
  libosinfo_id          = var.node_groups[count.index].libosinfo_id != null ? var.node_groups[count.index].libosinfo_id : var.libosinfo_id
  xslt_snippet          = var.node_groups[count.index].xslt_snippet != null ? var.node_groups[count.index].xslt_snippet : var.xslt_snippet
  arch                  = var.node_groups[count.index].arch != null ? var.node_groups[count.index].arch : var.arch
  cmdline               = var.node_groups[count.index].cmdline != null ? var.node_groups[count.index].cmdline : var.cmdline
  emulator              = var.node_groups[count.index].emulator != null ? var.node_groups[count.index].emulator : var.emulator
  machine               = var.node_groups[count.index].machine != null ? var.node_groups[count.index].machine : var.machine
  firmware              = var.node_groups[count.index].firmware != null ? var.node_groups[count.index].firmware : var.firmware
  nvram                 = var.node_groups[count.index].nvram != null ? var.node_groups[count.index].nvram : var.nvram
  root_volume_pool      = var.node_groups[count.index].root_volume_pool != null ? var.node_groups[count.index].root_volume_pool : var.root_volume_pool
  root_volume_size      = var.node_groups[count.index].root_volume_size != null ? var.node_groups[count.index].root_volume_size : var.root_volume_size
  root_base_volume_name = var.node_groups[count.index].root_base_volume_name != null ? var.node_groups[count.index].root_base_volume_name : var.root_base_volume_name
  root_base_volume_pool = var.node_groups[count.index].root_base_volume_pool != null ? var.node_groups[count.index].root_base_volume_pool : var.root_base_volume_pool
  log_volume            = var.node_groups[count.index].log_volume != null ? var.node_groups[count.index].log_volume : var.log_volume
  log_volume_size       = var.node_groups[count.index].log_volume_size != null ? var.node_groups[count.index].log_volume_size : var.log_volume_size
  log_volume_pool       = var.node_groups[count.index].log_volume_pool != null ? var.node_groups[count.index].log_volume_pool : var.log_volume_pool
  data_volume           = var.node_groups[count.index].data_volume != null ? var.node_groups[count.index].data_volume : var.data_volume
  data_volume_pool      = var.node_groups[count.index].data_volume_pool != null ? var.node_groups[count.index].data_volume_pool : var.data_volume_pool
  data_volume_size      = var.node_groups[count.index].data_volume_size != null ? var.node_groups[count.index].data_volume_size : var.data_volume_size
  backup_volume         = var.node_groups[count.index].backup_volume != null ? var.node_groups[count.index].backup_volume : var.backup_volume
  backup_volume_pool    = var.node_groups[count.index].backup_volume_pool != null ? var.node_groups[count.index].backup_volume_pool : var.backup_volume_pool
  backup_volume_size    = var.node_groups[count.index].backup_volume_size != null ? var.node_groups[count.index].backup_volume_size : var.backup_volume_size
  ignition_pool         = var.node_groups[count.index].ignition_pool != null ? var.node_groups[count.index].ignition_pool : var.ignition_pool
  autostart             = var.node_groups[count.index].autostart != null ? var.node_groups[count.index].autostart : var.autostart
  wait_for_lease        = var.node_groups[count.index].wait_for_lease != null ? var.node_groups[count.index].wait_for_lease : var.wait_for_lease
  network_id            = var.node_groups[count.index].network_id != null ? var.node_groups[count.index].network_id : var.network_id
  network_bridge        = var.node_groups[count.index].network_bridge != null ? var.node_groups[count.index].network_bridge : var.network_bridge
  network_name          = var.node_groups[count.index].network_name != null ? var.node_groups[count.index].network_name : var.network_name
}
