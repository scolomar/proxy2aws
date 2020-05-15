#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export debug=$debug							;
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
pwd=$( dirname $( readlink -f $0 ) ) 					;
#########################################################################
kube=" --kubeconfig /etc/kubernetes/admin.conf "			;
#########################################################################
file=aws2cloud.conf							;
sudo kubectl delete configmap $file $kube 				;
#########################################################################
file=aws2cloud.htpasswd							;
sudo kubectl delete secret    $file $kube 				;
#########################################################################
file=aws2prem.conf							;
sudo kubectl delete secret    $file $kube 				;
#########################################################################
file=cloud2instance.conf						;
sudo kubectl delete secret    $file $kube 				;
#########################################################################
apps=" aws2cloud aws2prem aws2cloud-BLUE aws2prem-BLUE "		;
domain=raw.githubusercontent.com                                        ;
path=secobau/proxy2aws/master/Kubernetes/$deploy			;
pwd=$PWD && mkdir --parents $path && cd $path                           ;
for app in $apps							;
do 									\
  file=$app.yaml							;
  curl -O https://$domain/$path/$file                                   ;
  sudo kubectl delete --filename $file $kube 				;
done									;
cd $pwd && rm --recursive --force $path                                 ;
#########################################################################
