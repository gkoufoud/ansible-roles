Install wireguard (wg-portal)

#### Required Variables
- `base_dir`: The wg-portal installation directory
- `domain`: The wg-portal external domain
- `hostname` The wg-portal hostname
- `admin_user`: The wg-portal admin user
- `admin_password`: The wg-portal admin password
- `admin_api_token`: The wg-portal admin api token (uuid)
- `csrf_secret`: The wg-portal csrf_secret
- `session_secret`: The wg-portal session secret
- `interfaces`: A list of interfaces

#### Optional Variables
- `image`: Default is `wgportal/wg-portal:v2.0.3`
- `container_name`: Default is `wg-portal`
- `oidc_enabled`: Default is `false`
- `oidc_admin_group`: The wg-portal admin group mapped in oidc provider
  
#### Example
```yaml
vars:
  base_dir: /opt/wireguard
  interfaces:
    - name: wg0
      port: 51820
      cidr: 10.11.12.0/24
      peer_defaults:
        allowed_ips: 
          - 0.0.0.0/0
        dns: 
          - 8.8.8.8
      peers:
        - name: my-iphone
        - name: my-macbook-pro
  domain: "mydomain.com"
  hostname: vpn
  admin_user: "admin@mydomain.com"
  admin_password: "myadminpass"
  admin_api_token: "bd068c3d-84cf-4368-9a49-de86e239622f"
  csrf_secret: "mycsrfsecret1234567890"
  session_secret: "mysessionsecret0987654321"
  oidc_enabled: true
  oidc_client_id: "myoidcclientid"
  oidc_client_secret: "myoidcclientsecret493258903453245"
  oidc_admin_group: "wg-admin"
```
