#!/bin/bash
oc cluster up
oc login -u developer -p developer
#Create projects
oc new-project cicd
oc new-project dev
oc new-project test
oc new-project qa
oc new-project production
#Grant edit for jenkins
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n cicd
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n dev
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n test
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n qa
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n production
#Import base images used
oc create -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/base-images-template.json -n cicd
#Create template for fatjar deployment projects used in dev/test/qa
oc create -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/springboot-deployment-template.yaml -n cicd
#Deploy gogs service
oc process -f https://raw.githubusercontent.com/tjololo/spring-boot-openshift-pipeline/master/cicd-pipeline-with-gogs/cicd-gogs-without-service-template.yaml | oc create -f - -n cicd