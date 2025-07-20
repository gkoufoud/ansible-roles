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
