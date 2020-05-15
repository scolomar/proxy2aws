#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
export debug=$debug							;
export deploy=$deploy							;
export stack=$stack							;
#########################################################################
domain=raw.githubusercontent.com                                        ;
#########################################################################
file=functions.sh                                                       ;
path=secobau/docker/master/AWS/common					;
pwd=$PWD && mkdir --parents $path && cd $path                           ;
curl -O https://$domain/$path/$file                                     ;
source ./$file                                                          ;
cd $PWD && rm --recursive --force $path                                 ;
#########################################################################
file=deploy.sh    	                                                ;
path=secobau/proxy2aws/master/Swarm/Shell				;
targets=" InstanceManager1 " 						;
exec_remote_file_targets $domain $file $path $stack "$targets"		;
#########################################################################
