######################### values #########################
locals {
  #### module ####
  # k3s
  k3s_channel        = "stable"
  generate_etc_hosts = true
  token              = "secret"
  agent_token        = "secret"
  kubelet_config = {
    content = <<-TEMPLATE
      shutdownGracePeriod: 30s
      shutdownGracePeriodCriticalPods: 10s
    TEMPLATE
  }
  # butane common
  ssh_authorized_key = file(pathexpand("~/.ssh/id_rsa.pub"))
  # libvirt node
  vcpu             = 1
  memory           = 2048
  data_volume_size = 1024 * 1024 * 1024 * 15 # in bytes, 15 Gi
  node_groups = [
    {
      name = "controllers"
      mode = "bootstrap" # first one should always be in "bootstrap" mode
      nodes = [
        {
          fqdn            = "k3s-cluster-controller-01.example.com"
          mac             = "50:50:10:10:12:11"
          cidr_ip_address = "10.10.12.11/24"
        }
      ]
    },
    {
      name = "workers"
      mode = "agent"
      nodes = [
        {
          fqdn            = "k3s-cluster-agent-01.example.com"
          mac             = "50:50:10:10:12:21"
          cidr_ip_address = "10.10.12.21/24"
        }
      ]
    }
  ]
  #### end module values ####

  # others
  prefix = "k3s-cluster"

  # network
  net_name      = "libvirt-fcos-${local.prefix}"
  net_cidr_ipv4 = "10.10.12.0/24"
  net_cidr_ipv6 = "2001:db8:ca2:12::/64"

  # image
  image_name           = "terraform-libvirt-fcos-${local.fcos_image_name}"
  fcos_image_version   = "38.20230414.3.0"
  fcos_image_arch      = "x86_64"
  fcos_image_stream    = "stable"
  fcos_image_sha256sum = "1c036b1c57517a92f69038169cc4e9a7b327d5704732285d5d632ad9965a0436"
  fcos_image_url       = "https://builds.coreos.fedoraproject.org/prod/streams/${local.fcos_image_stream}/builds/${local.fcos_image_version}/${local.fcos_image_arch}/fedora-coreos-${local.fcos_image_version}-qemu.${local.fcos_image_arch}.qcow2.xz"
  fcos_image_name      = "fcos-${local.fcos_image_stream}-${local.fcos_image_version}-${local.fcos_image_arch}.qcow2"
}

# network
resource "libvirt_network" "k3s_cluster" {
  name      = local.net_name
  mode      = "nat"
  domain    = "cluster.local"
  addresses = [local.net_cidr_ipv4, local.net_cidr_ipv6]
}

# image
resource "null_resource" "fcos_image_download" {
  provisioner "local-exec" {
    command = <<-TEMPLATE
      pushd /tmp
      if [ ! -f "${local.fcos_image_name}" ]; then
        curl -L "${local.fcos_image_url}" -o "${local.fcos_image_name}.xz"
        echo "${local.fcos_image_sha256sum} ${local.fcos_image_name}.xz" | sha256sum -c
        unxz "${local.fcos_image_name}.xz"
      fi
      popd
    TEMPLATE
  }
}

resource "libvirt_volume" "fcos_image" {
  depends_on = [null_resource.fcos_image_download]

  name   = local.image_name
  source = "/tmp/${local.fcos_image_name}"
}

######################## module #########################
module "k3s_cluster" {
  depends_on = [libvirt_volume.fcos_image]

  source = "../.."

  # k3s-fcos-cluster
  k3s_channel        = local.k3s_channel
  generate_etc_hosts = local.generate_etc_hosts
  node_groups        = local.node_groups
  token              = "secret"
  agent_token        = "secret"
  kubelet_config     = local.kubelet_config

  # butane common
  ssh_authorized_key = local.ssh_authorized_key

  # libvirt node
  vcpu                  = local.vcpu
  memory                = local.memory
  root_base_volume_name = libvirt_volume.fcos_image.name
  data_volume_size      = local.data_volume_size

  network_id = libvirt_network.k3s_cluster.id
}


######################### outputs #########################
output "token" {
  value       = local.token
  description = "K3s token"
  sensitive   = true
}

output "agent_token" {
  value       = local.agent_token
  description = "K3s agent token"
  sensitive   = true
}
