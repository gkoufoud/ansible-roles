Fetch secret from hashicorp vault

#### Required Variables
- `vault_addr`: Vault base url
- `vault_secret_name`: The vault secret name to fetch
- `vault_mount_point` The vault mount poin (path) to store the secrets to
- `vault_token`: The vault token (required when vault_token_key and vault_token_file_path are not defined)
- `vault_token_file_path`: The file where the vault token is saved (required when vault_token is not defined)
- `vault_token_key`: Key in the vault token file where the token is defined (required when vault_token is not defined)

#### Optional Variables
- `vault_secret_output_path`: Default is `null` (Stores secret in a file)

#### Example
```yaml
vars:
  vault_addr: "http://127.0.0.1:8200"
  vault_secret_name: mycreds
  vault_mount_point: homelab
  vault_token_file_path: /opt/vault/tokens/init
  vault_token_key: init_token
```
The value is returned to variable `vault_secret_data`

