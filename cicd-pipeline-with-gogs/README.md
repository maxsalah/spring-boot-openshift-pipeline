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

### Import template for service
```bash
oc create -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/springboot-deployment-template.yaml -n cicd
```

### Deploy gogs and create the pipeline
```bash
oc process -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/cicd-gogs-without-service-template.yaml | oc create -f - -n cicd
```