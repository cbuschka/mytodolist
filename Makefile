TOPDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

init:
	if [ "x$(shell pipenv --version 2>/dev/null)" == "x" ]; then \
		sudo dnf -y install pipenv; \
	fi; \
	if [ ! -d "${TOPDIR}/venv/" ]; then \
		pipenv install; \
	fi
