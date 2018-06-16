# Restart docker deamon for OpenShift usage
# sudo mkdir /etc/systemd/system/docker.service.d/
# echo 'ExecStart=/usr/bin/dockerd --insecure-registry 172.30.0.0/16' > /etc/systemd/system/docker.service.d/docker.conf

sudo systemctl stop docker

sudo dockerd --insecure-registry 172.30.0.0/16

