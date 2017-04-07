#!/bin/bash

set -e

ENODE=/etc/testnet/bootnode/enode.address

if [ -z "$GETH_ID" ] || [ -z "$GETH_RPCPORT" ] || [ -z "$GETH_PORT" ] || [ -z "$GETH_ETHERBASE" ]; then
  cat <<EOF
export GETH_ID, GETH_RPCPORT, GETH_PORT and GETH_ETHERBASE into the environment
EOF
  exit 1
fi

if ! [ -e $ENODE ]; then
  echo "couldn't find enode address, make sure to bootstrap a node and place it's address into $ENODE"
  exit 1
fi

GETH_ENODE=$(cat $ENODE)

/geth --dev \
      --identity $GETH_ID \
      --bootnodes $GETH_ENODE \
      --mine \
      --minerthreads 1 \
      --etherbase $GETH_ETHERBASE \
      --networkid 1101 \
      --datadir /etc/testnet/$GETH_ID \
      --ipcpath /etc/testnet/$GETH_ID/geth.ipc \
      --port $GETH_PORT \
      --rpc \
      --rpcport $GETH_RPCPORT \
      --rpcapi "db,eth,net,web3,personal,web3" \
      --rpccorsdomain "*"  \
      --nat any

