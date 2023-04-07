<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_ct"></a> [ct](#requirement\_ct) | 0.11.0 |
| <a name="requirement_libvirt"></a> [libvirt](#requirement\_libvirt) | ~> 0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ct"></a> [ct](#provider\_ct) | 0.11.0 |
| <a name="provider_libvirt"></a> [libvirt](#provider\_libvirt) | ~> 0.7 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_butane_common_snippets"></a> [butane\_common\_snippets](#module\_butane\_common\_snippets) | ../../../butane-snippets/modules/common/ | n/a |
| <a name="module_butane_k3s_snippets"></a> [butane\_k3s\_snippets](#module\_butane\_k3s\_snippets) | ../../../butane-snippets/modules/k3s | n/a |

## Resources

| Name | Type |
|------|------|
| [libvirt_domain.node](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/domain) | resource |
| [libvirt_ignition.node](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/ignition) | resource |
| [libvirt_volume.backup](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [libvirt_volume.data](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [libvirt_volume.log](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [libvirt_volume.root](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [ct_config.node](https://registry.terraform.io/providers/poseidon/ct/0.11.0/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_rpms"></a> [additional\_rpms](#input\_additional\_rpms) | Additional rpms to install during boot using rpm-ostree, along with any pre or post command | <pre>object(<br>    {<br>      cmd_pre  = optional(list(string), [])<br>      list     = optional(list(string), [])<br>      cmd_post = optional(list(string), [])<br>    }<br>  )</pre> | <pre>{<br>  "cmd_post": [],<br>  "cmd_pre": [],<br>  "list": []<br>}</pre> | no |
| <a name="input_agent_token"></a> [agent\_token](#input\_agent\_token) | K3s token for agents to join the cluster | `string` | `null` | no |
| <a name="input_autostart"></a> [autostart](#input\_autostart) | Autostart with libvirt host | `bool` | `true` | no |
| <a name="input_backup_volume_pool"></a> [backup\_volume\_pool](#input\_backup\_volume\_pool) | Node default backup volume pool | `string` | `null` | no |
| <a name="input_backup_volume_size"></a> [backup\_volume\_size](#input\_backup\_volume\_size) | Node default backup volume size in bytes | `number` | `21474836480` | no |
| <a name="input_butane_snippets_additional"></a> [butane\_snippets\_additional](#input\_butane\_snippets\_additional) | Additional butane snippets | `list(string)` | `[]` | no |
| <a name="input_cidr_ip_address"></a> [cidr\_ip\_address](#input\_cidr\_ip\_address) | CIDR IP Address. Ex: 192.168.1.101/24 | `string` | `null` | no |
| <a name="input_cpu_mode"></a> [cpu\_mode](#input\_cpu\_mode) | Libvirt default cpu mode for VMs | `string` | `"host-passthrough"` | no |
| <a name="input_data_volume_pool"></a> [data\_volume\_pool](#input\_data\_volume\_pool) | Node default data volume pool | `string` | `null` | no |
| <a name="input_data_volume_size"></a> [data\_volume\_size](#input\_data\_volume\_size) | Node default data volume size in bytes | `number` | `21474836480` | no |
| <a name="input_do_not_countme"></a> [do\_not\_countme](#input\_do\_not\_countme) | Disable Fedora CoreOS infrastructure count me feature | `bool` | `true` | no |
| <a name="input_etc_hosts"></a> [etc\_hosts](#input\_etc\_hosts) | /etc/host list | <pre>list(<br>    object(<br>      {<br>        ip       = string<br>        hostname = string<br>        fqdn     = string<br>      }<br>    )<br>  )</pre> | `null` | no |
| <a name="input_etc_hosts_extra"></a> [etc\_hosts\_extra](#input\_etc\_hosts\_extra) | /etc/host extra block | `string` | `null` | no |
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | Node FQDN | `string` | n/a | yes |
| <a name="input_ignition_pool"></a> [ignition\_pool](#input\_ignition\_pool) | Default ignition files pool | `string` | `null` | no |
| <a name="input_initrd_volume_pool"></a> [initrd\_volume\_pool](#input\_initrd\_volume\_pool) | Node default initrd volume pool | `string` | `null` | no |
| <a name="input_interface_name"></a> [interface\_name](#input\_interface\_name) | Network interface name | `string` | `null` | no |
| <a name="input_k3s_channel"></a> [k3s\_channel](#input\_k3s\_channel) | K3s installation channel | `string` | `null` | no |
| <a name="input_k3s_config"></a> [k3s\_config](#input\_k3s\_config) | K3s configuration | <pre>object(<br>    {<br>      envvars          = optional(list(string))<br>      parameters       = optional(list(string))<br>      selinux          = optional(bool)<br>      data_dir         = optional(string)<br>      script_url       = optional(string)<br>      script_sha256sum = optional(string)<br>      repo_baseurl     = optional(string)<br>      repo_gpgkey      = optional(string)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_kernel_volume_pool"></a> [kernel\_volume\_pool](#input\_kernel\_volume\_pool) | Node default kernel volume pool | `string` | `null` | no |
| <a name="input_keymap"></a> [keymap](#input\_keymap) | Keymap | `string` | `null` | no |
| <a name="input_log_volume_pool"></a> [log\_volume\_pool](#input\_log\_volume\_pool) | Node default log volume pool | `string` | `null` | no |
| <a name="input_log_volume_size"></a> [log\_volume\_size](#input\_log\_volume\_size) | Node default log volume size in bytes | `number` | `5368709120` | no |
| <a name="input_mac"></a> [mac](#input\_mac) | Mac address | `string` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Node default memory in MiB | `number` | `512` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | K3s installation mode:<br>"bootstrap": bootstrap a cluster, then be a server<br>"server": start a server<br>"agent": start an agent | `string` | `"bootstrap"` | no |
| <a name="input_nameservers"></a> [nameservers](#input\_nameservers) | List of nameservers for VMs | `list(string)` | <pre>[<br>  "8.8.8.8"<br>]</pre> | no |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | Libvirt default network bridge name for VMs | `string` | `null` | no |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | Libvirt default network id for VMs | `string` | `null` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Libvirt default network name for VMs | `string` | `null` | no |
| <a name="input_origin_server"></a> [origin\_server](#input\_origin\_server) | Server host to connect nodes to (ex: https://example:6443) | `string` | `null` | no |
| <a name="input_qemu_agent"></a> [qemu\_agent](#input\_qemu\_agent) | Install qemu guest agent | `bool` | `true` | no |
| <a name="input_rollout_wariness"></a> [rollout\_wariness](#input\_rollout\_wariness) | Wariness to update, 1.0 (very cautious) to 0.0 (very eager) | `string` | `null` | no |
| <a name="input_root_base_volume_name"></a> [root\_base\_volume\_name](#input\_root\_base\_volume\_name) | Node default base root volume name | `string` | n/a | yes |
| <a name="input_root_base_volume_pool"></a> [root\_base\_volume\_pool](#input\_root\_base\_volume\_pool) | Node default base root volume pool | `string` | `null` | no |
| <a name="input_root_volume_pool"></a> [root\_volume\_pool](#input\_root\_volume\_pool) | Node default root volume pool | `string` | `null` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Node default root volume size in bytes | `number` | `21474836480` | no |
| <a name="input_rootfs_volume_pool"></a> [rootfs\_volume\_pool](#input\_rootfs\_volume\_pool) | Node default rootfs volume pool | `string` | `null` | no |
| <a name="input_secret_encryption_key"></a> [secret\_encryption\_key](#input\_secret\_encryption\_key) | Set an specific secret encryption (inteneded only for bootstrap) | `string` | `null` | no |
| <a name="input_ssh_authorized_key"></a> [ssh\_authorized\_key](#input\_ssh\_authorized\_key) | Authorized ssh key for core user | `string` | n/a | yes |
| <a name="input_sync_time_with_host"></a> [sync\_time\_with\_host](#input\_sync\_time\_with\_host) | Sync guest time with the kvm host | `bool` | `true` | no |
| <a name="input_systemd_pager"></a> [systemd\_pager](#input\_systemd\_pager) | Systemd pager | `string` | `"cat"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone for VMs as listed by `timedatectl list-timezones` | `string` | `null` | no |
| <a name="input_token"></a> [token](#input\_token) | K3s token for servers to join the cluster, ang agents if `agent_token` is not set | `string` | n/a | yes |
| <a name="input_updates_periodic_window"></a> [updates\_periodic\_window](#input\_updates\_periodic\_window) | Only reboot for updates during certain timeframes<br>{<br>  days           = ["Sat", "Sun"],<br>  start\_time     = "22:30",<br>  length\_minutes = "60"<br>} | <pre>object({<br>    days           = list(string)<br>    start_time     = string<br>    length_minutes = string<br>  })</pre> | `null` | no |
| <a name="input_vcpu"></a> [vcpu](#input\_vcpu) | Node default vcpu count | `number` | `1` | no |
| <a name="input_wait_for_lease"></a> [wait\_for\_lease](#input\_wait\_for\_lease) | Wait for network lease | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->