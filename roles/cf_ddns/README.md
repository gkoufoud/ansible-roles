Install cloudflare ddns

#### Required Variables
- `base_dir`: The cf_ddns installation directory
- `domain`: The cloudflare hosted domain name
- `CLOUDFLARE_API_TOKEN` The cloudflare api token

#### Optional Variables
- `create_le_caa`: Default is `false` (Create let's encrypt CAA record)
- `cnames`: Default is `[]` (List of domain names pointing to main domain)
  
#### Example
```yaml
vars:
  base_dir: /opt/cf_ddns
  create_le_caa: true
  domain: "mydomain.com"
  cnames:
    - "*"
    - "subdomain"
    - "*.subdomain"
  CLOUDFLARE_API_TOKEN: "mycloudflare-api-token"
```
