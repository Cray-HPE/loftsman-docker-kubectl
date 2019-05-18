#!/bin/sh

POD=$1

# wait for the tiller to be ready
while ! kubectl get pods -n loftsman | grep '^'$POD'' | grep '\sRunning\s' | grep '\s1/1\s' &> /dev/null; do
  sleep 3
done
