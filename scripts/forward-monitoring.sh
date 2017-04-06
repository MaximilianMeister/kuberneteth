#!/bin/bash

kubectl port-forward $(kubectl get po | grep geth-node | awk '{print $1}') 4567:3001
