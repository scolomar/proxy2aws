#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x 				;
#########################################################################
git clone https://github.com/secobau/proxy2aws.git proxy2aws		;
folders=" configs secrets " 						;
for folder in $folders 							;
do 									\
  sudo cp --recursive --verbose proxy2aws/$folder / 		 	;
done 									;
sudo rm --recursive --force proxy2aws 		 			;
#########################################################################
