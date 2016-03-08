# vagrant-static-container

This is a vagrant project for docker container which is added static IP by using pipework.

This project deploys Virtualbox VM and Docker container in Virtualbox VM with static private IP.

This project needs 4 private IP addresses for following device.

* Virtualbox VM
* bridge for Virtualbox VM
* Docker container
* bridge for Docker container

## Quick Start
1.) Install dependencies

* Virtualbox
* Vagrant

2.) Install plugins

```
vagrant plugin install vagrant-vbguest
vagrant plugin install dotenv
```

3.) Clone this project

```
git clone https://github.com/yukihiko-shinoda/vagrant-static-container.git
cd vagrant-static-container
```

4.) Create .env file

Please copy .env.dist to .env and set all parameters.

ex.
```
MAINTAINER="yukhikfuture"
TAG_NAME="my-image"
IP_VIRTUAL_BOX="192.168.11.5"
IP_VIRTUAL_BOX_BRIDGE="192.168.11.254"
IP_DOCKER_CONTAINER="192.168.11.6/24"
IP_DOCKER_CONTAINER_BRIDGE="192.168.11.253/24"
```

5.) Create Dockerfile

Please add Dockerfile into this directory or copy Dockerfile.dist to Dockerfile and update contents.

6.) Up and Running

```
vagrant up
vagrant ssh
```
