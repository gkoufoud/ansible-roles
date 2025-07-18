Install Authentik, create groups, users and oidc_providers

#### Required Variables
- `base_dir`: The authentik installation directory
- `domain`: The authentik domain name
- `pg_pass`: The authentik postgres password
- `secret_key`: The authentik secret key
- `bootstrap_pass`: The authentik bootstrap password
- `bootstrap_token`: The authentik bootstrap token
- `bootstrap_email`: The authentik bootstrap email

#### Optional Variables
- `authentik_users`: Default is `[]` (List of users to create)
- `authentik_groups`: Default is `[]` (List of groups to create)
- `oidc_oauth2_providers`: Default is `[]` (List of oidc/oauth2 providers to create)
  
#### Example
```yaml
vars:
  base_dir: /opt/authentik
  authentik_users:
    - username: "johndoe"
      name: "John Doe"
      email: "johndoe@example.com"
      groups: ["authentik Admins", "vault-admin", "wg-user"]
    - username: "janedoe"
      name: "Jane Doe"
      email: "janedoe@example.com"
      groups: ["nextcloud-admin", "registry-ui-user"]
  groups:
    - name: "vault-admin"
    - name: "vault-reader"
    - name: "vault-homelab-admin"
    - name: "vault-homelab-reader"
    - name: "proxmox-admin"
    - name: "wg-admin"
    - name: "wg-user"
    - name: "nextcloud-admin"
    - name: "nextcloud-user"
    - name: "registry-ui-user"
  oidc_oauth2_providers:
    - name: "wireguard"
      application_url: https://vpn.example.com:443
      redirect_uris:
        - https://vpn.example.com:443
        - https://vpn.example.com/app/*
        - http://localhost:51821
      groups:
        - "wg-admin"
        - "wg-user"
    - name: "nextcloud"
      application_url: https://box.example.com:443
      redirect_uris:
        - http://box.example.com/apps/sociallogin/custom_oidc/Authentik
      groups:
        - "nextcloud-admin"
        - "nextcloud-user"
  pg_pass: "supersecretpass123"
  secret_key: "supersecretkey123"
  bootstrap_email: "admin@example.com"
  bootstrap_pass: "supersecretbootstrapPass123"
  bootstrap_token: "supeRs3cr3tToken321"
  domain: "example.com"
```
