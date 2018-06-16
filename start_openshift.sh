# Start OpenShift Origin cluster:


sudo yum install -y socat


oc cluster down

oc cluster up

oc config view

oc cluster status



oc login -u "system:admin"

oc adm policy add-cluster-role-to-user cluster-admin openshift


oc login -u "openshift"

oc project openshift

oc new-app openshift/hello-openshift

oc expose svc/hello-openshift