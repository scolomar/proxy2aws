#!/bin/bash
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################


set +x && test "$debug" = true && set -x ;

pwd=$( dirname $( readlink -f $0 ) ) ;

test -z "$stack" && echo PLEASE DEFINE THE VALUE FOR stack && exit 1 ;
test -z "$deploy" && echo PLEASE DEFINE THE TYPE OF DEPLOYMENT: LATEST/RELEASE && exit 1 ; 

kubeconfig=/etc/kubernetes/admin.conf;

git clone https://github.com/secobau/docker.git ;
source docker/AWS/common/functions.sh ;
rm --recursive --force docker ;

command=" git clone https://github.com/secobau/proxy2aws.git proxy2aws " ;
targets=" InstanceManager1 " ;
for target in $targets ; do
  send_command "$command" "$target" "$stack" ;
done ;

command=" find proxy2aws " ;
targets=" InstanceManager1 " ;
for target in $targets ; do
  send_command "$command" "$target" "$stack" ;
done ;

folder=/configs/etc/nginx/conf.d;
file=aws2cloud.conf;
command=" sudo kubectl create configmap $file --from-file $folder/$file --kubeconfig $kubeconfig ";
targets=" InstanceManager1 " ;
for target in $targets ; do
  send_list_command "$command" "$target" "$stack" ;
done ;

folder=/secrets/etc/nginx;
file=aws2cloud.htpasswd;
command=" sudo kubectl create secret generic $file --from-file $folder/$file --kubeconfig $kubeconfig ";
targets=" InstanceManager1 " ;
for target in $targets ; do
  send_list_command "$command" "$target" "$stack" ;
done ;

folder=/secrets/etc/nginx/conf.d;
file=cloud2instance.conf;
command=" sudo kubectl create secret generic $file --from-file $folder/$file --kubeconfig $kubeconfig ";
targets=" InstanceManager1 " ;
for target in $targets ; do
  send_command "$command" "$target" "$stack" ;
done ;

folder=/secrets/etc/nginx/conf.d;
file=aws2prem.conf;
command=" sudo kubectl create secret generic $file --from-file $folder/$file --kubeconfig $kubeconfig ";
targets=" InstanceManager1 " ;
for target in $targets ; do
  send_command "$command" "$target" "$stack" ;
done ;

apps=" aws2cloud-BLUE aws2prem-BLUE ";
apps=" aws2cloud aws2prem ";
folder=proxy2aws/Kubernetes/$deploy;
for app in $apps;
do
  command=" sudo kubectl apply --filename $folder/$app.yaml --kubeconfig $kubeconfig ";
  targets=" InstanceManager1 ";
  for target in $targets;
  do
    send_list_command "$command" "$target" "$stack";
  done;
done;

command=" sudo rm --recursive --force proxy2aws " ;
targets=" InstanceManager1 " ;
for target in $targets ; do
 send_command "$command" "$target" "$stack" ;
done ;

