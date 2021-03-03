#!/bin/bash

sudo docker run --name hadoop2 --privileged=true \
    --net hadoop-net \
    -itd hadoop-dev /usr/sbin/init
