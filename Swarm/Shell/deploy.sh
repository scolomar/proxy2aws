#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export debug=$debug							;
export deploy=$deploy							;
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
apps=" aws2cloud aws2prem aws2cloud-BLUE aws2prem-BLUE "		;
domain=raw.githubusercontent.com                                        ;
path=secobau/proxy2aws/master/Swarm/$deploy				;
#########################################################################
for app in $apps							;
do 									\
  curl -O https://$domain/$path/$app.yaml                               ;
  sudo docker stack deploy --compose-file $app.yaml $app 		;
done									;
#########################################################################
