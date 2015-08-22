# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "pkdev"
    config.vm.box_url = ["file:///D:/vms/linuxmint64.box"]

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
    config.vm.provider "virtualbox" do |vb| 
        # Use the GUI.
        vb.gui = true
        # Customize this to how many CPU cores you have/want to use.
        vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"]
    end  

    config.apt_proxy.http  = false
    config.apt_proxy.https = false
    config.proxy.http     = false
    config.proxy.https    = false
    config.proxy.no_proxy = "localhost,127.0.0.1"
    
    config.vm.provision :shell, :inline => "sudo apt-add-repository -y ppa:paolorotolo/android-studio"
    config.vm.provision :shell, :inline => "sudo apt-get update"
    config.vm.provision :shell, :inline => "sudo apt-get -y --force-yes install android-studio"

    # Install commonly used tools and apps in ASTRO dev
    config.vm.provision :shell, :inline => "sudo apt-get -y --force-yes install cscope"
    config.vm.provision :shell, :inline => "sudo apt-get -y --force-yes install ctags"
    config.vm.provision :shell, :inline => "sudo apt-get -y --force-yes install kdiff3"
    config.vm.provision :shell, :inline => "sudo apt-get -y --force-yes install arduino"
    config.vm.provision :shell, :inline => "sudo apt-get -y remove mate-screensaver"

    # Mark "true" or "false" if you want the tool installed or not.  These are
    # used by the chef recipes below which not only install apps, but also
    # configure them.
    install_vim = true

    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    # Setting this to false however to attempt to fix bug where perfoming
    # "vagrant up" while offline spawns a new VM instance.
    #config.vm.box_check_update = false

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
    # config.vm.network "public_network"

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
    config.vm.provision "chef_solo" do |chef|
        if install_vim
            chef.add_recipe 'vim-setup'
            installation_dependencies = <<-HERE
        apt-get update
        apt-get install -y build-essential cmake
        apt-get install -y ncurses-dev python2.7-dev
            HERE

            clone_colo_manually = <<-HERE
        set -e
        # Copy across .vimrc from Astrodev repo.
        cp /vagrant/cookbooks/vim-setup/.vimrc ~/.vimrc
        # YCM is useful, but very, very special.
        if [ ! -d "$HOME/.vim/bundle/YouCompleteMe" ]; then
            git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
        fi
        cd ~/.vim/bundle/YouCompleteMe
        git submodule update --init --recursive
        ./install.sh --clang-completer
            HERE

            install_global_vim_plugin_dependencies = <<-HERE
        set -e
        apt-get update
        # for YCM
        apt-get install -y build-essential cmake python2.7-dev
            HERE

            install_user_vim_plugin_dependencies = <<-HERE
        set -e
            HERE

            chef.json = {
                vim_setup: {
                    base_packages: ['vim-gtk'],
                    custom_preinstall_bash: installation_dependencies,
                    custom_bash_user_before_vundle: clone_colo_manually,
                    custom_bash_once_after_vundle: install_global_vim_plugin_dependencies,
                    custom_bash_user_after_vundle: install_user_vim_plugin_dependencies,
                    global_vimrc: false,
                    users: [ 'vagrant', 'vagrant' ],
                    use_vundle: true,
                    vundle_timeout: 1000,
                }
            }
        end
    end
end
