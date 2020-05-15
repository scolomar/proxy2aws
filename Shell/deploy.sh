#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$debug" || exit 100						;
test -n "$deploy" || exit 100						;
test -n "$HostedZoneName" || exit 100					;
test -n "$Identifier" || exit 100					;
test -n "$mode" || exit 100						;
test -n "$RecordSetName1" || exit 100					;
test -n "$RecordSetName2" || exit 100					;
test -n "$RecordSetName3" || exit 100					;
test -n "$stack" || exit 100						;
#########################################################################
export debug=$debug							;
export deploy=$deploy							;
export HostedZoneName=$HostedZoneName					;
export Identifier=$Identifier						;
export mode=$mode							;
export RecordSetName1=$RecordSetName1					;
export RecordSetName2=$RecordSetName2					;
export RecordSetName3=$RecordSetName3					;
export stack=$stack							;
#########################################################################
export -f exec_remote_file						;
export -f send_list_command						;
export -f send_remote_file						;
#########################################################################
domain=raw.githubusercontent.com                                        ;
#########################################################################
file=functions.sh                                                       ;
path=secobau/docker/master/AWS/common                                   ;
#########################################################################
pwd=$PWD && mkdir --parents $path && cd $path                           ;
curl -O https://$domain/$path/$file                                     ;
source ./$file                                                          ;
cd $pwd && rm --recursive --force $path                                 ;
#########################################################################
file=deploy.sh                                               		;
path=secobau/docker/master/AWS/install/AMI				;
#########################################################################
exec_remote_file $domain $file $path				 	;
#########################################################################
file=cluster.sh                                               		;
#########################################################################
path=secobau/docker/master/AWS/install/$mode				;
exec_remote_file $domain $file $path				 	;
#########################################################################
file=deploy-config-ssm.sh                                               ;
path=secobau/proxy2aws/master/Shell                                     ;
#########################################################################
exec_remote_file $domain $file $path				 	;
#########################################################################
file=deploy-ssm.sh      	                                        ;
path=secobau/proxy2aws/master/Shell                               	;
#########################################################################
exec_remote_file $domain $file $path				 	;
#########################################################################
file=remove-config-ssm.sh                                               ;
path=secobau/proxy2aws/master/Shell                                     ;
#########################################################################
exec_remote_file $domain $file $path				 	;
#########################################################################
