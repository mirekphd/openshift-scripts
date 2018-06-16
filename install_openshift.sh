sudo yum install -y wget git curl nano


# install openshift origin client tools (oc)
wget -O openshift-origin-client-tools-v3.9.0.tar.gz https://github.com/openshift/origin/releases/download/v3.9.0/openshift-origin-client-tools-v3.9.0-191fece-linux-64bit.tar.gz
tar xzf openshift-origin-client-tools-v3.9.0.tar.gz
cd openshift*
sudo cp oc /usr/bin

# Open the OpenShift port at the firewall on the master node
# (this is not necessary if using safer SSH tunnelling of traffic to the containers)
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 8443 -j ACCEPT -m comment --comment "OpenShift port"
firewall-cmd --zone=public --add-port=8443/tcp
firewall-cmd --reload

oc version

# deploy a hello-world app
oc new-app hello-openshift
