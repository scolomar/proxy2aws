###############################################################################
#        Copyright (C) 2020        Sebastian Francisco Colomar Bauza          #
#        SPDX-License-Identifier:  GPL-2.0-only                               #
###############################################################################

#!/bin/bash

set +x && test "$debug" = true && set -x ;

pwd=$( dirname $( readlink -f $0 ) ) ;

test -z "$stack" && echo PLEASE DEFINE THE VALUE FOR stack && exit 1 ;

git clone https://github.com/secobau/docker.git ;
source docker/AWS/common/functions.sh ;
rm --recursive --force docker ;

repo=https://raw.githubusercontent.com/secobau/proxy2aws/master/etc/yum.repos.d/kubernetes.repo;
file=$( basename $repo );

command="wget $repo && sudo mv $file /etc/yum.repos.d/";
targets=" InstanceManager1 " ;
for target in $targets ; do
 send_command "$command" "$target" "$stack" ;
done ;

command="ls -l /etc/yum.repos.d/$file " ;
targets=" InstanceManager1 " ;
for target in $targets ; do
 send_list_command "$command" "$target" "$stack" ;
done ;
