OVERLAY = overlays/primary
REGISTRY = ghcr.io

default: kustomize-build

docker-build:
	docker build -t $(REGISTRY)/reynn/porkbun-dns-updater containers/porkbun-dns-updater/

docker-push: docker-build
	docker push $(REGISTRY)/reynn/porkbun-dns-updater

kustomize-build:
	@mkdir -p "${PWD}/.build"
	kustomize build --enable-helm $(OVERLAY) > .build/$(shell echo $(OVERLAY) | cut -d/ -f2).yaml

kustomize-apply: kustomize-build
	kubectl apply -f .build/$(shell echo $(OVERLAY) | cut -d/ -f2).yaml
