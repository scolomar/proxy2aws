#!/bin/bash

#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################

set +x && test "$debug" = true && set -x ;

pwd=$( dirname $( readlink -f $0 ) ) ;

test -z "$stack" && echo PLEASE DEFINE THE VALUE FOR stack && exit 1 ;

git clone https://github.com/secobau/docker.git ;
source docker/AWS/common/functions.sh ;
rm --recursive --force docker ;

apps=" aws2cloud aws2prem aws2cloud-BLUE aws2prem-BLUE ";
for app in $apps;
do
  command=' sudo docker stack rm $app ';
  targets=" InstanceManager1 ";
  for target in $targets;
  do
    send_command "$command" "$target" "$stack";
  done;
done;
