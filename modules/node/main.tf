module "libvirt_fcos_base" {
  source  = "krestomatio/fcos/libvirt"
  version = "0.0.20"

  # custom
  butane_snippets_additional = compact(
    concat(
      [
        module.butane_k3s_snippets.config
      ],
      var.butane_snippets_additional
    )
  )

  # common
  qemu_agent          = var.qemu_agent
  systemd_pager       = var.systemd_pager
  ssh_authorized_key  = var.ssh_authorized_key
  nameservers         = var.nameservers
  timezone            = var.timezone
  do_not_countme      = var.do_not_countme
  rollout_wariness    = var.rollout_wariness
  periodic_updates    = var.periodic_updates
  keymap              = var.keymap
  interface_name      = var.interface_name
  sync_time_with_host = var.sync_time_with_host
  etc_hosts           = var.etc_hosts
  additional_rpms     = var.additional_rpms
  # libvirt node
  fqdn            = var.fqdn
  cidr_ip_address = var.cidr_ip_address
  mac             = var.mac
  # specific libvirt node
  cpu_mode              = var.cpu_mode
  vcpu                  = var.vcpu
  memory                = var.memory
  libosinfo_id          = var.libosinfo_id
  xslt_snippet          = var.xslt_snippet
  arch                  = var.arch
  cmdline               = var.cmdline
  emulator              = var.emulator
  machine               = var.machine
  firmware              = var.firmware
  nvram                 = var.nvram
  root_volume_pool      = var.root_volume_pool
  root_volume_size      = var.root_volume_size
  root_base_volume_name = var.root_base_volume_name
  root_base_volume_pool = var.root_base_volume_pool
  log_volume            = var.log_volume
  log_volume_size       = var.log_volume_size
  log_volume_pool       = var.log_volume_pool
  data_volume           = var.data_volume
  data_volume_pool      = var.data_volume_pool
  data_volume_size      = var.data_volume_size
  data_volume_path      = local.data_volume_path
  backup_volume         = var.backup_volume
  backup_volume_pool    = var.backup_volume_pool
  backup_volume_size    = var.backup_volume_size
  ignition_pool         = var.ignition_pool
  autostart             = var.autostart
  wait_for_lease        = var.wait_for_lease
  network_id            = var.network_id
  network_bridge        = var.network_bridge
  network_name          = var.network_name
}
