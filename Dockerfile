#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
FROM									\
	nginx:1.19.0-alpine@sha256:2fa12030ffb0224e0b2e17bc4b1f1479e191e2fd65869fc60d09a8efa5b6d879 \
		AS nginx
#########################################################################
RUN									\
	for package in							\
		$(							\
			for x in 0 1 2 3 4 5 6 7 8 9;			\
			do						\
				apk list				\
					| awk /nginx/'{ print $1 }'	\
					| awk -F-$x  '{ print $1 }'	\
					| grep -v '\-[0-9]';		\
			done						\
				| sort					\
				| uniq					\
				| grep -v ^nginx$			\
		);							\
	do								\
		apk del $package;					\
	done
#########################################################################
RUN									\
	rm -rf /etc/nginx/conf.d					\
		&& ln -s /run/secrets/etc/nginx/conf.d /etc/nginx
#########################################################################
