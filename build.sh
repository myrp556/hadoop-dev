#!/bin/bash

sudo docker rm -f hadoop-dev
sudo docker rmi -f hadoop-dev
sudo docker build -t hadoop-dev .

echo build hadoop-dev
