# spring-boot-openshift-pipeline
Openshift pipeline template for spring boot applications

## Setup
### Start cluster
```bash
oc cluster up
```
### Import base images
See [this](https://github.com/tjololo/custom-builder) page for how to create the base images.

### Grant edit to Jenkins user
```bash
oc policy add-role-to-user edit system:serviceaccount:myproject:jenkins -n myproject
```

### Deploy jenkins
```bash
oc policy add-role-to-user edit system:serviceaccount:myproject:jenkins -n myproject
```
### Create sample pipeline
Creates sample pipeline running [this](https://github.com/tjololo/springboot-sample-app) application
```bash
oc process -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/openshift-springboot-pipeline-template.yaml | oc create -f -
```
To get a overview over what parameters are available open the template *maven-pipeline* template in the OpenShift web console