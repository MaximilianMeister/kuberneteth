#!/bin/bash

log() { echo ">>> $1"; }

for i in boot member genesis-miner; do
  log "BUILDING $i: docker build -f Dockerfile.${i} -t mmeister/geth-node:$i ."
  docker build -f Dockerfile.${i} -t mmeister/geth-node:$i .
  log "PUBLISHING $i: docker push mmeister/geth-node:$i"
  docker push mmeister/geth-node:$i
done

for i in member genesis-miner; do
  log "BUILDING $i: docker build -f Dockerfile.${i}-dev -t mmeister/geth-node:$i-dev ."
  docker build -f Dockerfile.${i}-dev -t mmeister/geth-node:$i-dev .
  log "PUBLISHING $i: docker push mmeister/geth-node:$i-dev"
  docker push mmeister/geth-node:$i-dev
done
