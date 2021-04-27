PHONY: docker-build docker-push

REGISTRY="ghcr.io"

docker-build:
	docker build -t $(REGISTRY)/reynn/porkbun-dns-updater container-images/porkbun-dns-updater/

docker-push: docker-build
	docker push $(REGISTRY)/reynn/porkbun-dns-updater

kustomize-primary:
	kustomize build --enable-alpha-plugins overlays/primary/ | kubectl apply -f -

kustomize-build:
	kustomize build --enable-alpha-plugins overlays/primary/ > .build/primary.yaml
