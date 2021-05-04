@Library('dst-shared@master') _

dockerBuildPipeline {
        repository = "loftsman"
        app = "docker-kubectl"
        name = "loftsman-docker-kubectl"
        description = "Loftsman Kubectl CLI"
        useEntryPointForTest = "false"
        dockerArguments = "--build-arg docker_image_version=20.10.6 --build-arg kubectl_version=v1.18.6"
        product = "csm"
}
