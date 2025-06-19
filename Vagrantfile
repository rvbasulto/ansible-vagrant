VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "control" do |c|
    c.vm.box = "ubuntu/jammy64"
    c.vm.hostname = "control"
    c.vm.network "private_network", ip: "192.168.56.10"
    c.vm.synced_folder "./ansible", "/home/vagrant/ansible"

    c.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus   = 1
    end

    c.vm.provision "shell", path: "provision-control.sh"
  end

  # CentOS nodes
  {
    "web01" => "192.168.56.11",
    "web02" => "192.168.56.12",
    "db01"  => "192.168.56.14"
  }.each do |name, ip|
    config.vm.define name do |node|
      node.vm.box = "centos/stream9"
      node.vm.hostname = name
      node.vm.network "private_network", ip: ip
      node.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus   = 1
      end
    end
  end

  # Ubuntu node: web03
  config.vm.define "web03" do |node|
    node.vm.box = "ubuntu/jammy64"
    node.vm.hostname = "web03"
    node.vm.network "private_network", ip: "192.168.56.13"
    node.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus   = 1
    end
  end

  config.ssh.insert_key = false
  config.ssh.forward_agent = true

end