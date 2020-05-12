Run the following commands to deploy a Docker Swarm cluster consisting of three managers and three workers spread on three different Availability Zones:

```BASH

# SET THE VARIABLE NAME OF THE STACK CREATED IN CLOUDFORMATION
stack=proxy2aws ;

# TO CREATE THE SWARM
rm -rf docker ;
export stack=$stack                                     \
  && git clone https://github.com/secobau/docker.git    \
  && chmod +x docker/AWS/install/Swarm/cluster.sh       \
  && ./docker/AWS/install/Swarm/cluster.sh              \
  && rm -rf docker ;


```

Now you will deploy the application. The Docker images are hosted in Docker Hub:
* https://hub.docker.com/r/secobau/proxy2aws

The deployment can use the latest image for Continous Integration or the specified release for Continuous Delivery. You will have to choose between the two. Depending on your choice the script will use the appropriate docker-compose file.

```BASH

# DEFINE THE TYPE OF DEPLOYMENT: LATEST OR RELEASE
deploy=release ;
deploy=latest ;

# TO DEPLOY THE APP
rm -rf proxy2aws ;
export stack=$stack                                     \
  && export deploy=$deploy                              \
  && git clone https://github.com/secobau/proxy2aws.git \
  && chmod +x proxy2aws/Swarm/Shell/deploy.sh                 \
  && ./proxy2aws/Swarm/Shell/deploy.sh                        \
  && rm -rf proxy2aws ;


```

The services will be available at the following URLs:
* https://aws2cloud.sebastian-colomar.com
* https://aws2prem.sebastian-colomar.com

Once you are finished you can remove the containers with the following script:

```BASH

# TO REMOVE THE APP
rm -rf proxy2aws ;
export stack=$stack                                     \
  && git clone https://github.com/secobau/proxy2aws.git \
  && chmod +x proxy2aws/Swarm/Shell/remove.sh                 \
  && ./proxy2aws/Swarm/Shell/remove.sh                        \
  && rm -rf proxy2aws ;


```

You can optionally remove the AWS infrastructure created in CloudFormation otherwise you might be charged for any created object:

```BASH

# TO REMOVE THE CLOUDFORMATION STACK
aws cloudformation delete-stack --stack-name $stack 


```

