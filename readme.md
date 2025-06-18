Ansible Vagrant Infrastructure 📦

This repository contains the Vagrant-based infrastructure to spin up a local multi-node environment with VirtualBox, designed to serve as your Ansible control node and its managed clients.

🚀 Project Overview

Control Node: Ubuntu 22.04 VM (control) with Ansible pre-installed.

Client Nodes: Three CentOS Stream 9 VMs (web01, web02, db01) that will be configured via Ansible.

Networking: All VMs connected through a private network (192.168.56.0/24), enabling SSH connectivity without exposing ports to the host.

SSH Agent Forwarding: Shared agent socket to allow passwordless SSH from control to clients.

📁 File Structure

ansible-vagrant-infra/
├── Vagrantfile               # Defines boxes, networking, synced folder, and provisioning
├── provision-control.sh      # Installs Ansible and generates inventory on the control node
└── README.md                 # This documentation file

⚙️ Vagrantfile Configuration

VAGRANTFILE_API_VERSION: 2

control (Ubuntu)

Box: ubuntu/jammy64

Hostname: control

IP: 192.168.56.10

Synced folder: ./ansible → /home/vagrant/ansible

Provider settings: 1 GB RAM, 1 CPU

Provisioner: /provision-control.sh

Clients (web01, web02, db01)

Box: centos/stream9

Hostnames: web01, web02, db01

IPs: 192.168.56.11, .12, .13

Provider settings: 512 MB RAM, 1 CPU

Global SSH Settings

insert_key = false

forward_agent = true

🛠 Provision Script: provision-control.sh

This script runs on the control VM to:

Install Ansible via the official PPA.

Disable strict host key checking and enable agent forwarding in SSH.

Generate an inventory file (~/ansible/hosts.ini) pointing to the clients.

#!/usr/bin/env bash
set -eux

# Only run on `control`
if [[ "$(hostname)" != "control" ]]; then exit 0; fi

# 1) Install Ansible
deb_update && install_software_properties
deb_install ansible via PPA

# 2) Configure SSH
append to ~/.ssh/config:
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
  ForwardAgent yes

# 3) Create inventory
mkdir -p ~/ansible
cat > ~/ansible/hosts.ini <<EOF
[web]
web01 ansible_host=192.168.56.11 ansible_user=vagrant ansible_ssh_common_args='-o ForwardAgent=yes'
web02 ansible_host=192.168.56.12 ansible_user=vagrant ansible_ssh_common_args='-o ForwardAgent=yes'

[db]
db01  ansible_host=192.168.56.13 ansible_user=vagrant ansible_ssh_common_args='-o ForwardAgent=yes'
EOF

# Done

🎬 Usage

Clone this repository:



git clone https://github.com/youruser/ansible-vagrant-infra.git
cd ansible-vagrant-infra


2. **Launch VMs**:
   ```bash
vagrant up --provision

SSH into control:



vagrant ssh control
cd ~/ansible


4. **Ping all hosts**:
   ```bash
ansible all -i hosts.ini -m ping

Run your playbooks (e.g., site.yml):



ansible-playbook -i hosts.ini site.yml


---

## 🔒 Git Ignore

Ensure sensitive and transient files are ignored:

```gitignore
.vagrant/
*.pem
*.retry

👤 Author

Roberto C. Vazquez — LinkedIn