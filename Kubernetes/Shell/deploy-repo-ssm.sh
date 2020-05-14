#!/bin/bash
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export debug=$debug							;
export stack=$stack							;
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
pwd=$( dirname $( readlink -f $0 ) ) 					;
#########################################################################
domain=raw.githubusercontent.com                                        ;
#########################################################################
file=functions.sh                                                       ;
path=secobau/docker/master/AWS/common					;
curl -O https://$domain/$path/$file                                     ;
source ./$file                                                          ;
rm --force ./$file							;
#########################################################################
file=deploy-repo.sh    	                                                ;
path=secobau/proxy2aws/master/Kubernetes/Shell				;
targets="								\
	InstanceManager1						\
	InstanceManager2						\
	InstanceManager3						\
	InstanceWorker1							\
	InstanceWorker2							\
	InstanceWorker3							\
"									;
exec_remote_file_targets $domain $file $path $stack "$targets"		;
#########################################################################
