Install Promtail

#### Required Variables
- `base_dir`: The Promtail installation directory
- `loki_url`: The grafana loki url

#### Optional Variables
- `image`: Default is `grafana/promtail:3.5.3`
- `container_name`: Default is `promtail`
- `scrape_docker_logs:` Default is `true`

#### Example
```yaml
vars:
  base_dir: /opt/promtail
  container_name: "promtail"
  image: grafana/loki:3.4.1
  loki_url: "http://192.168.1.100:3100/loki/api/v1/push"
  scrape_docker_logs: true
```
