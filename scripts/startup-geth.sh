#!/bin/bash

kubectl create -f ../blockchain-manifests/geth-service.yaml
sleep 5
kubectl create -f ../blockchain-manifests/geth-genesis.yaml
sleep 6
kubectl create -f ../blockchain-manifests/geth-cluster.yaml
until kubectl get deployment | grep geth-node-deployment | grep -v 0 ; do echo "waiting for cluster to get ready..."; sleep 2; done
