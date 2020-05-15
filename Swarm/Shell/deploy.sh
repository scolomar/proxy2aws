#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
apps=" aws2cloud aws2prem aws2cloud-BLUE aws2prem-BLUE "		;
domain=raw.githubusercontent.com                                        ;
path=secobau/proxy2aws/master/Swarm/$deploy				;
pwd=$PWD && mkdir --parents $path && cd $path                           ;
for app in $apps							;
do 									\
  file=$app.yaml							;
  curl -O https://$domain/$path/$file                                   ;
  sudo docker stack deploy --compose-file $file $app 			;
done									;
cd $pwd && rm --recursive --force $path                                 ;
#########################################################################
