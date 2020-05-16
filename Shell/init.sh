#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$debug"                || exit 100                             ;
test -n "$deploy" 		|| exit 100				;
test -n "$HostedZoneName"       || exit 100                             ;
test -n "$Identifier"           || exit 100                             ;  
test -n "$mode"                 || exit 100                             ;        
test -n "$RecordSetName1"       || exit 100                             ;     
test -n "$RecordSetName2"       || exit 100                             ;     
test -n "$RecordSetName3"       || exit 100                             ;     
test -n "$stack"                || exit 100                             ;       
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
domain=raw.githubusercontent.com                                        ;
#########################################################################
file=functions.sh                                                       ;
path=secobau/docker/master/AWS/common                                   ;
curl --remote-name https://$domain/$path/$file                          ;
source ./$file                                                          ;
rm --force ./$file							;
#########################################################################
export -f encode_string							;
export -f exec_remote_file						;
export -f send_command							;
export -f send_list_command						;
export -f send_remote_file						;
export -f send_wait_targets						;
export -f service_wait_targets						;
#########################################################################
file=deploy.sh                                               		;
path=secobau/docker/master/AWS/install/AMI				;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
#########################################################################
file=cluster.sh                                               		;
path=secobau/docker/master/AWS/install/$mode				;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
#########################################################################
file=deploy-config-ssm.sh                                               ;
path=secobau/proxy2aws/master/Shell                                     ;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
#########################################################################
file=deploy-ssm.sh      	                                        ;
path=secobau/proxy2aws/master/Shell                               	;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
#########################################################################
file=remove-config-ssm.sh                                               ;
path=secobau/proxy2aws/master/Shell                                     ;
output="								\
  $(									\
    exec_remote_file $domain $file $path				;
  )									\
"									;
#########################################################################