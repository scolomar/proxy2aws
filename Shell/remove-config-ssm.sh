#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$debug"	|| exit 100					;
test -n "$stack"	|| exit 100					;
#########################################################################
domain=raw.githubusercontent.com                                        ;
export=" export debug=$debug "						;
file=remove-config.sh                                                   ;
path=secobau/proxy2aws/master/Shell					;
targets=" InstanceManager1 " 						;
#########################################################################
send_remote_file $domain "$export" $file $path $stack "$targets"	;
#########################################################################
