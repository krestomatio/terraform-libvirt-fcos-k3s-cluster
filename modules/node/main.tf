module "libvirt_fcos_base" {
  source  = "krestomatio/fcos/libvirt"
  version = "0.0.1"

  fqdn                    = var.fqdn
  cidr_ip_address         = var.cidr_ip_address
  mac                     = var.mac
  qemu_agent              = var.qemu_agent
  systemd_pager           = var.systemd_pager
  ssh_authorized_key      = var.ssh_authorized_key
  nameservers             = var.nameservers
  timezone                = var.timezone
  do_not_countme          = var.do_not_countme
  rollout_wariness        = var.rollout_wariness
  updates_periodic_window = var.updates_periodic_window
  keymap                  = var.keymap
  sync_time_with_host     = var.sync_time_with_host
  etc_hosts               = var.etc_hosts
  additional_rpms         = var.additional_rpms
  vcpu                    = var.vcpu
  memory                  = var.memory
  root_volume_size        = var.root_volume_size
  log_volume_size         = var.log_volume_size
  data_volume_size        = var.data_volume_size
  backup_volume_size      = var.backup_volume_size

  root_base_volume_name = var.root_base_volume_name

  os_additional_rpms         = local.os_additional_rpms
  data_volume                = local.data_volume
  butane_snippets_additional = local.butane_snippets_additional
}
