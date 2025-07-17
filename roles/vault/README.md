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
```
