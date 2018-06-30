# install SystemTap and required kernel info packages on CentOS 7.x
# see [SystemTap_Beginners_Guide](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/SystemTap_Beginners_Guide/)

yum install -y systemtap systemtap-runtime
yum install kernel-debuginfo kernel-debuginfo-common
yum install yum-utils

sudo yum install -y kernel-devel-$(uname -r) \
kernel-debuginfo-$(uname -r)
kernel-debuginfo-common-$(uname -m)-$(uname -r)

debuginfo-install -y kernel-$(uname -r)

