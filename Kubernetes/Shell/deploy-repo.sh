#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export debug=$debug							;
export stack=$stack							;
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -z "$stack" && echo PLEASE DEFINE THE VALUE FOR stack && exit 1 	;
#########################################################################
pwd=$( dirname $( readlink -f $0 ) ) 					;
#########################################################################
git clone https://github.com/secobau/docker.git 			;
source docker/AWS/common/functions.sh 					;
rm --recursive --force docker 						;
#########################################################################
domain=raw.githubusercontent.com					;
etc=etc/yum.repos.d							;
path=secobau/proxy2aws/master/$etc					;
file=kubernetes.repo							;
repo=https://$domain/$path/$file					;
#########################################################################
command="wget $repo && sudo mv $file /$etc/"				;
targets="								\
	InstanceManager1						\
	InstanceManager2						\
	InstanceManager3						\
	InstanceWorker1							\
	InstanceWorker2							\
	InstanceWorker3							\
"									;
for target in $targets 							;
do 									\
  send_command "$command" "$target" "$stack" 				;
done 									;
#########################################################################
command="ls -l /etc/yum.repos.d/$file " 				;
targets="								\
	InstanceManager1						\
	InstanceManager2						\
	InstanceManager3						\
	InstanceWorker1							\
	InstanceWorker2							\
	InstanceWorker3							\
"									;
for target in $targets 							;
do 									\
  send_list_command "$command" "$target" "$stack" 			;
done 									;
#########################################################################
