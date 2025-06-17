VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Base box for the control node (Ubuntu 22.04) used to manage Ansible configurations
  config.vm.define "control" do |c|
    c.vm.box = "ubuntu/jammy64"
    c.vm.hostname = "control"
    c.vm.network "private_network", ip: "192.168.56.10"
    c.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus   = 1
    end
    # Provision to install Ansible
    c.vm.provision "shell", path: "provision-control.sh"
  end

  # CentOS Clients
  %w[web01 web02 db01].each_with_index do |name, idx|
    config.vm.define name do |node|
      node.vm.box = "centos/9"
      node.vm.hostname = name
      # IPs 192.168.56.11, .12, .13
      node.vm.network "private_network", ip: "192.168.56.1#{1+idx}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus   = 1
      end
      # No provision: it will remain "fresh", Ansible will configure it later
    end
  end

  # Prevents accidental NAT and speeds up SSH
  config.ssh.insert_key = false
end
