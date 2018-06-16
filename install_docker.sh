# Uninstall old Docker versions
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
                                    
# install required packages                  
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2 wget git

# set up repository (stable)
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo                  

# install Docker CE
sudo yum install -y docker-ce

# start Docker
sudo systemctl start docker

# test Docker by running hello-world example
sudo docker run hello-world
