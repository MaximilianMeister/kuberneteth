#!/bin/bash

kubectl delete -f ../blockchain-manifests/geth-service.yaml
kubectl delete -f ../blockchain-manifests/geth-cluster.yaml
