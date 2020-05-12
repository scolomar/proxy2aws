#!/bin/bash
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################


set +x && test "$debug" = true && set -x ;

pwd=$( dirname $( readlink -f $0 ) ) ;

test -z "$stack" && echo PLEASE DEFINE THE VALUE FOR stack && exit 1 ;
test -z "$deploy" && echo PLEASE DEFINE THE TYPE OF DEPLOYMENT: LATEST/RELEASE && exit 1 ; 

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

file=aws2cloud.conf;
command=" sudo kubectl delete configmap $file --kubeconfig /etc/kubernetes/admin.conf "
targets=" InstanceManager1 " ;
for target in $targets ; do
	echo "Waiting for $target to complete ...";
 send_list_command "$command" "$target" "$stack" ;
done ;

file=aws2cloud.htpasswd;
command=" sudo kubectl delete secret $file --kubeconfig /etc/kubernetes/admin.conf "
targets=" InstanceManager1 " ;
for target in $targets ; do
	echo "Waiting for $target to complete ...";
 send_list_command "$command" "$target" "$stack" ;
done ;

file=aws2cloud.htpasswd;
command=" sudo kubectl delete secret $file --kubeconfig /etc/kubernetes/admin.conf "
targets=" InstanceManager1 " ;
for target in $targets ; do
	echo "Waiting for $target to complete ...";
 send_list_command "$command" "$target" "$stack" ;
done ;

file=cloud2instance.conf;
command=" sudo kubectl delete secret $file --kubeconfig /etc/kubernetes/admin.conf ";
targets=" InstanceManager1 " ;
for target in $targets ; do
 send_command "$command" "$target" "$stack" ;
done ;

file=aws2prem.conf;
command=" sudo kubectl delete secret $file --kubeconfig /etc/kubernetes/admin.conf ";
targets=" InstanceManager1 " ;
for target in $targets ; do
 send_command "$command" "$target" "$stack" ;
done ;

command=" sudo kubectl delete --filename proxy2aws/Kubernetes/$deploy/aws2cloud.yaml --kubeconfig /etc/kubernetes/admin.conf ";
targets=" InstanceManager1 " ;
for target in $targets ; do
	echo "Waiting for $target to complete ...";
 send_list_command "$command" "$target" "$stack" ;
done ;

command=" sudo kubectl delete --filename proxy2aws/Kubernetes/$deploy/aws2prem.yaml --kubeconfig /etc/kubernetes/admin.conf ";
targets=" InstanceManager1 " ;
for target in $targets ; do
	echo "Waiting for $target to complete ...";
 send_list_command "$command" "$target" "$stack" ;
done ;

command=" sudo rm --recursive --force proxy2aws " ;
targets=" InstanceManager1 " ;
for target in $targets ; do
 send_command "$command" "$target" "$stack" ;
done ;

