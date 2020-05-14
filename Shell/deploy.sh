#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
export debug=$debug							;
export deploy=$deploy							;
export HostedZoneName=$HostedZoneName					;
export Identifier=$Identifier						;
export mode=$mode							;
export RecordSetName1=$RecordSetName1					;
export RecordSetName2=$RecordSetName2					;
export RecordSetName3=$RecordSetName3					;
export s3domain=$s3domain						;
export stack=$stack							;
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
git clone https://github.com/secobau/docker.git   			;
chmod +x docker/AWS/install/AMI/deploy.sh				;
./docker/AWS/install/AMI/deploy.sh					;
chmod +x docker/AWS/install/$mode/cluster.sh 				;
./docker/AWS/install/$mode/cluster.sh        				;
rm --recursive --force docker 						;
#########################################################################
git clone https://github.com/secobau/proxy2aws.git 			;
chmod +x proxy2aws/Shell/deploy-config.sh				;
./proxy2aws/Shell/deploy-config.sh					;
chmod +x proxy2aws/$mode/Shell/deploy.sh           			;
./proxy2aws/$mode/Shell/deploy.sh                  			;
chmod +x proxy2aws/Shell/remove-config.sh 				;
./proxy2aws/Shell/remove-config.sh        				;
rm --recursive --force proxy2aws 					;
#########################################################################
