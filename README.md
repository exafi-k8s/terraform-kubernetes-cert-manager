# `terraform-k8s-cert-manager`

Sets up cert-manager, a cluster issuer with a private CA,
and makes a cert module available to issuing certs.

## Example

```
module "cert-manager" {
  source = "exafi-k8s/cert-manager"

  common_name = "exa.fi"
}

module "cert-main-wildcard" {
  source = "exafi-k8s/cert"

  name = "exa-fi"
  issuer = module.cert-manager
  hosts = ["exa.fi", "*.exa.fi"]
}
```

## License

See [LICENSE](./LICENSE) file.
