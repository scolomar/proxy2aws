* https://raw.githubusercontent.com/secobau/proxy2aws/master/YAML/AWS/cloudformation.yml
* https://raw.githubusercontent.com/secobau/proxy2aws/master/YAML/AWS/cloudformation-https.yml
* https://raw.githubusercontent.com/secobau/proxy2aws/master/YAML/AWS/cloudformation-http-https.yml

```bash
# IN CASE YOU NEED HTTPS TO ACCESS YOUR APP
aws acm list-certificates --output text ;

# NAME OF THE STACK CREATED WITH CLOUDFORMATION
stack=proxy2aws ;

# TO CREATE THE SWARM
export stack=$stack                                     \
  && git clone https://github.com/secobau/docker.git    \
  && chmod +x docker/AWS/install/Swarm/cluster.sh       \
  && ./docker/AWS/install/Swarm/cluster.sh ;            \
  rm -rf docker ;

# IN CASE YOU NEED TO DEPLOY THE SAMPLE CONFIG FILES
export stack=$stack                                     \
  && git clone https://github.com/secobau/proxy2aws.git \
  && chmod +x proxy2aws/Shell/deploy-config.sh          \
  && ./proxy2aws/Shell/deploy-config.sh ;               \
  rm -rf proxy2aws ;

# TO DEPLOY THE APP
export stack=$stack                                     \
  && git clone https://github.com/secobau/proxy2aws.git \
  && chmod +x proxy2aws/Shell/deploy.sh                 \
  && ./proxy2aws/Shell/deploy.sh ;                      \
  rm -rf proxy2aws ;

# TO REMOVE THE APP
export stack=$stack                                     \
  && git clone https://github.com/secobau/proxy2aws.git \
  && chmod +x proxy2aws/Shell/remove.sh                 \
  && ./proxy2aws/Shell/remove.sh ;                      \
  rm -rf proxy2aws ;
```
