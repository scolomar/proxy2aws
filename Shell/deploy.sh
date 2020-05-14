#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
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
set +x && test "$debug" = true && set -x				;
#########################################################################
domain=raw.githubusercontent.com                                        ;
#########################################################################
path=secobau/docker/master/AWS/common                                   ;
file=functions.sh                                                       ;
pwd=$PWD && mkdir --parents $path && cd $path                           ;
curl -O https://$domain/$path/$file                                     ;
source ./$file                                                          ;
cd $PWD && rm --recursive --force $path                                 ;
#########################################################################
path=secobau/docker/master/AWS/install/AMI				;
file=deploy.sh                                               		;
exec_remote_file $domain $file $path				 	;
#########################################################################
path=secobau/docker/master/AWS/install/$mode				;
file=cluster.sh                                               		;
exec_remote_file $domain $file $path				 	;
#########################################################################
path=secobau/proxy2aws/master/Shell                                     ;
file=deploy-config-ssm.sh                                               ;
exec_remote_file $domain $file $path				 	;
#########################################################################
path=secobau/proxy2aws/master/$mode/Shell                               ;
file=deploy-ssm.sh      	                                        ;
exec_remote_file $domain $file $path				 	;
#########################################################################
path=secobau/proxy2aws/master/Shell                                     ;
file=remove-config-ssm.sh                                               ;
exec_remote_file $domain $file $path				 	;
#########################################################################
