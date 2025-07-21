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
```
