.PHONY: help build

IMAGE:=sanori/cuquantum-py
TAG:=latest
CUQUANTUM_VERSION?=$(shell ./pipver cuquantum-python)
VERSION:=$(CUQUANTUM_VERSION)

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Make clean the build environment
	docker image prune

build: DARGS?=--pull --build-arg cuquantum_version=$(CUQUANTUM_VERSION)
build: ## Make the latest build of the image
	docker build $(DARGS) --rm --force-rm -t $(IMAGE):$(TAG) -t $(IMAGE):$(VERSION) .

push: ## Push the latest image
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest
