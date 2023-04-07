######################### values #########################
locals {
  cluster_name       = "k3s-standalone-cluster"
  generate_etc_hosts = true
  # butane common
  ssh_authorized_key = file(pathexpand("~/.ssh/id_rsa.pub"))
  # libvirt node
  vcpu             = 1
  memory           = 1024
  data_volume_size = 1024 * 1024 * 1024 * 15 # in bytes, 15 Gi
  net_cidr_ipv4    = "10.10.10.0/24"
  net_cidr_ipv6    = "2001:db8:ca2:2::/64"
  k3s_channel      = "stable"
  node_groups = [
    {
      name = "standalone"
      mode = "bootstrap"
      nodes = [
        {
          fqdn            = "k3s-standalone-cluster-01.example.com"
          mac             = "50:50:10:10:10:11"
          cidr_ip_address = "10.10.10.11/24"
        }
      ]
    }
  ]
  # image
  fcos_image_version   = "37.20230303.3.0"
  fcos_image_arch      = "x86_64"
  fcos_image_stream    = "stable"
  fcos_image_sha256sum = "98bf7b4707439ac8a0cc35ced01f5fab450ccbe5be56d8ae1a7b630d1c3ab0ae"
  fcos_image_url       = "https://builds.coreos.fedoraproject.org/prod/streams/${local.fcos_image_stream}/builds/${local.fcos_image_version}/${local.fcos_image_arch}/fedora-coreos-${local.fcos_image_version}-qemu.${local.fcos_image_arch}.qcow2.xz"
  fcos_image_name      = "fcos-${local.fcos_image_stream}-${local.fcos_image_version}-${local.fcos_image_arch}.qcow2"
}

# network
resource "libvirt_network" "k3s_standalone_cluster" {
  name      = "k3s-standalone-cluster"
  mode      = "nat"
  domain    = "cluster.local"
  addresses = [local.net_cidr_ipv4, local.net_cidr_ipv6]
}

# image
resource "null_resource" "fcos_image_download" {
  provisioner "local-exec" {
    command = <<-TEMPLATE
      if [ ! -f "${local.fcos_image_name}" ]; then
        curl -L "${local.fcos_image_url}" -o "${local.fcos_image_name}.xz"
        echo "${local.fcos_image_sha256sum} ${local.fcos_image_name}.xz" | sha256sum -c
        unxz "${local.fcos_image_name}.xz"
      fi
    TEMPLATE
  }
}

resource "libvirt_volume" "fcos_image" {
  depends_on = [null_resource.fcos_image_download]

  name   = local.fcos_image_name
  source = local.fcos_image_name
}

######################## module #########################
module "k3s_standalone_cluster" {
  depends_on = [libvirt_volume.fcos_image]

  source = "../.."

  # k3s-fcos-cluster
  cluster_name       = local.cluster_name
  generate_etc_hosts = local.generate_etc_hosts
  node_groups        = local.node_groups

  # butane common
  ssh_authorized_key = local.ssh_authorized_key

  # libvirt node
  vcpu                  = local.vcpu
  memory                = local.memory
  root_base_volume_name = libvirt_volume.fcos_image.name
  data_volume_size      = local.data_volume_size

  network_id = libvirt_network.k3s_standalone_cluster.id
}


######################### outputs #########################
output "token" {
  value       = module.k3s_standalone_cluster.token
  description = "K3s token"
  sensitive   = true
}

output "agent_token" {
  value       = module.k3s_standalone_cluster.agent_token
  description = "K3s agent token"
  sensitive   = true
}
