# `cert-manager`/`cert`

Sets up a cert in cert-manager using an issuer.

## Example

```
module "cert-manager" {
  source = "exafi-k8s/cert-manager/kubernetes"

  common_name = "exa.fi"
}

module "cert-main-wildcard" {
  source = "exafi-k8s/cert-manager/kubernetes//cert"

  name = "exa-fi"
  issuer = module.cert-manager
  hosts = ["exa.fi", "*.exa.fi"]
}
```
