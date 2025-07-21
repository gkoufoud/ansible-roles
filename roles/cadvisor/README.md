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
