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
