terraform {
  required_version = ">= 1.2.0"

  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.7"
    }
    ct = {
      source  = "poseidon/ct"
      version = "0.11.0"
    }
  }
}

# Configure Libvirt Provider using environment variable. Ex:
# export LIBVIRT_DEFAULT_URI="qemu+ssh://root@192.168.1.100/system"
