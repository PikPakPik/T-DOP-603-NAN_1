SHELL := /bin/bash

.PHONY: build
build:
	echo "Monitoring Tool - Cadvisor"	
	kubectl apply -f cadvisor.daemonset.yaml
	echo "Database - Postgres"
	kubectl apply -f postgres.secret.yaml -f postgres.configmap.yaml -f postgres.volume.yaml -f postgres.deployment.yaml -f postgres.service.yaml
	echo "Database - Redis"
	kubectl apply -f redis.configmap.yaml -f redis.deployment.yaml -f redis.service.yaml
	echo "Load Balancer - Traefik"
	kubectl apply -f traefik.rbac.yaml -f traefik.deployment.yaml -f traefik.service.yaml
	INTERNAL_IP=$(kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type =="InternalIP")].address }')
	echo "${INTERNAL_IP} poll.dop.io result.dop.io" | sudo tee -a /etc/hosts >/dev/null