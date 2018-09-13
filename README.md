# mining-pool

Dockers bundle for running mining pool.

Contains several blockchains daemons' dockers and [miningcore](https://github.com/coinfoundry/miningcore) docker.

## Pre requirements

This steps intended for debian-based distros.

* docker: use [this](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04) guide to install it.
* docker-compose: use [this](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04) guide to install it.
* (optional) docker-machine: use [this](https://docs.docker.com/machine/install-machine/#install-machine-directly) guide to install it.
* gnu make: `sudo apt install make`.

## Local installation

Edit `.env` file to adjust your setup.

From the root of repo run:
```bash
make
```

**!!! WARNING !!!** At first deploy this will require time to download and install or necessary things.
Moreover you will need 50+ GB disk space and 8GB+ RAM to sync all blockchains simultaneously.
Syncing will take hours (one night for example). If you have not enough RAM or disk space
you can stop some dockers.

### Available ports

* 0.0.0.0:3000: bitcoin mining stratum
* 0.0.0.0:3001: bitcoin-cash mining stratum
* 0.0.0.0:3002: dash mining stratum
* 0.0.0.0:3003: ethereum mining stratum
* 0.0.0.0:3004: litecoin mining stratum
* 127.0.0.1:4000: miningcore API

### Usefull commands

* `docker ps`: show all running docker containers' info.
* `docker logs <container-name>`: view container's logs (e.g. `docker logs bitcoin`).
* `docker stop $(docker ps -q)`: stop all dockers.
* `docker rm $(docker ps -q)`: remove all dockers (volume files will leave unremoved).
* `docker exec -it <container-name> bash`: get bash of the container.
* `make`: deploy your changes to local docker server.
* `make miningcore-restart`: restart mining core after deploy to apply config changes (not required at first deploy).

### `minerd` litecoin mining in testnet example

```bash
./minerd -a sha256d --url stratum+tcp://127.0.0.1:3004 --user Qj1nAfgpVWF91PvGhrm4Tcj6Qs6D9wQfnb.miner
```
