#!/bin/bash

kubectl port-forward $(kubectl get po | grep monitor | awk '{print $1}') 4567:3001
