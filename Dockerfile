ARG docker_image_version

##########################
# install
##########################
FROM docker:${docker_image_version} as install

ARG kubectl_version
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/${kubectl_version}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

##########################
# kubectl-docker
##########################
FROM docker:${docker_image_version} as kubectl-docker

COPY --from=install /usr/local/bin/kubectl /usr/local/bin/
COPY ./bin/update-image-registry-secrets.sh /usr/local/bin/update-image-registry-secrets
RUN chmod +x /usr/local/bin/update-image-registry-secrets
