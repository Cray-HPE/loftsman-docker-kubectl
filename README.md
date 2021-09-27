# docker-kubectl

This repo contains code to build a container image that is widely used as an initContainer in CSM kubernetes pods. The container contains an up-to-date version of the `kubectl` command that can be used to query / wait for various prerequisite conditions in pods.  It is used in most Helm charts that are based on the `cray-service` or `cray-job` base Helm chart and some other Helm charts as well.
