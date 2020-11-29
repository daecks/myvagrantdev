# Install Virtualbox 
$exefile = "VirtualBox-6.1.16-140961-Win.exe"
$outfile = $PSScriptRoot+"/"+$exefile
$url = "https://download.virtualbox.org/virtualbox/6.1.16/"+$exefile
Invoke-WebRequest -Uri $url -OutFile $outfile
Start-Process -Filepath "$outfile"

# Install Vagrant
$exefile = "vagrant_2.2.14_x86_64.msi"
$outfile = $PSScriptRoot+"/"+$exefile
$url = "https://releases.hashicorp.com/vagrant/2.2.14/"+$exefile
Invoke-WebRequest -Uri $url -OutFile $outfile
Start-Process -Filepath "$outfile"

