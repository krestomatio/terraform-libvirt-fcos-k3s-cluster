locals {
  hostname           = var.fqdn
  log_volume         = "/var/log"
  k3s_volume         = "/var/lib/rancher/k3s"
  backup_volume      = "/var/mnt/backup"
  os_additional_rpms = var.qemu_agent ? { list = concat(var.additional_rpms.list, ["qemu-guest-agent"]), cmd_post = concat(var.additional_rpms.cmd_post, ["/usr/bin/systemctl enable --now qemu-guest-agent.service"]), cmd_pre = var.additional_rpms.cmd_pre } : var.additional_rpms
  storage = {
    disks = [
      {
        device     = "/dev/vdb"
        wipe_table = true
        partitions = [
          {
            resize    = true
            label     = "log"
            number    = 1
            size_mib  = 0
            start_mib = 0
          }
        ]
      },
      {
        device     = "/dev/vdc"
        wipe_table = true
        partitions = [
          {
            resize    = true
            label     = "k3s"
            number    = 1
            size_mib  = 0
            start_mib = 0
          }
        ]
      },
      {
        device     = "/dev/vdd"
        wipe_table = true
        partitions = [
          {
            resize    = true
            label     = "backup"
            number    = 1
            size_mib  = 0
            start_mib = 0
          }
        ]
      }
    ]
    filesystems = [
      {
        device          = "/dev/disk/by-partlabel/log"
        path            = "${local.log_volume}"
        format          = "xfs"
        label           = "log"
        with_mount_unit = true
      },
      {
        device          = "/dev/disk/by-partlabel/k3s"
        path            = "${local.k3s_volume}"
        format          = "xfs"
        label           = "k3s"
        with_mount_unit = true
      },
      {
        device          = "/dev/disk/by-partlabel/backup"
        path            = "${local.backup_volume}"
        format          = "xfs"
        label           = "backup"
        with_mount_unit = true
      }
    ]
  }
  butane_k3s_snippets = compact(
    [
      module.butane_common_snippets.hostname,
      module.butane_common_snippets.keymap,
      module.butane_common_snippets.timezone,
      module.butane_common_snippets.updates_periodic_window,
      module.butane_common_snippets.rollout_wariness,
      module.butane_common_snippets.core_authorized_key,
      module.butane_common_snippets.static_interface,
      module.butane_common_snippets.etc_hosts,
      module.butane_common_snippets.disks,
      module.butane_common_snippets.filesystems,
      module.butane_common_snippets.additional_rpms,
      module.butane_common_snippets.sync_time_with_host,
      module.butane_common_snippets.systemd_pager,
      module.butane_common_snippets.do_not_countme,
      module.butane_k3s_snippets.config
    ]
  )
  butane_snippets = concat(local.butane_k3s_snippets, var.butane_snippets_additional)
}
