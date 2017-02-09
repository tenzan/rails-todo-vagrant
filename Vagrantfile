# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu-16.04-x64"

  ENV['LC_ALL']="en_US.UTF-8"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false
  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "~/apt-archives", "/var/cache/apt/archives/", create: true
  config.vm.synced_folder "~/work/rails5/rails-todo-vagrant/temp/rails-todo-api", "/home/ubuntu/rails-todo-api", create: true
  config.vm.synced_folder "~/work/rails5/rails-todo-vagrant/temp/ember-todo-ui", "/home/ubuntu/ember-todo-ui", create: true

    config.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--cpus", 2]
    end

    config.vm.define :api do |api|
      api.vm.hostname = "api"
      api.vm.network "private_network", ip: "10.20.30.100"
      api.vm.provision "shell", path: "deployment/provision-api.sh", privileged: false
    end

    config.vm.define :ui do |ui|
      ui.vm.hostname = "ui"
      ui.vm.network "private_network", ip: "10.20.30.101"
      ui.vm.provision "shell", path: "deployment/provision-ui.sh", privileged: false
    end

  end
