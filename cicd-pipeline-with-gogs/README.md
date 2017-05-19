# spring-boot-openshift-pipeline
Openshift pipeline template for spring boot applications

## Setup
### Start cluster
```bash
oc cluster up
```

### Create projects
```bash
oc new-project cicd
oc new-project dev
oc new-project test
oc new-project qa
oc new-project production
```
### Import base images
```bash
oc create -f https://raw.githubusercontent.com/tjololo/custom-builder/master/custom-builder-base-images-template.json -n cicd 
```

### Grant edit to Jenkins user
```bash
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n cicd
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n dev
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n test
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n qa
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n production
```
### Deploy gogs
```bash
oc process -f cicd-pipeline-gogs/cicd-gogs-template | oc create -f - -n cicd
```
### Deploy jenkins
```bash
oc policy add-role-to-user edit system:serviceaccount:myproject:jenkins -n cicd
```
### Create sample pipeline
Creates sample pipeline running [this](https://github.com/tjololo/springboot-sample-app) application
```bash
oc process -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/openshift-springboot-pipeline-template.yaml -n cicd | oc create -f - -n cicd
```
To get a overview over what parameters are available open the template *maven-pipeline* template in the OpenShift web console