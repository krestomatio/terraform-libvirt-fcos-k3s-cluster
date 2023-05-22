# k3s-fcos-cluster
variable "generate_etc_hosts" {
  type        = bool
  default     = null
  description = "Whether /etc/hosts entries shjould be generated for all cluster nodes created. Default depends if `etc_hosts` set"
}

variable "k3s_channel" {
  type        = string
  default     = null
  description = "K3s installation channel"
}

variable "origin_server" {
  type        = string
  default     = ""
  description = "Server host to connect nodes to (ex: https://example:6443)"
  nullable    = false
}

variable "token" {
  type        = string
  default     = null
  sensitive   = true
  description = "K3s token for servers to join the cluster, ang agents if `agent_token` is not set"
}

variable "agent_token" {
  type        = string
  default     = null
  sensitive   = true
  description = "K3s token for agents to join the cluster"
}

variable "node_groups" {
  type = list(
    object(
      {
        name = string
        mode = string
        # general
        butane_snippets_additional = optional(list(string))
        periodic_updates = optional(
          object(
            {
              time_zone = optional(string, "")
              windows = list(
                object(
                  {
                    days           = list(string)
                    start_time     = string
                    length_minutes = string
                  }
                )
              )
            }
          )
        )
        k3s_channel         = optional(string)
        rollout_wariness    = optional(string)
        ssh_authorized_key  = optional(string)
        nameservers         = optional(list(string))
        grub_password_hash  = optional(string)
        timezone            = optional(string)
        keymap              = optional(string)
        interface_name      = optional(string)
        etc_hosts_extra     = optional(string)
        systemd_pager       = optional(string)
        sync_time_with_host = optional(bool)
        do_not_countme      = optional(bool)
        wait_for_lease      = optional(bool)
        qemu_agent          = optional(bool)
        do_not_countme      = optional(bool)
        additional_rpms = optional(
          object(
            {
              cmd_pre  = optional(list(string), [])
              list     = optional(list(string), [])
              cmd_post = optional(list(string), [])
            }
          )
        )
        # k3s config for this node_group
        k3s_config = optional(
          object(
            {
              envvars              = optional(list(string))
              parameters           = optional(list(string))
              selinux              = optional(bool)
              data_dir             = optional(string)
              script_url           = optional(string)
              script_sha256sum     = optional(string)
              repo_baseurl         = optional(string)
              repo_gpgkey          = optional(string)
              testing_repo         = optional(bool)
              testing_repo_baseurl = optional(string)
              testing_repo_gpgkey  = optional(string)
            }
          )
        )
        k3s_fleetlock = optional(
          object(
            {
              version        = optional(string)
              namespace      = optional(string)
              cluster_ip     = optional(string)
              group          = optional(string)
              node_selectors = optional(list(map(string)), [])
              tolerations = optional(
                list(
                  object(
                    {
                      key      = string
                      operator = string
                      value    = optional(string)
                      effect   = string
                    }
                  )
                ), []
              )
            }
          )
        )
        # general libvirt node
        cpu_mode     = optional(string)
        vcpu         = optional(number)
        memory       = optional(number)
        libosinfo_id = optional(string)
        xslt_snippet = optional(string)
        arch         = optional(string)
        cmdline      = optional(list(map(string)))
        emulator     = optional(string)
        machine      = optional(string)
        firmware     = optional(string)
        nvram = optional(
          object(
            {
              file     = string
              template = optional(string)

            }
          )
        )
        root_volume_pool      = optional(string)
        root_volume_size      = optional(number)
        root_base_volume_name = optional(string)
        root_base_volume_pool = optional(string)
        log_volume            = optional(bool)
        log_volume_size       = optional(number)
        log_volume_pool       = optional(string)
        data_volume           = optional(bool)
        data_volume_pool      = optional(string)
        data_volume_size      = optional(number)
        backup_volume         = optional(bool)
        backup_volume_pool    = optional(string)
        backup_volume_size    = optional(number)
        ignition_pool         = optional(string)
        autostart             = optional(bool)
        wait_for_lease        = optional(bool)
        network_id            = optional(string)
        network_bridge        = optional(string)
        network_name          = optional(string)
        nodes = list(
          object(
            {
              # libvirt node
              fqdn            = string
              cidr_ip_address = optional(string)
              mac             = optional(string)
              # specific libvirt node
              cpu_mode     = optional(string)
              vcpu         = optional(number)
              memory       = optional(number)
              libosinfo_id = optional(string)
              xslt_snippet = optional(string)
              arch         = optional(string)
              cmdline      = optional(list(map(string)))
              emulator     = optional(string)
              machine      = optional(string)
              firmware     = optional(string)
              nvram = optional(
                object(
                  {
                    file     = string
                    template = optional(string)

                  }
                )
              )
              root_volume_pool      = optional(string)
              root_volume_size      = optional(number)
              root_base_volume_name = optional(string)
              root_base_volume_pool = optional(string)
              log_volume            = optional(bool)
              log_volume_size       = optional(number)
              log_volume_pool       = optional(string)
              data_volume           = optional(bool)
              data_volume_pool      = optional(string)
              data_volume_size      = optional(number)
              backup_volume         = optional(bool)
              backup_volume_pool    = optional(string)
              backup_volume_size    = optional(number)
              ignition_pool         = optional(string)
              autostart             = optional(bool)
              wait_for_lease        = optional(bool)
              network_id            = optional(string)
              network_bridge        = optional(string)
              network_name          = optional(string)
            }
          )
        )
      }
    )
  )
  description = "List of node groups"
  validation {
    condition = alltrue(
      flatten([
        for node_group in var.node_groups :
        [for node in node_group.nodes : node.cidr_ip_address == null ? true : can(cidrhost(node.cidr_ip_address, 1))]
      ])
    )
    error_message = "Check cidr_ip_address format"
  }
  validation {
    condition = alltrue([
      for node_group in var.node_groups : contains(["bootstrap", "server", "agent"], node_group.mode)
    ])
    error_message = <<-TEMPLATE
      "Invalid input, options: "bootstrap", "server", "agent":"
      "bootstrap": a server node of group to bootstrap a cluster
      "server": start a node group of server
      "agent": start a node group of agents
    TEMPLATE
  }
  validation {
    condition = length(
      [
        for node_group in var.node_groups : true if contains(["bootstrap"], node_group.mode)
      ]
    ) <= 1
    error_message = "A max of one node group should be in \"bootstrap\" mode"
  }
  validation {
    condition     = length(var.node_groups.*.name) == length(distinct(var.node_groups.*.name))
    error_message = "Node group names should be unique"
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

variable "periodic_updates" {
  type = object(
    {
      time_zone = optional(string, "")
      windows = list(
        object(
          {
            days           = list(string)
            start_time     = string
            length_minutes = string
          }
        )
      )
    }
  )
  description = <<-TEMPLATE
    Only reboot for updates during certain timeframes
    {
      time_zone = "localtime"
      windows = [
        {
          days           = ["Sat"],
          start_time     = "23:30",
          length_minutes = "60"
        },
        {
          days           = ["Sun"],
          start_time     = "00:30",
          length_minutes = "60"
        }
      ]
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

# libvirt node
variable "cpu_mode" {
  type        = string
  description = "Libvirt default cpu mode for VMs"
  default     = null
}

variable "vcpu" {
  type        = number
  description = "Node default vcpu count"
  default     = null
}

variable "memory" {
  type        = number
  description = "Node default memory in MiB"
  default     = null
}

variable "libosinfo_id" {
  type        = string
  description = "Id for libosinfo/os type. See https://gitlab.com/libosinfo/osinfo-db/-/tree/main"
  default     = null
}

variable "xslt_snippet" {
  type        = string
  description = "Snippet specifying XSLT to transform the generated XML definition before creating the domain."
  default     = null
}

variable "arch" {
  type        = string
  description = "The architecture for the VM (probably x86_64 or i686), you normally won't need to set this unless you are building a special VM"
  default     = null
}

variable "cmdline" {
  type        = list(map(string))
  description = "Arguments to the kernel"
  default     = []
}

variable "emulator" {
  type        = string
  description = "The path of the emulator to use"
  default     = null
}

variable "machine" {
  type        = string
  description = "The machine type, you normally won't need to set this unless you are running on a platform that defaults to the wrong machine type for your template"
  default     = null
}

variable "firmware" {
  type        = string
  description = "The UEFI rom images for exercising UEFI secure boot in a qemu environment."
  default     = null
}

variable "nvram" {
  type = object(
    {
      file     = string
      template = optional(string)

    }
  )
  description = "This block allows specifying the following attributes related to the nvram"
  default     = null
}

variable "root_volume_pool" {
  type        = string
  description = "Node default root volume pool"
  default     = null
}

variable "root_volume_size" {
  type        = number
  description = "Node default root volume size in bytes"
  default     = null
}

variable "root_base_volume_name" {
  type        = string
  description = "Node default base root volume name"
  default     = null
}

variable "root_base_volume_pool" {
  type        = string
  description = "Node default base root volume pool"
  default     = null
}

variable "log_volume" {
  type        = bool
  description = "Create node log volume"
  default     = null
}

variable "log_volume_pool" {
  type        = string
  description = "Node default log volume pool"
  default     = null
}

variable "log_volume_size" {
  type        = number
  description = "Node default log volume size in bytes"
  default     = null
}

variable "data_volume" {
  type        = bool
  description = "Create node data volume"
  default     = null
}

variable "data_volume_pool" {
  type        = string
  description = "Node default data volume pool"
  default     = null
}

variable "data_volume_size" {
  type        = number
  description = "Node default data volume size in bytes"
  default     = null
}

variable "backup_volume" {
  type        = bool
  description = "Create node backup volume"
  default     = null
}

variable "backup_volume_pool" {
  type        = string
  description = "Node default backup volume pool"
  default     = null
}

variable "backup_volume_size" {
  type        = number
  description = "Node default backup volume size in bytes"
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
