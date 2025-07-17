# ansible-roles
This repository contains a list of ansible roles.
##Roles
- [proxmox_template](#proxmox_template)

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
