Terraform module for creating [K3s clusters](https://docs.k3s.io/) using [Fedora CoreOS](https://docs.fedoraproject.org/en-US/fedora-coreos/) and [Libvirt](https://libvirt.org/).

## Dependencies
The following are the dependencies to create k3s cluster with this module:
* [libvirt](https://libvirt.org/)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_ct"></a> [ct](#requirement\_ct) | 0.11.0 |
| <a name="requirement_libvirt"></a> [libvirt](#requirement\_libvirt) | ~> 0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_node_groups"></a> [node\_groups](#module\_node\_groups) | ./modules/node-group | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.k3s_agent_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.k3s_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_rpms"></a> [additional\_rpms](#input\_additional\_rpms) | Additional rpms to install during boot using rpm-ostree, along with any pre or post command | <pre>object(<br>    {<br>      cmd_pre  = optional(list(string), [])<br>      list     = optional(list(string), [])<br>      cmd_post = optional(list(string), [])<br>    }<br>  )</pre> | `null` | no |
| <a name="input_agent_token"></a> [agent\_token](#input\_agent\_token) | K3s token for agents to join the cluster | `string` | `""` | no |
| <a name="input_autostart"></a> [autostart](#input\_autostart) | Autostart with libvirt host | `bool` | `null` | no |
| <a name="input_backup_volume_pool"></a> [backup\_volume\_pool](#input\_backup\_volume\_pool) | Worker default backup volume pool | `string` | `null` | no |
| <a name="input_backup_volume_size"></a> [backup\_volume\_size](#input\_backup\_volume\_size) | Worker default backup volume size in bytes | `number` | `null` | no |
| <a name="input_butane_snippets_additional"></a> [butane\_snippets\_additional](#input\_butane\_snippets\_additional) | Additional butane snippets | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_cpu_mode"></a> [cpu\_mode](#input\_cpu\_mode) | Libvirt default cpu mode for VMs | `string` | `null` | no |
| <a name="input_data_volume_pool"></a> [data\_volume\_pool](#input\_data\_volume\_pool) | Worker default data volume pool | `string` | `null` | no |
| <a name="input_data_volume_size"></a> [data\_volume\_size](#input\_data\_volume\_size) | Worker default data volume size in bytes | `number` | `null` | no |
| <a name="input_do_not_countme"></a> [do\_not\_countme](#input\_do\_not\_countme) | Disable Fedora CoreOS infrastructure count me feature | `bool` | `null` | no |
| <a name="input_etc_hosts"></a> [etc\_hosts](#input\_etc\_hosts) | /etc/host list | <pre>list(<br>    object(<br>      {<br>        ip       = string<br>        hostname = string<br>        fqdn     = string<br>      }<br>    )<br>  )</pre> | `null` | no |
| <a name="input_etc_hosts_extra"></a> [etc\_hosts\_extra](#input\_etc\_hosts\_extra) | /etc/host extra block | `string` | `null` | no |
| <a name="input_generate_etc_hosts"></a> [generate\_etc\_hosts](#input\_generate\_etc\_hosts) | Whether /etc/hosts entries shjould be generated for all cluster nodes created | `bool` | n/a | yes |
| <a name="input_ignition_pool"></a> [ignition\_pool](#input\_ignition\_pool) | Default ignition files pool | `string` | `null` | no |
| <a name="input_initrd_volume_pool"></a> [initrd\_volume\_pool](#input\_initrd\_volume\_pool) | Node default initrd volume pool | `string` | `null` | no |
| <a name="input_interface_name"></a> [interface\_name](#input\_interface\_name) | Network interface name | `string` | `null` | no |
| <a name="input_k3s_channel"></a> [k3s\_channel](#input\_k3s\_channel) | K3s installation channel | `string` | `null` | no |
| <a name="input_kernel_volume_pool"></a> [kernel\_volume\_pool](#input\_kernel\_volume\_pool) | Node default kernel volume pool | `string` | `null` | no |
| <a name="input_keymap"></a> [keymap](#input\_keymap) | Keymap | `string` | `null` | no |
| <a name="input_log_volume_pool"></a> [log\_volume\_pool](#input\_log\_volume\_pool) | Worker default log volume pool | `string` | `null` | no |
| <a name="input_log_volume_size"></a> [log\_volume\_size](#input\_log\_volume\_size) | Worker default log volume size in bytes | `number` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Worker default memory in MiB | `number` | `null` | no |
| <a name="input_nameservers"></a> [nameservers](#input\_nameservers) | Nameservers for VMs, separated by ';' | `string` | `null` | no |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | Libvirt default network bridge name for VMs | `string` | `null` | no |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | Libvirt default network id for VMs | `string` | `null` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Libvirt default network name for VMs | `string` | `null` | no |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | List of node groups | <pre>list(<br>    object(<br>      {<br>        name = string<br>        mode = string<br>        # general<br>        butane_snippets_additional = optional(list(string))<br>        updates_periodic_window = optional(<br>          object({<br>            days           = optional(list(string))<br>            start_time     = optional(string)<br>            length_minutes = optional(string)<br>          })<br>        )<br>        k3s_channel         = optional(string)<br>        rollout_wariness    = optional(string)<br>        ssh_authorized_key  = optional(string)<br>        nameservers         = optional(string)<br>        grub_password_hash  = optional(string)<br>        timezone            = optional(string)<br>        keymap              = optional(string)<br>        etc_hosts_extra     = optional(string)<br>        systemd_pager       = optional(string)<br>        sync_time_with_host = optional(bool)<br>        do_not_countme      = optional(bool)<br>        wait_for_lease      = optional(bool)<br>        qemu_agent          = optional(bool)<br>        do_not_countme      = optional(bool)<br>        additional_rpms = optional(<br>          object(<br>            {<br>              cmd_pre  = optional(list(string), [])<br>              list     = optional(list(string), [])<br>              cmd_post = optional(list(string), [])<br>            }<br>          )<br>        )<br>        # k3s config for this node_group<br>        k3s_config = optional(<br>          object(<br>            {<br>              envvars          = optional(list(string))<br>              parameters       = optional(list(string))<br>              selinux          = optional(bool)<br>              data_dir         = optional(string)<br>              script_url       = optional(string)<br>              script_sha256sum = optional(string)<br>              repo_baseurl     = optional(string)<br>              repo_gpgkey      = optional(string)<br>            }<br>          )<br>        )<br>        # general libvirt node<br>        cpu_mode              = optional(string)<br>        vcpu                  = optional(number)<br>        memory                = optional(number)<br>        root_volume_pool      = optional(string)<br>        root_volume_size      = optional(number)<br>        root_base_volume_name = optional(string)<br>        root_base_volume_pool = optional(string)<br>        rootfs_volume_pool    = optional(string)<br>        initrd_volume_pool    = optional(string)<br>        kernel_volume_pool    = optional(string)<br>        log_volume_size       = optional(number)<br>        log_volume_pool       = optional(string)<br>        data_volume_pool      = optional(string)<br>        data_volume_size      = optional(number)<br>        backup_volume_pool    = optional(string)<br>        backup_volume_size    = optional(number)<br>        ignition_pool         = optional(string)<br>        autostart             = optional(bool)<br>        wait_for_lease        = optional(bool)<br>        network_id            = optional(string)<br>        network_bridge        = optional(string)<br>        network_name          = optional(string)<br>        nodes = list(<br>          object(<br>            {<br>              # libvirt node<br>              fqdn            = string<br>              cidr_ip_address = optional(string)<br>              mac             = optional(string)<br>              # specific libvirt node<br>              cpu_mode              = optional(string)<br>              vcpu                  = optional(number)<br>              memory                = optional(number)<br>              root_volume_pool      = optional(string)<br>              root_volume_size      = optional(number)<br>              root_base_volume_name = optional(string)<br>              root_base_volume_pool = optional(string)<br>              log_volume_size       = optional(number)<br>              log_volume_pool       = optional(string)<br>              data_volume_pool      = optional(string)<br>              data_volume_size      = optional(number)<br>              backup_volume_pool    = optional(string)<br>              backup_volume_size    = optional(number)<br>              ignition_pool         = optional(string)<br>              autostart             = optional(bool)<br>              wait_for_lease        = optional(bool)<br>              network_id            = optional(string)<br>              network_bridge        = optional(string)<br>              network_name          = optional(string)<br>            }<br>          )<br>        )<br>      }<br>    )<br>  )</pre> | n/a | yes |
| <a name="input_origin_server"></a> [origin\_server](#input\_origin\_server) | Server host to connect nodes to (ex: https://example:6443) | `string` | `""` | no |
| <a name="input_qemu_agent"></a> [qemu\_agent](#input\_qemu\_agent) | Install qemu guest agent | `bool` | `null` | no |
| <a name="input_rollout_wariness"></a> [rollout\_wariness](#input\_rollout\_wariness) | Wariness to update, 1.0 (very cautious) to 0.0 (very eager) | `string` | `null` | no |
| <a name="input_root_base_volume_name"></a> [root\_base\_volume\_name](#input\_root\_base\_volume\_name) | Worker default base root volume name | `string` | `null` | no |
| <a name="input_root_base_volume_pool"></a> [root\_base\_volume\_pool](#input\_root\_base\_volume\_pool) | Worker default base root volume pool | `string` | `null` | no |
| <a name="input_root_volume_pool"></a> [root\_volume\_pool](#input\_root\_volume\_pool) | Worker default root volume pool | `string` | `null` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Worker default root volume size in bytes | `number` | `null` | no |
| <a name="input_rootfs_volume_pool"></a> [rootfs\_volume\_pool](#input\_rootfs\_volume\_pool) | Node default rootfs volume pool | `string` | `null` | no |
| <a name="input_secret_encryption_key"></a> [secret\_encryption\_key](#input\_secret\_encryption\_key) | Set an specific secret encryption (inteneded only for bootstrap) | `string` | `null` | no |
| <a name="input_ssh_authorized_key"></a> [ssh\_authorized\_key](#input\_ssh\_authorized\_key) | Authorized ssh key for core user | `string` | n/a | yes |
| <a name="input_sync_time_with_host"></a> [sync\_time\_with\_host](#input\_sync\_time\_with\_host) | Sync guest time with the kvm host | `bool` | `null` | no |
| <a name="input_systemd_pager"></a> [systemd\_pager](#input\_systemd\_pager) | Systemd pager | `string` | `null` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone for VMs as listed by `timedatectl list-timezones` | `string` | `null` | no |
| <a name="input_token"></a> [token](#input\_token) | K3s token for servers to join the cluster, ang agents if `agent_token` is not set | `string` | `""` | no |
| <a name="input_updates_periodic_window"></a> [updates\_periodic\_window](#input\_updates\_periodic\_window) | Only reboot for updates during certain timeframes<br>{<br>  days           = ["Sat", "Sun"],<br>  start\_time     = "22:30",<br>  length\_minutes = "60"<br>} | <pre>object({<br>    days           = list(string)<br>    start_time     = string<br>    length_minutes = string<br>  })</pre> | `null` | no |
| <a name="input_vcpu"></a> [vcpu](#input\_vcpu) | Worker default vcpu count | `number` | `null` | no |
| <a name="input_wait_for_lease"></a> [wait\_for\_lease](#input\_wait\_for\_lease) | Wait for network lease | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent_token"></a> [agent\_token](#output\_agent\_token) | K3s agent token |
| <a name="output_token"></a> [token](#output\_token) | K3s token |