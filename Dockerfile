##########################
# install
##########################
FROM alpine:latest as install

ARG kubectl_version
RUN wget -q https://dl.k8s.io/release/${kubectl_version}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

##########################
# kubectl-docker
##########################
FROM alpine:latest as kubectl-docker
RUN apk add --upgrade --no-cache apk-tools &&  apk update && apk add --no-cache jq yq && apk -U upgrade --no-cache
COPY --from=install /usr/local/bin/kubectl /usr/local/bin/
COPY ./bin/update-image-registry-secrets.sh /usr/local/bin/update-image-registry-secrets
RUN chmod +x /usr/local/bin/update-image-registry-secrets
COPY ./bin/wait-for-pod.sh /usr/local/bin/wait-for-pod
RUN chmod +x /usr/local/bin/wait-for-pod
COPY ./bin/pod-deployed.sh /usr/local/bin/pod-deployed
RUN chmod +x /usr/local/bin/pod-deployed
