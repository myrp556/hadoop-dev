#!/bin/bash

sudo docker run --name hadoop1 --privileged=true \
    -p 50070:50070 -p 50090:50090 -p 8088:8088\
    --net hadoop-net \
    -itd hadoop-dev /usr/sbin/init
