# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'fileutils' 

pillar_example_files = 'pillar/**/admin.sls.example'

Dir.glob(pillar_example_files).each do | example_file |
  pillar_file =  example_file.sub(/\.example$/, '')
  if !File.file?(pillar_file)
    puts "Note! Copying #{pillar_file} from #{example_file} ..."
    FileUtils.cp(example_file, pillar_file)
  end
end

Vagrant.configure(2) do |config|

  config.vm.hostname = "kohadev"
  config.vm.box = "kohadev"
  config.vm.box_url = "http://datatest.deichman.no/vagrant/kohawheezy64.box"

  #config.ssh.forward_agent = true
  #config.ssh.forward_x11 = true

  config.vm.synced_folder "salt", "/srv/salt"
  config.vm.synced_folder "pillar", "/srv/pillar"

  unless ENV['NO_PUBLIC_PORTS']
    config.vm.network :forwarded_port, guest: 6001, host: 6001  # SIP2
    config.vm.network :forwarded_port, guest: 8080, host: 8080  # OPAC
    config.vm.network :forwarded_port, guest: 8081, host: 8081  # INTRA
  end

  # install salt stack on Debian
#  config.vm.provision :shell,
#    :inline => 'wget -O - http://bootstrap.saltstack.org | sudo sh'

  config.vm.provision :salt do |salt|
    salt.install_master = true
    salt.minion_config = "salt/minion"
    salt.master_config = "salt/master"
    salt.run_highstate = false
    salt.verbose = true
#    salt.master_key = "salt/keys/master.pem"
#    salt.master_pub = "salt/keys/master.pub"
#    salt.minion_key = "salt/keys/master.pem"
#    salt.minion_pub = "salt/keys/master.pub"
#    salt.seed_master = {master: "salt/keys/master.pub"}
    salt.run_overstate = true
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "768"]
  end

end
