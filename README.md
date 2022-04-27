#  energy task explanations

## Contents Overview

- [.dockerignore](.dockerignore) 
  - ignore everything (although we don't have any COPY or ADD command).
- [deployment](deployment) 
  - contains kubernetes configfile (just a [statefulset.yaml](deployment/k8s/statefulset.yaml) file).
- [Dockerfile](Dockerfile) 
  - the file that our new image builds from it's steps.
- [.gitlab-ci.yml](.gitlab-ci.yml) 
  - this is our CI/CD file.

## Add required secrets on gitlab

- `CI_REGISTRY_USER` (gitlab docker registry username)
- `CI_REGISTRY` (gitlab docker registry password/token)


### CI/CD process:

When a change happend on just the `main` branch CI/CD will launch:

 - In CI(Build) section, the docker image will build from Dockerfile and push to gitlab docker registry
 - In CD(Deploy) section, the new docker image will be update and after that statefulset will apply into the kubernetes cluster
 - In CD(Deploy) section, in the last line of script , the CD watches the new changes and if everything wokrs well the CD process will finish successfully 


### Dockerfile description:

- The base image is `ubuntu:20.04`
- In the `RUN` section 
   - the `energi user` will create 
   - the `energi3 (v3.1.2)` binary file will get , check and extract and move to $PATH. 
   - the `trivy` scanner will get and check the entire filesystem
- change the default user from `root` to `energi` 
- define a default command (this will run whenever  the container of created docker image starts)
