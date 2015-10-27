# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = 'radiance-cookbook'

  config.vm.box = 'ubuntu/trusty64'
  # config.vm.box = "centos65-x86_64"
  # config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"

  config.vm.network :private_network, ip: '33.33.33.31'

  config.vm.network :forwarded_port, guest: 22, host: 2205, id: 'ssh'
  # config.vm.network :forwarded_port, guest: 80, host: 9001

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # config.vm.synced_folder "../radiance-src", "/usr/local/radiance-src"

  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ['modifyvm', :id, '--memory', 1024, '--cpus', 2]

    # Disable DNS proxy.
    # Causes slowness: https://github.com/rubygems/rubygems/issues/513
    # vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    # vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info

    # Build a release
    # chef.json = {
    #   radiance: {
    #     version: '5.0.a.6'
    #   }
    # }

    # Build a specific commit
    chef.json = {
      radiance: {
        source_url: 'https://github.com/NREL/Radiance/archive',
        version: 'fix-headless.zip'
      }
    }

    chef.add_recipe('radiance')
  end
end
