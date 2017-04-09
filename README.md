# kubernet-eth
deploy a private [ethereum](https://ethereum.org/) blockchain network with kubernetes

## infrastructure
the manifests in the [blockchain-manifests](blockchain-manifests/) folder are tested on [CASP 1.0](https://www.suse.com/communities/blog/suse-container-service-caas-platform-1-0-beta-program/) and [openSUSE Leap 42.2](https://opensuse.org/) but should work on any platform where kubernetes is up and running.

Make sure to have kubernetes up and running, either via the [official documentation](https://kubernetes.io/docs/setup/pick-right-solution/) or if you want to have a quick docker and libvirt setup, follow the guide to setup

* [velum](https://github.com/kubic-project/velum) - a dashboard to deploy and configure kubernetes clusters via docker containers
* [kubernetes worker nodes](https://github.com/kubic-project/terraform/tree/master/contrib/libvirt) - an easy way to spawn x worker nodes via teraform and openSUSE

## deployment and cluster setup
the deployment of the ethereum network nodes happens via the [blockchain-manifests](blockchain-manifests/)

there are some very simple helper [scripts](scripts/) to deploy a [geth](https://github.com/ethereum/go-ethereum) cluster consisting of:

* a [bootnode](https://github.com/ethereum/go-ethereum/wiki/Setting-up-private-network-or-local-cluster#setup-bootnode)
* a miner node (that also writes the genesis block initially)
* a member node (just for having one)
* a monitor to watch the status of the cluster (via [ethereum-netstats](https://github.com/cubedro/eth-netstats) and [eth-net-intelligence-api](https://github.com/cubedro/eth-net-intelligence-api)

## limitations
* persistent storage of blocks and any data that is usually in the `datadir` (like `.ethereum`) is done via [hostPath](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) -> make sure to keep it clean, as it is not managed
* the cluster setup is still fixed
* the cluster runs in a single pod
* depending on the workers (cpu) the mining time may vary
* the mining difficulty is hardcoded, to avoid using the `--dev` flag of `geth` that uses too many unwanted/uncontrolled default values. the [mmeister/geth-node:genesis-miner-dev](dockerfiles/Dockerfile.genesis-miner-dev) image on dockerhub contains a [patch](https://github.com/MaximilianMeister/kubernet-eth/blob/master/dockerfiles/Dockerfile.genesis-miner-dev#L8) to defuse the "difficulty bomb"
* all nodes are connected through the bootnode, which may be unwanted in some cases

## workflow
once the kubernetes cluster is up and healthy (verify via `kubectl cluster-info`), you can deploy the geth cluster via the following sequence:

```bash
./scripts/startup-geth.sh
```

there are some services that are using specific ports to interact with the pods, which you can port forward to access them from your local machine.
services are:

* (json)rpc/ipc for each node, to connect e.g. [mist](https://github.com/ethereum/mist) a useful application to send transactions deploy smart contracts, and interact with the network -> runs at [http://localhost:9876](http://localhost:9876)
* the `eth-netstats` dashboard -> visit [http://localhost:4567](http://localhost:4567)

```bash
# the monitoring dashboard
./scripts/forward-monitoring.sh
# connecting a wallet or any service that talks to the json rpc
./scripts/forward-wallet.sh
```

## using mist wallet
if you're using mist to interact with the network, make sure to connect it to the network via:

```bash
./ethereumwallet --rpc http://localhost:8765 --node geth --network test
```

## tear down the cluster
to clean up and start from scratch:

```bash
./scripts/teardown-geth.sh
```

make sure to clean up the `hostPath` manually, I usually wipe all folders, but the `keystore` from the miner node to keep the `coinbase` in place

## deploying contracts
once your ethereum cluster is running, you can start to publish contracts. i have started with a simple [example](contracts/provider.sol) derived from a good introduction that you can find [here](https://www.youtube.com/watch?v=9_coM_g7Dbg)

## running a distributed application
the next step is to write an application that leverages the capabilities of your smart contract. there are several ways to do this, as there are already many integrations and libraries around that are able to communicate with a contract.

a good point to start is:

* [web3.js](https://github.com/ethereum/web3.js) - getting started [here](https://github.com/ethereum/wiki/wiki/JavaScript-API)
* [Embark.js](https://github.com/iurimatias/embark-framework) - a framework for dApp development
* and probably many others that I don't know yet...
