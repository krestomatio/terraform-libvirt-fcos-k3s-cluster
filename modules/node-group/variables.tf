# node-group
variable "nodes" {
  type = list(object({
    # libvirt node
    fqdn            = string
    cidr_ip_address = optional(string)
    mac             = optional(string)
    # specific libvirt node
    cpu_mode              = optional(string)
    vcpu                  = optional(number)
    memory                = optional(number)
    root_volume_pool      = optional(string)
    root_volume_size      = optional(number)
    root_base_volume_name = optional(string)
    root_base_volume_pool = optional(string)
    rootfs_volume_pool    = optional(string)
    initrd_volume_pool    = optional(string)
    kernel_volume_pool    = optional(string)
    log_volume_size       = optional(number)
    log_volume_pool       = optional(string)
    data_volume_pool      = optional(string)
    data_volume_size      = optional(number)
    backup_volume_pool    = optional(string)
    backup_volume_size    = optional(number)
    ignition_pool         = optional(string)
    autostart             = optional(bool)
    wait_for_lease        = optional(bool)
    network_id            = optional(string)
    network_bridge        = optional(string)
    network_name          = optional(string)
  }))
  description = "List of server machine details"
  validation {
    condition = alltrue([
      for node in var.nodes : node.cidr_ip_address == null ? true : can(cidrhost(node.cidr_ip_address, 1))
    ])
    error_message = "Check cidr_ip_address format"
  }
}

# butane custom
variable "secret_encryption_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "Set an specific secret encryption (inteneded only for bootstrap)"
}

variable "qemu_agent" {
  type        = bool
  description = "Install qemu guest agent"
  default     = null
}

variable "butane_snippets_additional" {
  type        = list(string)
  description = "Additional butane snippets"
  default     = []
}

# butane common
variable "ssh_authorized_key" {
  type        = string
  description = "Authorized ssh key for core user"
}

variable "nameservers" {
  type        = list(string)
  description = "List of nameservers for VMs"
  default     = null
}

variable "timezone" {
  type        = string
  description = "Timezone for VMs as listed by `timedatectl list-timezones`"
  default     = null
}

variable "systemd_pager" {
  type        = string
  description = "Systemd pager"
  default     = null
}

variable "do_not_countme" {
  type        = bool
  description = "Disable Fedora CoreOS infrastructure count me feature"
  default     = null
}

variable "rollout_wariness" {
  type        = string
  description = "Wariness to update, 1.0 (very cautious) to 0.0 (very eager)"
  default     = null
}

variable "updates_periodic_window" {
  type = object({
    days           = list(string)
    start_time     = string
    length_minutes = string
  })
  description = <<-TEMPLATE
    Only reboot for updates during certain timeframes
    {
      days           = ["Sat", "Sun"],
      start_time     = "22:30",
      length_minutes = "60"
    }
  TEMPLATE
  default     = null
}

variable "interface_name" {
  type        = string
  description = "Network interface name"
  default     = null
}

variable "keymap" {
  type        = string
  description = "Keymap"
  default     = null
}

variable "sync_time_with_host" {
  type        = bool
  description = "Sync guest time with the kvm host"
  default     = null
}

variable "etc_hosts" {
  type = list(
    object(
      {
        ip       = string
        hostname = string
        fqdn     = string
      }
    )
  )
  description = "/etc/host list"
  default     = null
}

variable "etc_hosts_extra" {
  type        = string
  description = "/etc/host extra block"
  default     = null
}

variable "additional_rpms" {
  type = object(
    {
      cmd_pre  = optional(list(string), [])
      list     = optional(list(string), [])
      cmd_post = optional(list(string), [])
    }
  )
  description = "Additional rpms to install during boot using rpm-ostree, along with any pre or post command"
  default     = null
}

# butane k3s
variable "mode" {
  type        = string
  default     = null
  description = <<-TEMPLATE
    K3s installation mode:
    "bootstrap": bootstrap a cluster, then be a server
    "server": start a server
    "agent": start an agent
  TEMPLATE
}

variable "k3s_config" {
  type = object(
    {
      envvars          = optional(list(string))
      parameters       = optional(list(string))
      selinux          = optional(bool)
      data_dir         = optional(string)
      script_url       = optional(string)
      script_sha256sum = optional(string)
      repo_baseurl     = optional(string)
      repo_gpgkey      = optional(string)
    }
  )
  description = "K3s configuration"
  default     = null
}

variable "k3s_channel" {
  type        = string
  default     = null
  description = "K3s installation channel"
}

variable "origin_server" {
  type        = string
  default     = null
  description = "Server host to connect nodes to (ex: https://example:6443)"
}

variable "token" {
  type        = string
  sensitive   = true
  description = "K3s token for servers to join the cluster, ang agents if `agent_token` is not set"
}

variable "agent_token" {
  type        = string
  default     = null
  sensitive   = true
  description = "K3s token for agents to join the cluster"
}

# libvirt node
variable "cpu_mode" {
  type        = string
  description = "Libvirt default cpu mode for VMs"
  default     = null
}

variable "vcpu" {
  type        = number
  description = "Worker default vcpu count"
  default     = null
}

variable "memory" {
  type        = number
  description = "Worker default memory in MiB"
  default     = null
}

variable "root_volume_pool" {
  type        = string
  description = "Worker default root volume pool"
  default     = null
}

variable "root_volume_size" {
  type        = number
  description = "Worker default root volume size in bytes"
  default     = null
}

variable "root_base_volume_name" {
  type        = string
  description = "Worker default base root volume name"
  default     = null
}

variable "root_base_volume_pool" {
  type        = string
  description = "Worker default base root volume pool"
  default     = null
}

variable "rootfs_volume_pool" {
  type        = string
  description = "Node default rootfs volume pool"
  default     = null
}

variable "initrd_volume_pool" {
  type        = string
  description = "Node default initrd volume pool"
  default     = null
}

variable "kernel_volume_pool" {
  type        = string
  description = "Node default kernel volume pool"
  default     = null
}

variable "log_volume_pool" {
  type        = string
  description = "Worker default log volume pool"
  default     = null
}

variable "log_volume_size" {
  type        = number
  description = "Worker default log volume size in bytes"
  default     = null
}

variable "data_volume_pool" {
  type        = string
  description = "Worker default data volume pool"
  default     = null
}

variable "data_volume_size" {
  type        = number
  description = "Worker default data volume size in bytes"
  default     = null
}

variable "backup_volume_pool" {
  type        = string
  description = "Worker default backup volume pool"
  default     = null
}

variable "backup_volume_size" {
  type        = number
  description = "Worker default backup volume size in bytes"
  default     = null
}

variable "ignition_pool" {
  type        = string
  description = "Default ignition files pool"
  default     = null
}

variable "wait_for_lease" {
  type        = bool
  description = "Wait for network lease"
  default     = null
}

variable "autostart" {
  type        = bool
  description = "Autostart with libvirt host"
  default     = null
}

variable "network_bridge" {
  type        = string
  description = "Libvirt default network bridge name for VMs"
  default     = null
}

variable "network_id" {
  type        = string
  description = "Libvirt default network id for VMs"
  default     = null
}

variable "network_name" {
  type        = string
  description = "Libvirt default network name for VMs"
  default     = null
}
