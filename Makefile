TOPDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SCOPE := ${USERNAME}-

build:
	mvn install

deploy_resources:	build
	cd ${TOPDIR}/infrastructure/resources && \
	terraform init && \
	terraform apply -auto-approve -var="scope=${SCOPE}"

destroy_resources:
	cd ${TOPDIR}/infrastructure/resources && \
	terraform init && \
	terraform destroy -auto-approve -var="scope=${SCOPE}"

deploy_service:	build
	cd ${TOPDIR}/infrastructure/service && \
	terraform init && \
	terraform apply -auto-approve -var="scope=${SCOPE}"

destroy_service:
	cd ${TOPDIR}/infrastructure/service && \
	terraform init && \
	terraform destroy -auto-approve -var="scope=${SCOPE}"

clean:
	mvn clean