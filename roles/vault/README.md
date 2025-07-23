Install hashicorp vault

#### Required Variables
- `base_dir`: The vault directory (e.g., `/opt/vault`)

#### Optional Variables
- `default_lease_ttl`: Default is `168h`
- `max_lease_ttl`: Default is `720h`
- `userid`: Default is `100`
- `groupid`: Default is `100`
- `container_name`: Default is `vault`
- `image`: Default is `hashicorp/vault:1.19`
- `listen_port`: Default is `8200`
- `policies`: Default is `[]`
- `tokens`: Default is `[]`
- `kv2_engines`: Default is `[]`
  
#### Example
```yaml
vars:
  base_dir: /opt/vault
  default_lease_ttl: 168h
  max_lease_ttl: 720h
  userid: 100
  groupid: 100
  container_name: vault
  image: hashicorp/vault:1.19
  listen_port: 8200
  policies:
    - name: vault-admin
      path: "*"
      capabilities: ["create", "read", "update", "delete", "list", "sudo"]
    - name: vault-reader
      path: "*"
      capabilities: ["read", "list"]
    - name: homelab-admin
      path: "homelab/*"
      capabilities: ["create", "read", "update", "delete", "list", "sudo"]
  tokens:
    - name: homelab-admin
      policies: ["homelab-admin"]
  kv2_engines:
    - name: homelab
```
