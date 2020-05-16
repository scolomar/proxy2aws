#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$debug"	|| exit 100					;
test -n "$deploy"	|| exit 100					;
#########################################################################
apps=" aws2cloud aws2prem aws2cloud-BLUE aws2prem-BLUE "		;
domain=raw.githubusercontent.com                                        ;
path=secobau/proxy2aws/master/Swarm/$deploy				;
#########################################################################
for app in $apps							;
do 									\
  file=$app.yaml							;
  curl --remote-name https://$domain/$path/$file                        ;
  sudo docker stack deploy --compose-file $file $app 			;
  rm --force $file							;
done									;
#########################################################################
