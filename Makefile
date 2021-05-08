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

namespaces:
	kubectl apply -f overlays/primary/namespaces.yaml

deploy: kustomize-primary

longhorn-uninstall:
	kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.0/uninstall/uninstall.yaml
	sleep 30
	kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.0/deploy/longhorn.yaml
	kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.0/uninstall/uninstall.yaml
