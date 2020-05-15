#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
domain=raw.githubusercontent.com                                        ;
export=" export debug=$debug "						;
file=deploy.sh    	                                                ;
path=secobau/proxy2aws/master/$mode/Shell				;
targets=" InstanceManager1 " 						;
#########################################################################
export=" $export 							\
  &&									\
  export deploy=$deploy							\
"									;
send_remote_file $domain "$export" $file $path $stack "$targets"	;
#########################################################################
