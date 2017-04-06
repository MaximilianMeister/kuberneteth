#!/bin/bash

log() { echo ">>> $1"; }

for i in boot genesis member miner; do
  log "BUILDING $i: docker build -f Dockerfile.${i}node -t mmeister/geth-node:$i ."
  docker build -f Dockerfile.${i}node -t mmeister/geth-node:$i .
  log "PUBLISHING $i: docker push mmeister/geth-node:$i"
  docker push mmeister/geth-node:$i
done
