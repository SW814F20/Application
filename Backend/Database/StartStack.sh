#!/bin/bash
# This script will generate the docker image files and start the stack on a single node swarm.

docker image build ./master -t sw814f20/pg-master
docker image build ./slave  -t sw814f20/pg-slave

docker stack deploy -c ./docker-swarm.yml Giraf
