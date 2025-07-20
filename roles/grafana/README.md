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
- `prometheus_url`: Default is `http://localhost:9090`
  
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
  prometheus_url: "http://192.168.1.88:9090"
```
