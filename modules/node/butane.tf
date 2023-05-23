module "butane_k3s_snippets" {
  source  = "krestomatio/butane-snippets/ct//modules/k3s"
  version = "0.0.26"

  config            = var.k3s_config
  mode              = var.mode
  secret_encryption = { key = var.secret_encryption_key }
  token             = var.token
  agent_token       = var.agent_token
  channel           = var.k3s_channel
  origin_server     = var.origin_server
  fleetlock         = var.k3s_fleetlock
}
