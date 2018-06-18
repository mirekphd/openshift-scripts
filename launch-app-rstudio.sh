
### LAUNCHING SCRIPT FOR OPENSHIFT  ###


# define repo and project
REPO=mirekphd
PROJ=ml-cpu-r35-rstud
TAG=devel_1322662

# define work folder
WORK_FOLDER=rstudio

IMG=${REPO}/${PROJ}


# delete deploymentconfig
oc delete dc $PROJ

# delete imagestream
oc delete is $PROJ

# delete service
oc delete svc $PROJ

# delete route
oc delete route $PROJ

# verify that there are no objects left
oc get all | grep $PROJ

# wait for the pod to shut down
POD_SHUTDOWN_TIME=15
echo "Waiting for the pod to shut down..."
sleep $POD_SHUTDOWN_TIME

# verify that the pod has shut down
oc get pods | grep $PROJ


# launch the app again (pulling it from registry if necessary)
oc new-app ${IMG}:${TAG}

# mount a volume from the host system
oc volume dc/${PROJ} --add --name=${WORK_FOLDER} --path=/home/${WORK_FOLDER} --mount-path=/home/${WORK_FOLDER} --overwrite

# expose service, creating route
oc expose svc/${PROJ}

# wait for the route to be created
ROUTE_CREATE_TIME=15
echo "Waiting for the route to be created..."
sleep $ROUTE_CREATE_TIME

# get the ephemeral IP of the route
echo "Service is listening at the following local address:"
oc describe route $PROJ | grep Endpoints

echo "... which resolves to this local host name:"
oc describe route | grep cuda8 | grep Host


