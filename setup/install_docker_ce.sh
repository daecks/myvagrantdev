# Installs docker community edition
# Reference: https://docs.docker.com/install/linux/docker-ce/ubuntu/
echo "Installing docker community edition"

which docker
exit_status=$?
if [ $exit_status -ne 0 ]; then
    cd /tmp
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    echo "Finished installing docker community edition"
else
    echo "Docker community edition already installed"
fi
