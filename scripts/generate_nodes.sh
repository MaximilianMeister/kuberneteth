#!/bin/bash

if [[ $1 =~ ^(-h|--help)$ ]] || [ -z "$1" ] || [ -z "$2" ] ; then
  cat <<EOF
usage:
  ./generate_nodes.sh n..range [etherbase]
example:
  ./generate_nodes.sh 0 100 0x023e291a99d21c944a871adcc44561a58f99bdbc
EOF
  exit 1
fi

if [ -z "$3" ]; then
  ETHERBASE="0x023e291a99d21c944a871adcc44561a58f99bdbc"
else
  ETHERBASE=$3
fi

for i in $(seq $1 $2); do
cat <<EOF
- miner$i:
    k8s:
      replicas: 1
    geth:
      Eth_Etherbase: "$ETHERBASE"
      Eth_MinerThreads: 1
      Node_UserIdent: miner$i
      Node_DataDir: /etc/testnet/miner$i
      Node_HTTPPort: 8545
      Node_WSPort: 8546
      NodeP2P_ListenAddr: 30303
EOF
done
