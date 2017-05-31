# spring-boot-openshift-pipeline
Openshift pipeline template for spring boot applications
## Setup with script
### Checkout and run script
```bash
cd /folder/to/checkout/srouce/to
git clone https://github.com/tjololo/spring-boot-openshift-pipeline.git
cd spring-boot-openshift-pipeline/cicd-pipeline-with-gogs
./setup-demo.sh
```
Wait until the builds of the baseimages are done and install-gogs pod has finished successfully

### Create sample pipeline
```bash
oc process -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/springboot-pipeline-template.yaml | oc create -f - -n cicd
```
## Manual Setup
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
oc create -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/base-images-template.json -n cicd 
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

### Deploy gogs
```bash
oc process -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/cicd-gogs-without-service-template.yaml | oc create -f - -n cicd
```
### Create pipeline build
```bash
oc process -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/springboot-pipeline-template.yaml | oc create -f - -n cicd
```
## Usage
After the setup is complete you should have a gogs, jenkins and a sample pipeline in the project cicd.

### Openshift
username: developer
password: developer

### Gogs
username: gogs

password: password

One repository is created automaticly. The sample pipeline is fixed to the cicd-sample branch of this repository.

The jenkins file used by the pipeline is located under the folder jenkins in the cicd-sample branch.

Read/edit the jenkinsfile and start playing with the pipeline.

### Where should i start?
* Start the pipeline
* Why did the deploy to qa fail?
* Add a webhook
* Try bumping the "bugfix-version" (last digit in the pom.xml version)
* Try bumping the "minor-version" (middle digit in the pom.xml version)
* Try bumping the "major-version" (first digit in the pom.xml version)
