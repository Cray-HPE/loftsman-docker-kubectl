@Library('dst-shared@bugfix/DST-1871-dockerbuildpipeline-fails-if-passing-dockerarguments-option') _

dockerBuildPipeline {
        repository = "anajjar"
        masterBranch = "feature/build-pipeline"
        imagePrefix = "loftsman"
        app = "docker-kubectl"
        name = "loftsman-docker-kubectl"
        description = "Loftsman Kubectl CLI"
        useEntryPointForTest = "false"
        dockerArguments = "--build-arg docker_image_version=18.09.4 --build-arg kubectl_version=v1.14.0"
}