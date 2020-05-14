#!/bin/bash
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export debug=$debug							;
export stack=$stack							;
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
pwd=$( dirname $( readlink -f $0 ) ) 					;
#########################################################################
domain=raw.githubusercontent.com					;
etc=etc/yum.repos.d							;
file=kubernetes.repo							;
path=secobau/proxy2aws/master						;
repo=https://$domain/$path/$etc/$file					;
#########################################################################
wget $repo && sudo mv $file /$etc/ 					;
#########################################################################
