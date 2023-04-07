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
