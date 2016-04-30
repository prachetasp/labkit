#!/bin/bash

USER=`whoami`

docker run --rm \
       --name=$2 \
       -P=true \
       -e HOST_GID=`id -g` \
       -e HOST_UID=`id -u` \
       -e HOST_USER=$USER \
       -v ~/.m2:/home/$USER/.m2 \
       -v `pwd`/.lein/profiles.clj:/home/$USER/.lein/profiles.clj \
       -v `pwd`/zshrc:/home/$USER/.zshrc \
       -v `pwd`/emacs-live:/home/$USER/.emacs.d \
       -v `pwd`/.ssh:/home/$USER/.ssh \
       -it \
       $1 \
       /root/startup.sh
