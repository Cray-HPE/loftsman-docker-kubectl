#!/bin/sh

set -e

images_registry="$1"
target_namespace="$2"

images_registry_username=""
images_registry_password=""
if [ -f /loftsman/secrets/images.registry.username ]; then
  images_registry_username=$(cat /loftsman/secrets/images.registry.username)
fi
if [ -f /loftsman/secrets/images.registry.password ]; then
  images_registry_password=$(cat /loftsman/secrets/images.registry.password)
fi
# Used for imagePullSecrets config, if our images_registry is private and we've been provided with a username/password for it
if [[ ! -z "$images_registry_username" ]] && [[ ! -z "$images_registry_password" ]] && [[ ! -z "$images_registry" ]]; then
  for namespace in $(kubectl get namespaces -o jsonpath={.items[*].metadata.name}); do
    if [[ ! -z "$target_namespace" ]] && [[ "$namespace" != "$target_namespace" ]]; then
      continue
    fi
    echo "Creating/updating registry secret in namespace $namespace and configuring the default service account to use it"
    kubectl create secret docker-registry -n $namespace --dry-run=true registry-secret \
      --docker-server="${images_registry}" \
      --docker-username="${images_registry_username}" \
      --docker-password="${images_registry_password}" \
      --docker-email="shaper@loftsman.io" -o yaml > /tmp/registry-secret.yaml
    kubectl apply -f /tmp/registry-secret.yaml
    rm /tmp/registry-secret.yaml
    service_account=$(kubectl get serviceaccount -n $namespace -o name --field-selector=metadata.name=default)
    if [ ! -z "$service_account" ]; then
      kubectl patch $service_account -n $namespace -p '{"imagePullSecrets": [{"name": "registry-secret"}]}'
    fi
  done
fi
