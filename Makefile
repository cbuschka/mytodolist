TOPDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))


install:	init
	@if [ ! -d "${TOPDIR}/venv/" ]; then \
		echo "Installing packages..."; \
		pipenv install; \
	fi

init:
	@if [ "x$(shell pipenv --version 2>/dev/null)" == "x" ]; then \
		echo "Installing pipenv..."; \
		sudo dnf -y install pipenv; \
	fi

