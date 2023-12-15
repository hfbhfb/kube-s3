

IMG=v0.1

all:
	@echo "111"

install:
	# bash ./build.sh 1.0 
	kubectl apply -f yaml/daemonset.yaml
	kubectl apply -f yaml/configmap_secrets.yaml

uninstall:
	kubectl delete -f yaml/daemonset.yamlk 
	kubectl delete -f yaml/configmap_secrets.yaml

build:
	docker build -f changeConfigName.Dockerfile -t hefabao/my-kube-s3:${IMG} .

push:
	docker push hefabao/my-kube-s3:${IMG}

test1:
	kubectl apply -f yaml/example_pod.yaml
clean1:
	kubectl delete -f yaml/example_pod.yaml
