PHONY: docker-build docker-push kustomize-build kustomize-plugins kustomize-primary

KUSTOMIZE_PLUGIN_DIR := ${HOME}/.config/kustomize/plugin
PLATFORM := $(shell uname | tr '[:upper:]' '[:lower:]')
HELMGENERATOR_URL := $(shell curl -SLs https://api.github.com/repos/joshrwolf/kustomize-helmgenerator/releases/latest | jq -r ".assets[] | select(.name | contains(\"$(PLATFORM)\")).browser_download_url")
REGISTRY := ghcr.io

docker-build:
	docker build -t $(REGISTRY)/reynn/porkbun-dns-updater containers/porkbun-dns-updater/

docker-push: docker-build
	docker push $(REGISTRY)/reynn/porkbun-dns-updater

kustomize-build:
	@mkdir -p "${PWD}/.build"
	kustomize build --enable-alpha-plugins overlays/primary/ > .build/primary.yaml

kustomize-plugins:
	@echo "Creating directory ${KUSTOMIZE_PLUGIN_DIR}"
	@mkdir -p $(KUSTOMIZE_PLUGIN_DIR)/wolfs.io/v1beta1/helmchart
	curl -SLs $(HELMGENERATOR_URL) > $(KUSTOMIZE_PLUGIN_DIR)/wolfs.io/v1beta1/helmchart/HelmChart
	@chmod +x "$(KUSTOMIZE_PLUGIN_DIR)/wolfs.io/v1beta1/helmchart/HelmChart"

kustomize-primary: kustomize-build
	kubectl apply -f .build/primary.yaml
