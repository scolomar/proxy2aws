FROM    nginx:stable-alpine
WORKDIR /etc/nginx
RUN     rm -rf conf.d \
        && ln -s /run/secrets/etc/nginx/conf.d .
