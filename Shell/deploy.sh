#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
export debug=$debug							;
export deploy=$deploy							;
export HostedZoneName=$HostedZoneName					;
export Identifier=$Identifier						;
export mode=$mode							;
export RecordSetName1=$RecordSetName1					;
export RecordSetName2=$RecordSetName2					;
export RecordSetName3=$RecordSetName3					;
export s3domain=$s3domain						;
export stack=$stack							;
#########################################################################
domain=raw.githubusercontent.com                                        ;
#########################################################################
file=functions.sh                                                       ;
path=secobau/docker/master/AWS/common                                   ;
pwd=$PWD && mkdir --parents $path && cd $path                           ;
curl -O https://$domain/$path/$file                                     ;
source ./$file                                                          ;
cd $pwd && rm --recursive --force $path                                 ;
#########################################################################
file=deploy.sh                                               		;
path=secobau/docker/master/AWS/install/AMI				;
exec_remote_file $domain $file $path				 	;
#########################################################################
export -f exec_remote_file						;
export -f send_remote_file					;
export -f send_list_command						;
file=cluster.sh                                               		;
path=secobau/docker/master/AWS/install/$mode				;
exec_remote_file $domain $file $path				 	;
#########################################################################
file=deploy-config-ssm.sh                                               ;
path=secobau/proxy2aws/master/Shell                                     ;
exec_remote_file $domain $file $path				 	;
#########################################################################
file=deploy-ssm.sh      	                                        ;
path=secobau/proxy2aws/master/$mode/Shell                               ;
exec_remote_file $domain $file $path				 	;
#########################################################################
file=remove-config-ssm.sh                                               ;
path=secobau/proxy2aws/master/Shell                                     ;
exec_remote_file $domain $file $path				 	;
#########################################################################
