#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export debug=$debug							;
export deploy=$deploy							;
export stack=$stack							;
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
pwd=$( dirname $( readlink -f $0 ) ) 					;
#########################################################################
test -z "$stack" && echo PLEASE DEFINE THE VALUE FOR stack && exit 1 	;
test -z "$deploy" 							\
  && echo PLEASE DEFINE THE TYPE OF DEPLOYMENT: LATEST/RELEASE && exit 1;
#########################################################################
git clone https://github.com/secobau/docker.git 			;
source docker/AWS/common/functions.sh 					;
rm --recursive --force docker 						;
#########################################################################
command=" git clone https://github.com/secobau/proxy2aws.git proxy2aws ";
targets=" InstanceManager1 " 						;
for target in $targets 							;
do 									;
  send_command "$command" "$target" "$stack" 				;
done 									;
#########################################################################
command=" find proxy2aws " 						;
targets=" InstanceManager1 " 						;
for target in $targets 							;
do 									\
  send_command "$command" "$target" "$stack" 				;
done 									;
#########################################################################
kube=" --kubeconfig /etc/kubernetes/admin.conf "			;
sudo=" sudo kubectl delete "						;
#########################################################################
file=aws2cloud.conf							;
command=" $sudo configmap $file $kube "					;
targets=" InstanceManager1 " 						;
for target in $targets 							;
do 									\
  send_list_command "$command" "$target" "$stack" 			;
done 									;
#########################################################################
file=aws2cloud.htpasswd							;
command=" $sudo secret $file $kube "					;
targets=" InstanceManager1 " 						;
for target in $targets 							;
do 									\
  send_list_command "$command" "$target" "$stack" 			;
done 									;
#########################################################################
file=cloud2instance.conf						;
command=" $sudo secret $file $kube "					;
targets=" InstanceManager1 " 						;
for target in $targets 							;
do 									\
  send_command "$command" "$target" "$stack" 				;
done 									;
#########################################################################
file=aws2prem.conf							;
command=" $sudo secret $file $kube "					;
targets=" InstanceManager1 " 						;
for target in $targets 							;
do 									\
  send_command "$command" "$target" "$stack" 				;
done 									;
#########################################################################
apps=" aws2cloud aws2prem aws2cloud-BLUE aws2prem-BLUE "		;
folder=proxy2aws/Kubernetes/$deploy					;
for app in $apps							;
do 									\
  command=" sudo kubectl delete --filename $folder/$app.yaml $kube "	;
  targets=" InstanceManager1 "						;
  for target in $targets						;
  do 									\
    send_list_command "$command" "$target" "$stack"			;
  done									;
done									;
#########################################################################
command=" sudo rm --recursive --force proxy2aws " 			;
targets=" InstanceManager1 " 						;
for target in $targets 							;
do 									\
  send_command "$command" "$target" "$stack" 				;
done 									;
#########################################################################
