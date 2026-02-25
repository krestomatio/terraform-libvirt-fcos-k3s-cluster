module "butane_k3s_snippets" {
  source  = "krestomatio/butane-snippets/ct//modules/k3s"
  version = "0.0.100"

  selinux               = var.selinux
  data_dir              = var.data_dir
  install_script        = var.install_script
  script_envvars        = var.script_envvars
  script_parameters     = var.script_parameters
  repo_baseurl          = var.repo_baseurl
  repo_gpgkey           = var.repo_gpgkey
  testing_repo          = var.testing_repo
  testing_repo_baseurl  = var.testing_repo_baseurl
  testing_repo_gpgkey   = var.testing_repo_gpgkey
  mode                  = var.mode
  secret_encryption_key = var.secret_encryption_key
  token                 = var.token
  agent_token           = var.agent_token
  channel               = var.k3s_channel
  origin_server         = var.origin_server
  fleetlock             = var.k3s_fleetlock
  kubelet_config        = var.kubelet_config
}
