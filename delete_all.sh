# delete all objects labeled using --name=LABEL when launched using oc new-app
LABEL=ml-cpu-r35-nx
oc delete all -l app=${LABEL}
