#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
test -n "$debug"	|| exit 100					;
#########################################################################
folders=" configs secrets " 						;
#########################################################################
git clone https://github.com/secobau/proxy2aws.git proxy2aws		;
for folder in $folders 							;
do 									\
  sudo cp --recursive --verbose proxy2aws/$folder / 		 	;
done 									;
sudo rm --recursive --force proxy2aws 		 			;
#########################################################################
