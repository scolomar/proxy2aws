#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
export debug=$debug							;
export deploy=$deploy							;
#########################################################################
domain=raw.githubusercontent.com                                        ;
#########################################################################
file=deploy.sh    	                                                ;
path=secobau/proxy2aws/master/Kubernetes/Shell				;
targets=" InstanceManager1 " 						;
send_remote_file $domain "$export" $file $path $stack "$targets";
#########################################################################
