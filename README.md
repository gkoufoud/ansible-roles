# ansible-roles
This repository contains a list of ansible roles for installing and configuring software.

The roles are deployed in docker containers.

## `Roles`
- [authentik](#authentik)
- [cadvisor](#cadvisor)
- [cf_ddns](#cf_ddns)
- [coredns](#coredns)
- [docker_install](#docker_install)
- [grafana](#grafana)
- [node_exporter](#node_exporter)
- [paperless](#paperless)
- [proxmox_template](#proxmox_template)
- [proxmox_vm](#proxmox_vm)
- [vault_secret_fetch](#vault_secret_fetch)
- [vault_secret_store](#vault_secret_store)
- [vault](#vault)
- [wireguard](#wireguard)

### `authentik`
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

### `cadvisor`
Install cAdvisor

#### Required Variables
- `base_dir`: The cAdvisor installation directory

#### Optional Variables
- `image`: Default is `gcr.io/cadvisor/cadvisor:v0.52.1`
- `container_name`: Default is `cadvisor`
- `lister_port`: Default is `8080`
  
#### Example
```yaml
vars:
  base_dir: /opt/cadvisor
  image: gcr.io/cadvisor/cadvisor:v0.52.1
  container_name: "cadvisor"
  lister_port: 8049
```

### `cf_ddns`
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

### `coredns`
Install Coredns, and create zones

#### Required Variables
- `base_dir`: The coredns installation directory

#### Optional Variables
- `container_name`: Default is `coredns`
- `image`: Default is `coredns/coredns:1.12.2`
- `upstream_dns`: Default is `["1.1.1.1", "8.8.8.8"]` (List of upstream dns servers)
- `zones`: Default is `[]` (List of zones to create)
  
#### Example
```yaml
vars:
  base_dir: /opt/coredns
  container_name: coredns
  image: coredns/coredns:1.12.2
  upstream_dns:
    - 8.8.8.8
    - 8.8.4.4
  zones:
    - name: "example.com"
      file: "example.com.db"
      hosts:
        '*': ansible_host,
        'gw': "192.168.1.1"
        'mypc': '192.168.1.100' 
```

### `docker_install`
Install required packages

### `grafana`
Install Grafana

#### Required Variables
- `base_dir`: The Grafana installation directory
- `admin_user`: The Grafana admin username
- `admin_pass`: The Grafana admin password

#### Optional Variables
- `image`: Default is `grafana/grafana:12.0.2`
- `container_name`: Default is `grafana`
- `lister_port`: Default is `3000`
- `plugins`: Default is `""`
- `service_account_name`: Default is `""` (If set to a non-empty string it will create an Admin service account)
- `service_account_token_name`: Default is `""` (If set to a non-empty string and service_account_name is also a non-empty string, it will create a token for the Admin service account)
- `service_account_token_filename`: Default is `automation-token.json` (If set to a non-empty variable, the token is saved to file token/filename)
- `extra_environment_vars`: Default is `[]` (Appends environment variables to the docker compose file)
  
#### Example
```yaml
vars:
  base_dir: /opt/grafana
  admin_user: 'admin'
  admin_pass: 'mygrafanasecurepassword123'
  image: grafana/grafana:12.0.2
  container_name: "grafana"
  lister_port: 3000
  plugins: "grafana-clock-panel, grafana-simple-json-datasource"
  extra_environment_vars:
    - GF_AUTH_GENERIC_OAUTH_ENABLED=true
    - GF_AUTH_GENERIC_OAUTH_NAME=Authentik
    - GF_AUTH_GENERIC_OAUTH_CLIENT_ID=my-client-id
    - GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET=my-secret
    - GF_AUTH_GENERIC_OAUTH_AUTH_URL=https://auth.example.com/authorize/
    - GF_AUTH_GENERIC_OAUTH_TOKEN_URL=https://auth.example.com/token/
    - GF_AUTH_GENERIC_OAUTH_API_URL=https://auth.example.com/userinfo/
```

### `node_exporter`
Install node-exporter

#### Required Variables
- `base_dir`: The node-exporter installation directory

#### Optional Variables
- `image`: Default is `prom/node-exporter:v1.9.1`
- `container_name`: Default is `node-exporter`
- `lister_port`: Default is `9100`
  
#### Example
```yaml
vars:
  base_dir: /opt/node_exporter
  image: prom/node-exporter:v1.9.1
  container_name: "node-exporter"
  lister_port: 9100
```

### `paperless`
Install Paperless-ngx

#### Required Variables
- `base_dir`: The Paperless installation directory
- `secret_key`: The Paperless secret key

#### Optional Variables
- `paperless_image`: Default is `paperlessngx/paperless-ngx:2.17.1`
- `redis_image`: Default is `docker.io/library/redis:8`
- `gotenberg_image`: Default is `docker.io/gotenberg/gotenberg:8.20`
- `container_name`: Default is `paperless`
- `lister_port`: Default is `8000`
- `enable_tika`: Default is `true`
- `extra_environment_vars`: Default is `[]` (Appends environment variables to the docker compose file)
- `uid`: Default is `1000`
- `gid`: Default is `1000`
- `url`: Default is `""` (sets the PAPERLESS_URL environment variable)
- `tz`: Default is `UTC`
- `default_ocr_lang`: Default is `eng`
- `extra_ocr_lang`: Default is `""`
  
#### Example
```yaml
vars:
  base_dir: /opt/paperless
  secret_key: my-secret-key-123
  paperless_image: "paperlessngx/paperless-ngx:2.17.1"
  container_name: paperless
  enable_tika: true
  lister_port: 7490
  extra_environment_vars:
    - "PAPERLESS_ALLOWED_HOSTS=192.168.1.234,localhost,{{ ansible_host }}"
    - "PAPERLESS_ADMIN_USER=admin"
    - "PAPERLESS_ADMIN_MAIL=admin@example.com"
    - "PAPERLESS_ADMIN_PASSWORD=my-admin-password4321"
    - "PAPERLESS_APPS=allauth.socialaccount.providers.openid_connect"
    - "PAPERLESS_SOCIAL_AUTO_SIGNUP=true"
    - "PAPERLESS_SOCIAL_ACCOUNT_SYNC_GROUPS=true"
    - "PAPERLESS_SOCIALACCOUNT_PROVIDERS={\"openid_connect\":{\"SCOPE\":[\"openid\",\"profile\",\"email\",\"groups\"],\"OAUTH_PKCE_ENABLED\":true,\"APPS\":[{\"provider_id\":\"authentik\",\"name\":\"Authentik\",\"client_id\":\"oidc_client_id\",\"secret\":\"oidc_client_secret\",\"settings\":{\"server_url\":\"https://sso.example.com/application/o/paperless/.well-known/openid-configuration\",\"token_auth_method\":\"client_secret_basic\"}}]}}"
  url: "https://paperless.example.com"
  tz: UTC
  default_ocr_lang: eng
  extra_ocr_lang: "ell"
```

### `proxmox_template`
Create a proxmox VM template

#### Required Variables
- `api_user`: Proxmox api username
- `api_password`: Proxmox api user password
- `api_host`: Proxmox api host name or IP address
- `storage_name`: Proxmox storage name for the template
- `configuration`: Map with the following attributes:
  - `name`: Template name
  - `node`: The proxmox node to deply this template to
  - `id`: The template vmid
  - `disk_size`: The template disk size (e.g. 80G)
  - `username`: The template cloud-init user (e.g. user1)
  - `password`: The template cloud-init password (e.g. changemenow)

#### Optional Variables
- `api_port`: Default is `8006`
- `cloud_image_name`: Default is `"debian-12-genericcloud-amd64"`
- `cloud_image_version`: Default is `"20250530-2128"`
- `cloud_image_distro`: Default is `"bookworm"`
  
#### Example
```yaml
vars:
  api_user: "root@pam"
  api_password: "mypassword"
  api_host: 192.168.1.50
  api_port: 8006
  storage_name: VM-DISKS
  configuration:
    name: debian_template
    node: pve1
    id: 9000
    disk_size: "80G"
    username: "user"
    password: "password"
```
### `proxmox_vm`
Create proxmox virtual machines from a template

#### Required Variables
- `api_user`: Proxmox api username
- `api_password`: Proxmox api user password
- `api_host`: Proxmox api host name or IP address
- `template_name`: Proxmox template
- `vms`: A list of maps with vm data:
  - `name`: VM name (e.g. `myvm`)
  - `vmid`: The vmid (e.g. `134`)
  - `pve_node`: The proxmox node to create the VM (e.g. `pve1`)
  - `storage`: The proxmox storage name
  - `cpu_cores`: The number of cpu cores of the VM (e.g. `2`)
  - `memory_balloon`: The amount a balloon memory to allocate to the VM (e.g., `4096`)
  - `net0`: The network configuration of the VM (e.g. `virtio,bridge=vmbr0`)
  - `ipconfig0`: The ipconfig0 of the VM (e.g., `ip=192.168.1.57/24,gw=192.168.1.1`)
  - `nameservers`: The nameservers of the VM (e.g., `192.168.1.1`)
  - `ciuser`: The cloud-init username (e.g., `myuser`)
  - `cipassword`: The cloud-init password (e.g., `mypassword123`)

#### Optional Variables
- `api_port`: Default is `8006`
  
#### Example
```yaml
vars:
  api_user: "root@pam"
  api_password: "mypassword"
  api_host: 192.168.1.50
  api_port: 8006
  template_name: "DebianTemplate"
  vms:
    - name: "mynewnode"
      vmid: 200
      pve_node: "pve1"
      storage: "VM-DISKS"
      cpu_cores: 1
      memory_balloon: 4096
      net0: 'virtio,bridge=vmbr0'
      ipconfig0: "ip=192.168.1.57/24,gw=192.168.1.1"
      nameservers: "192.168.1.1"
      ciuser: "myuser"
      cipassword: "mynewpass123"
```
### `vault_secret_fetch`
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


### `vault_secret_store`
Store/Update secrets in hashicorp vault

#### Required Variables
- `vault_addr`: Vault base url
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
  vault_addr: "http://127.0.0.1:8200"
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

### `vault`
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

### `wireguard`
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

