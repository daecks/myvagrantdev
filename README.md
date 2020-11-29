### Features

+ Based on a Linux Mint 19.2 Vagrant box
+ Scripted installation of the following tools:
  + Ripgrep
  + fzf
  + IntelliJ 
  + Android Studio
  + PyCharm
  + Visual Studio Code
  + cd - -
  + Powerline shell  
  + Vim with support for Go, Python, C-languages
  + pidcat
  + pyenv
+ Support for the following languages:
  + Rust
  + Go
  + Haskell
  + Erlang
  + Ruby
  + Scala
  + Clojure
  + Java (OpenJDK)
  
### Installation
    `git clone https://github.com/daecks/myvagrantdev`  
    `cd myvagrantdev`  
    `install_dependencies.bat`
    `reboot machine`
    `vagrant up`  

Installed and tested with Virtualbox 6.1.16 and Vagrant 2.2.14
on a Windows 10 machine running an AMD Ryzen processor.
