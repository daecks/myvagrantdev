# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "daecksdev19_0_1"

    config.vm.box_url = ["file:///C:/users/daeck/Dropbox/vagrantboxes/LinuxMint19_0_1.box"]
    config.ssh.insert_key = false
    
    config.vm.provider "virtualbox" do |vb| 
        # Use the GUI.
        vb.gui = true
        # Windows host, get amount of memory and allocate a half
        amount_guest_memory = 4096
        #amount_guest_memory = `wmic os get TotalVisibleMemorySize`.split("\n")[2].to_i / (1024 * 2)
        # Allocate all CPUs to guest
        num_guest_cpus = ENV['NUMBER_OF_PROCESSORS'].to_i 
        #puts "Configuring virtual machine to use #{num_host_cpus} CPUs"
        vb.customize ["modifyvm", :id, "--memory", "#{amount_guest_memory}", "--cpus", "#{num_guest_cpus}"]
        #vb.customize ["modifyvm", :id, "--usb", "on"]
        #vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'MotoX', '--vendorid', '0x22b8']
        #vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'MSI', '--vendorid', '0x05c6']
        #vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'Sony', '--vendorid', '0x054c']
        #vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'Sony', '--vendorid', '0x0fce']
        #vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'Android bootloader', '--vendorid', '0x18d1']
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/devspace", "1"]
        vb.customize ["modifyvm", :id, "--usbxhci", "on"] # Forcefully disable USB 2.0 as requires VB extensions
        vb.customize ["modifyvm", :id, "--accelerate3d", "off"] # Disable 3d acceleration until Virtualbox team fixes it
        vb.customize ["modifyvm", :id, "--audio", "none"] # We don't need audio
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"] # Enable bidirectional clipboard
        vb.customize ["modifyvm", :id, "--draganddrop", "disabled"] # Enable drag/drop between host and guest
        vb.customize ["modifyvm", :id, "--hwvirtex", "on"] # Enable hardware virtualization
        vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"] # Mint is really Ubuntu
        vb.customize ["modifyvm", :id, "--pae", "on"] # enable physical address extensions
        vb.customize ["modifyvm", :id, "--nestedpaging", "on"] # Enable hardware memory management
        vb.customize ["modifyvm", :id, "--largepages", "on"] # Larger pages for reduced Translation Lookaside Buffer usage
        vb.customize ["modifyvm", :id, "--vtxvpid", "on"] # If TLBs are used, accelerate context switching
        vb.customize ["modifyvm", :id, "--vtxux", "on"] # Enable unrestricted guest mode 
    end

# This is for initial drive creation.  
# You cannot resize an existing drive using this entry!!!
    config.persistent_storage.enabled = true
    config.persistent_storage.location = "devdisk.vdi"
    config.persistent_storage.size = 80000 # Max of 80 GB for devspace drive
    config.persistent_storage.mountname = 'mydevspace'
    config.persistent_storage.filesystem = 'ext4'
    config.persistent_storage.mountpoint = '/devspace'
    config.vm.provision :shell, :inline => "sudo chown vagrant /devspace"

# If changes are made to proxy settings, you must reprovision the box
    config.apt_proxy.http  = false
    config.apt_proxy.https = false
    config.proxy.http     = false
    config.proxy.https    = false
    config.proxy.no_proxy = "localhost,127.0.0.1"

  config.vm.provision "shell", path: "setup/bootstrap.sh"

  #config.vm.provision "puppet" do |puppet|
  #puppet.manifests_path = "manifests"
  #puppet.manifest_file  = "icecream.pp"
  #end

    # Mark "true" or "false" if you want the tool installed or not.  These are
    # used by the chef recipes below which not only install apps, but also
    # configure them.

    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    # Setting this to false however to attempt to fix bug where perfoming
    # "vagrant up" while offline spawns a new VM instance.
    config.vm.box_check_update = true

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network "forwarded_port", guest: 80, host: 8080

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # config.vm.network "private_network", ip: "192.168.33.10"

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
#config.vm.network "public_network"

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    # config.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"

    #
    # View the documentation for the provider you're using for more
    # information on available options.

    # Enable provisioning with chef solo, specifying a cookbooks path, roles
    # path, and data_bags path (all relative to this Vagrantfile), and adding
    # some recipes and/or roles.
    #
end
