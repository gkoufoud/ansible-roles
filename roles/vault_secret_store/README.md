Store/Update secrets in hashicorp vault

#### Required Variables
- `vault_secrets`: A list of maps with vault secrets
- `vault_mount_point` The vault mount poin (path) to store the secrets to
- `vault_token`: The vault token (required when vault_token_key and vault_token_file_path are not defined)
- `vault_token_file_path`: The file where the vault token is saved (required when vault_token is not defined)
- `vault_token_key`: Key in the vault token file where the token is defined (required when vault_token is not defined)

#### Optional Variables
- `force_update`: Default is `true`
  
#### Example
```yaml
vars:
  vault_mount_point: homelab
  vault_token_file_path: /opt/vault/tokens/init
  vault_token_key: init_token
  vault_secrets:
    - name: "cloudflare"
      data:
        CLOUDFLARE_API_KEY: "my_cf_api_key"
        CLOUDFLARE_EMAIL: "my_cf_email"
        CLOUDFLARE_API_TOKEN: "my_cf_api_token"
    - name: "localregistry"
      data:
        REGISTRY_ADMIN_USER: "admin"
        REGISTRY_ADMIN_PASS: "my_admin_pass_123"
```
