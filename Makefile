SHELL := /bin/bash

.PHONY: build
build:
	kubectl apply -f cadvisor.daemonset.yaml
	kubectl apply -f postgres.secret.yaml -f postgres.configmap.yaml -f postgres.volume.yaml -f postgres.deployment.yaml -f postgres.service.yaml
	kubectl apply -f redis.configmap.yaml -f redis.deployment.yaml -f redis.service.yaml