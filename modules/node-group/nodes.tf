module "node_group" {
  count = length(var.nodes)

  source = "../node"

  # butane custom
  secret_encryption_key      = contains(["bootstrap", "server"], var.mode) ? var.secret_encryption_key : null
  qemu_agent                 = var.qemu_agent
  butane_snippets_additional = var.butane_snippets_additional
  systemd_pager              = var.systemd_pager

  # butane common
  etc_hosts               = var.etc_hosts
  etc_hosts_extra         = var.etc_hosts_extra
  ssh_authorized_key      = var.ssh_authorized_key
  rollout_wariness        = var.rollout_wariness
  updates_periodic_window = var.updates_periodic_window
  nameservers             = var.nameservers
  timezone                = var.timezone
  keymap                  = var.keymap
  additional_rpms         = var.additional_rpms
  sync_time_with_host     = var.sync_time_with_host
  do_not_countme          = var.do_not_countme

  # butane k3s
  # bootstrap node mode only for first node in bootstrap node group mode
  mode          = var.mode == "bootstrap" && count.index != 0 ? "server" : var.mode
  k3s_channel   = var.k3s_channel
  origin_server = var.origin_server
  token         = var.token
  agent_token   = var.agent_token
  k3s_config    = var.k3s_config

  # libvirt node
  fqdn            = var.nodes[count.index].fqdn
  cidr_ip_address = var.nodes[count.index].cidr_ip_address
  mac             = var.nodes[count.index].mac
  # specific libvirt node
  cpu_mode              = var.nodes[count.index].cpu_mode != null ? var.nodes[count.index].cpu_mode : var.cpu_mode
  vcpu                  = var.nodes[count.index].vcpu != null ? var.nodes[count.index].vcpu : var.vcpu
  memory                = var.nodes[count.index].memory != null ? var.nodes[count.index].memory : var.memory
  root_volume_pool      = var.nodes[count.index].root_volume_pool != null ? var.nodes[count.index].root_volume_pool : var.root_volume_pool
  root_volume_size      = var.nodes[count.index].root_volume_size != null ? var.nodes[count.index].root_volume_size : var.root_volume_size
  root_base_volume_name = var.nodes[count.index].root_base_volume_name != null ? var.nodes[count.index].root_base_volume_name : var.root_base_volume_name
  root_base_volume_pool = var.nodes[count.index].root_base_volume_pool != null ? var.nodes[count.index].root_base_volume_pool : var.root_base_volume_pool
  log_volume_size       = var.nodes[count.index].log_volume_size != null ? var.nodes[count.index].log_volume_size : var.log_volume_size
  log_volume_pool       = var.nodes[count.index].log_volume_pool != null ? var.nodes[count.index].log_volume_pool : var.log_volume_pool
  data_volume_pool      = var.nodes[count.index].data_volume_pool != null ? var.nodes[count.index].data_volume_pool : var.data_volume_pool
  data_volume_size      = var.nodes[count.index].data_volume_size != null ? var.nodes[count.index].data_volume_size : var.data_volume_size
  backup_volume_pool    = var.nodes[count.index].backup_volume_pool != null ? var.nodes[count.index].backup_volume_pool : var.backup_volume_pool
  backup_volume_size    = var.nodes[count.index].backup_volume_size != null ? var.nodes[count.index].backup_volume_size : var.backup_volume_size
  ignition_pool         = var.nodes[count.index].ignition_pool != null ? var.nodes[count.index].ignition_pool : var.ignition_pool
  autostart             = var.nodes[count.index].autostart != null ? var.nodes[count.index].autostart : var.autostart
  wait_for_lease        = var.nodes[count.index].wait_for_lease != null ? var.nodes[count.index].wait_for_lease : var.wait_for_lease
  network_id            = var.nodes[count.index].network_id != null ? var.nodes[count.index].network_id : var.network_id
  network_bridge        = var.nodes[count.index].network_bridge != null ? var.nodes[count.index].network_bridge : var.network_bridge
  network_name          = var.nodes[count.index].network_name != null ? var.nodes[count.index].network_name : var.network_name
}