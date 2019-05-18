#!/bin/sh

POD=$1
PODS=$(kubectl get pods -n loftsman | grep '^'$POD'')

if [ ! -z "$PODS" ]; then
    echo "true"
else
    echo "false"
fi
