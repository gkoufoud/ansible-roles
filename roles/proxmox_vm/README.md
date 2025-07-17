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