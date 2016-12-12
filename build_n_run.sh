#!/bin/bash

docker run -it --restart=always -P -v /Users/johnnymarshall/.ssh/:/home/johnny/.ssh/ -v /var/run/docker.sock -v /Users/johnnymarshall/.gitconfig:/home/johnny/.gitconfig $(docker build -q .)
