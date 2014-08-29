# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.hostname = "ls-dev"
  config.vm.box = "kohadev"
  config.vm.box_url = "http://datatest.deichman.no/vagrant/kohawheezy64.box"

  #config.ssh.forward_agent = true
  #config.ssh.forward_x11 = true

  config.vm.synced_folder "salt", "/srv/salt"
  config.vm.synced_folder "pillar", "/srv/pillar"

  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.verbose = true
    salt.pillar_data
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "768"]
  end

end
