

### LAUNCHING SCRIPT FOR OPENSHIFT  ###


# define repo and project
REPO=mirekphd
PROJ=ml-gpu-py36-cuda8
TAG=devel_de4869c

# define work folder
WORK_FOLDER=jovyan

IMG=${REPO}/${PROJ}


# delete deploymentconfig
oc delete dc $PROJ

# do not delete imagestream 
# (to preserve image in local cache)
# oc delete is $PROJ

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
oc new-app --name=${PROJ} ${IMG}:${TAG}

# mount a volume from the host system
oc volume dc/${PROJ} --add --name=${WORK_FOLDER} --path=/home/${WORK_FOLDER} --mount-path=/home/${WORK_FOLDER} --overwrite

# change an environment variable (for a deployment config)
# to switch from default Jupyter Notebook to Jupyter Lab
oc set env dc/${PROJ} JUPYTER_LAB=1

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


