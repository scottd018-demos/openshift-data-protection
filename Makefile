#
# infra
# 
infra-init:
	cd terraform && terraform init

infra-plan:
	cd terraform && terraform plan -var-file main.tfvars -out main.plan

infra-apply:
	cd terraform && terraform apply -auto-approve main.plan

#
# openshift
#
openshift-namespace:
	oc create ns openshift-adp

openshift-secret:
	openshift/create-secret.sh

openshift-operator:
	oc apply -f openshift/operator.yaml

openshift-storage:
	oc apply -f openshift/storage.yaml

openshift-backup-app:
	oc create namespace hello-world && oc new-app -n hello-world --docker-image=docker.io/openshift/hello-openshift

openshift-backup:
	oc apply -f openshift/backup.yaml

openshift-delete:
	oc delete ns hello-world

openshift-restore:
	oc apply -f openshift/restore.yaml

openshift-cleanup:
	oc delete ns hello-world || \
		oc -n openshift-adp delete dpa dscott-dpa || \
		oc -n openshift-adp delete cloudstorage dscott-oadp || \
		oc -n openshift-adp delete subscription redhat-oadp-operator || \
		oc delete ns openshift-adp || \
		oc delete backup hello-world || \
		oc delete restore hello-world || \
		for CRD in `oc get crds | grep velero | awk '{print $$1}'`; do oc delete crd $$CRD; done
