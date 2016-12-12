#!/bin/bash

docker run --restart=always -P -v $HOME/.ssh/:/home/{{ cookiecutter.username }}/.ssh/ -v /var/run/docker.sock -v $HOME/.gitconfig:/home/{{ cookiecutter.username }}/.gitconfig -v $(pwd)/nonvolatile:/home/{{ cookiecutter.username }}/nonvolatile $(docker build -t {{ cookiecutter.project_slug }} -q .)
