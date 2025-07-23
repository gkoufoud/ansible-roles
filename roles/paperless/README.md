Install Paperless-ngx

#### Required Variables
- `base_dir`: The Paperless installation directory
- `secret_key`: The Paperless secret key

#### Optional Variables
- `paperless_image`: Default is `paperlessngx/paperless-ngx:2.17.1`
- `redis_image`: Default is `docker.io/library/redis:8`
- `gotenberg_image`: Default is `docker.io/gotenberg/gotenberg:8.20`
- `exporter_image` Default is `ghcr.io/hansmi/prometheus-paperless-exporter:v0.0.8`
- `container_name`: Default is `paperless`
- `lister_port`: Default is `8000`
- `metrics_listen_port`: Default is `8001`
- `enable_tika`: Default is `true`
- `extra_environment_vars`: Default is `[]` (Appends environment variables to the docker compose file)
- `uid`: Default is `1000`
- `gid`: Default is `1000`
- `url`: Default is `""` (sets the PAPERLESS_URL environment variable)
- `tz`: Default is `UTC`
- `default_ocr_lang`: Default is `eng`
- `extra_ocr_lang`: Default is `""`
- `enable_metrics` Default is `false` (Deploy paperless-ngx-exporter)
  
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
  enable_metrics: true
  metrics_listen_port: 7491
```
