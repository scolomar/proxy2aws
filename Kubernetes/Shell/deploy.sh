#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export debug=$debug							;
export deploy=$deploy							;
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
pwd=$( dirname $( readlink -f $0 ) ) 					;
#########################################################################
apps=" aws2cloud aws2prem aws2cloud-BLUE aws2prem-BLUE "		;
domain=raw.githubusercontent.com                                        ;
kube=" --kubeconfig /etc/kubernetes/admin.conf "			;
path=secobau/proxy2aws/master/Kubernetes/$deploy			;
#########################################################################
file=aws2cloud.conf							;
folder=/configs/etc/nginx/conf.d					;
sudo kubectl create configmap $file --from-file $folder/$file $kube 	;
#########################################################################
file=aws2cloud.htpasswd							;
folder=/secrets/etc/nginx						;
sudo kubectl create secret generic $file --from-file $folder/$file $kube;
#########################################################################
file=aws2prem.conf							;
folder=/secrets/etc/nginx/conf.d					;
sudo kubectl create secret generic $file --from-file $folder/$file $kube;
#########################################################################
file=cloud2instance.conf						;
folder=/secrets/etc/nginx/conf.d					;
sudo kubectl create secret generic $file --from-file $folder/$file $kube;
#########################################################################
for app in $apps							;
do 									\
  curl -O https://$domain/$path/$app.yaml                               ;
  sudo kubectl apply --filename $app.yaml $kube 			;
done									;
#########################################################################
