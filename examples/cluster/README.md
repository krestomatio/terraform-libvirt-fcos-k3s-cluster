A basic example to generate a k3s ha cluster with 1 server (controller) and 1 agent (worker), using libvirt.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

## Verify

`k3s.service` (server nodes) and `k3s-agent.service` (agent nodes) should run without issues. In addition, one could check API Server for node status: `k3s kubectl get nodes`. More info in [k3s official docs](https://docs.k3s.io/)
