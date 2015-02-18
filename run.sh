#!/usr/bin/env bash
docker build -t tveronezi/buildbox .
docker run -i -t --rm=false tveronezi/buildbox
