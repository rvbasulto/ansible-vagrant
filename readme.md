# Ansible Vagrant Lab

This project sets up a local multi-node lab environment using Vagrant, VirtualBox, and Ansible. It is designed for practicing infrastructure automation, configuration management, and provisioning tasks across heterogeneous Linux systems (Ubuntu and CentOS).

## Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Provisioning Flow](#provisioning-flow)
- [Technologies Used](#technologies-used)
- [How to Use](#how-to-use)
- [Ansible Automation](#ansible-automation)
- [Directory Structure](#directory-structure)
- [Future Improvements](#future-improvements)

---

## Project Overview

This environment includes one control node (Ubuntu) and four managed nodes (CentOS and Ubuntu), all connected via a private network. The control node installs and configures Ansible automatically using a shell script. Ansible then provisions the rest of the nodes via SSH with agent forwarding enabled.

The setup enables:
- Practicing Ansible roles, tasks, templates, and conditionals
- Cross-platform automation with distribution-aware logic
- Real-world DevOps testing scenarios on a local machine

---

## Architecture

| Node     | OS             | Role        | IP Address       |
|----------|----------------|-------------|------------------|
| control  | Ubuntu 22.04   | Ansible control node | 192.168.56.10 |
| web01    | CentOS Stream 9| Web server  | 192.168.56.11    |
| web02    | CentOS Stream 9| Web server  | 192.168.56.12    |
| web03    | Ubuntu 22.04   | Web server  | 192.168.56.13    |
| db01     | CentOS Stream 9| Database    | 192.168.56.14    |

---

## Provisioning Flow

1. `vagrant up` launches all VMs with configured hostnames and static private IPs.
2. The control node runs `provision-control.sh`, which:
   - Installs Ansible
   - Configures SSH for agent forwarding
   - Creates a dynamic Ansible inventory and `ansible.cfg`
3. Ansible provisions the remote nodes using the `provisioning.yaml` playbook and `post-install` role.

---

## Technologies Used

- **Vagrant**: VM provisioning and network setup
- **VirtualBox**: Local virtualization backend
- **Ansible**: Automation engine for configuration and provisioning
- **Bash**: Shell scripting for control node bootstrapping
- **YAML & Jinja2**: For playbooks and templating

---

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ansible-vagrant.git
   cd ansible-vagrant
