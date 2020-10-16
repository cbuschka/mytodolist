TOPDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SCOPE := ${USERNAME}-

build:
	mvn install

deploy_service:	build
	cd ${TOPDIR}/infrastructure && \
	terraform init && \
	terraform apply -auto-approve -var="scope=${SCOPE}"

destroy_service:
	cd ${TOPDIR}/infrastructure && \
	terraform init && \
	terraform destroy -auto-approve -var="scope=${SCOPE}"

clean:
	mvn clean