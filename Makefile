TOPDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SCOPE := ${USERNAME}-
BUILD_TIMESTAMP := $(shell date +%Y%m%d_%H%M%S)
VERSION := $(shell git describe --no-match --always --dirty | sed -s "s\#dirty\#dirty-$$(date +%Y%m%dT%H%M%S)\#g")

build:
	mvn clean install

deploy_resources:	build
	cd ${TOPDIR}/infrastructure/resources && \
	terraform init && \
	terraform apply -auto-approve -var="scope=${SCOPE}" -var="build_version=${VERSION}"

destroy_resources:
	cd ${TOPDIR}/infrastructure/resources && \
	terraform init && \
	terraform destroy -auto-approve -var="scope=${SCOPE}" -var="build_version=${VERSION}"

deploy_service:	build
	cd ${TOPDIR}/infrastructure/service && \
	terraform init && \
	terraform apply -auto-approve -var="scope=${SCOPE}" -var="build_version=${VERSION}"

destroy_service:
	cd ${TOPDIR}/infrastructure/service && \
	terraform init && \
	terraform destroy -auto-approve -var="scope=${SCOPE}" -var="build_version=${VERSION}"

clean:
	mvn clean