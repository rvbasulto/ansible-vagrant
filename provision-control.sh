#!/usr/bin/env bash
set -eux

# Solo corre en el nodo "control"
if [[ "$(hostname)" != "control" ]]; then
  exit 0
fi

# Instala Ansible
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

# Desactiva la verificación de huella y activa el agent forwarding
cat <<EOF >> ~/.ssh/config
Host 192.168.56.*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
  ForwardAgent yes
EOF

# Crea tu inventario
mkdir -p /home/vagrant/ansible
cat <<EOF > /home/vagrant/ansible/hosts.ini
[web]
web01 ansible_host=192.168.56.11 ansible_user=vagrant ansible_ssh_common_args='-o ForwardAgent=yes'
web02 ansible_host=192.168.56.12 ansible_user=vagrant ansible_ssh_common_args='-o ForwardAgent=yes'

[db]
db01  ansible_host=192.168.56.13 ansible_user=vagrant ansible_ssh_common_args='-o ForwardAgent=yes'
EOF

cat <<EOF > /home/vagrant/ansible/ansible.cfg
[defaults]
inventory = hosts.ini
host_key_checking = False
EOF

chmod go-w /home/vagrant
chown -R vagrant:vagrant /home/vagrant/ansible
chmod -R 750 /home/vagrant/ansible

echo "===>>> Control node ready. Inventory at ~/ansible/hosts.ini"
