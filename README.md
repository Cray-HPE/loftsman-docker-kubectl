# docker-kubectl

## Description

This repo contains code to build a container image that is widely used as an initContainer in CSM kubernetes pods. The container contains an up-to-date version of the `kubectl` command that can be used to query / wait for various prerequisite conditions in pods.  It is used in most Helm charts that are based on the `cray-service` or `cray-job` base Helm chart and some other Helm charts as well.

## Note on Versions

The container built here contains a specific version of `kubectl` which is used in constructing the image tag at build / publish time.  That version is found in the `.version` file in this directory.

The container also uses a base image of `docker:latest`.

To move to a newer `kubectl` version update `.version`.
