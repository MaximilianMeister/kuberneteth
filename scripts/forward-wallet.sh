#!/bin/bash

kubectl port-forward $(kubectl get po | grep geth-miner | awk '{print $1}') 9876:8501
