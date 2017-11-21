#!/bin/bash

if [[ $1 =~ ^(-h|--help)$ ]] || [ -z "$1" ] ; then
  cat <<EOF
usage:
  ./generate_nodes.sh nodenumber [etherbase]
example:
  ./generate_nodes.sh 100 0x023e291a99d21c944a871adcc44561a58f99bdbc
EOF
  exit 1
fi

if [ -z "$2" ]; then
  ETHERBASE="0x023e291a99d21c944a871adcc44561a58f99bdbc"
else
  ETHERBASE=$2
fi

for i in $(seq 0 $1); do
name=n$(hexdump -n 8 -e '2/4 "%08X" 1 "\n"' /dev/random | awk '{print tolower($0)}')
cat <<EOF
- $name:
    k8s:
      replicas: 1
    geth:
      Eth_Etherbase: "$ETHERBASE"
      Eth_MinerThreads: 1
      Node_UserIdent: $name
      Node_DataDir: /etc/testnet/$name
      Node_HTTPPort: 8545
      Node_WSPort: 8546
      NodeP2P_ListenAddr: 30301
      NodeP2P_DiscoveryAddr: 30303
EOF
done
