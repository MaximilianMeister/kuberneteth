#!/bin/bash

set -e

if [ -z "$BOOTNODE_POD_IP" ]; then
  cat <<EOF
export BOOTNODE_POD_IP into the environment
EOF
  exit 1
fi

cd /etc/testnet/bootnode

/bootnode -genkey boot.key -writeaddress
echo "enode://$(/bootnode -nodekey boot.key -writeaddress)@$BOOTNODE_POD_IP:30303" > enode.address
/bootnode -nodekey boot.key
