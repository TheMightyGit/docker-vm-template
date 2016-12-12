#!/bin/bash

docker run -it --restart=always -P -v $HOME/.ssh/:/home/{{ cookiecutter.username }}/.ssh/ -v /var/run/docker.sock -v $HOME/.gitconfig:/home/{{ cookiecutter.username }}/.gitconfig -v nonvolatile:/home/{{ cookiecutter.username }}/nonvolatile $(docker build -q .)
