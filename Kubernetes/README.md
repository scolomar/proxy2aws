Run the following commands to deploy a Kubernetes cluster consisting of three managers and three workers spread on three different Availability Zones:

```BASH

# SET THE VARIABLE NAME OF THE STACK CREATED IN CLOUDFORMATION
stack=proxy2aws 						;

# TO CREATE THE CLUSTER
rm -rf docker 							;
export stack=$stack                                    		\
  && git clone https://github.com/secobau/docker.git   		\
  && chmod +x docker/AWS/install/Kubernetes/cluster.sh 		\
  && ./docker/AWS/install/Kubernetes/cluster.sh        		\
  && rm -rf docker 						;


```

You will need a set of Docker Configs and Secrets to set up the configuration of the application.

You can deploy the following samples instead of creating your own configuration:

```BASH

# IN CASE YOU NEED TO DEPLOY THE SAMPLE CONFIG FILES
rm -rf proxy2aws						;
export stack=$stack                                       	\
  && git clone https://github.com/secobau/proxy2aws.git   	\
  && chmod +x proxy2aws/Kubernetes/Shell/deploy-config.sh      	\
  && ./proxy2aws/Kubernetes/Shell/deploy-config.sh             	\
  && rm -rf proxy2aws						;


```

Now you will deploy the application. The Docker images are hosted in Docker Hub:
* https://hub.docker.com/r/secobau/proxy2aws

The deployment can use the latest image for Continous Integration or the specified release for Continuous Delivery. You will have to choose between the two. Depending on your choice the script will use the appropriate docker-compose file.

```BASH

# DEFINE THE TYPE OF DEPLOYMENT: LATEST OR RELEASE
deploy=release 							;
deploy=latest 							;

# TO DEPLOY THE APP
rm -rf proxy2aws 						;
export stack=$stack                                       	\
  && export deploy=$deploy                                	\
  && git clone https://github.com/secobau/proxy2aws.git   	\
  && chmod +x proxy2aws/Kubernetes/Shell/deploy.sh        	\
  && ./proxy2aws/Kubernetes/Shell/deploy.sh               	\
  && rm -rf proxy2aws 						;


```

The services will be available at the following URLs:
* https://aws2cloud.sebastian-colomar.com
* https://aws2prem.sebastian-colomar.com

After the deployment is finished it is a good idea to remove the Docker Configs and Secrets from the disk of the Manager:

```BASH

# TO REMOVE THE CONFIGS AND SECRETS FROM DISK
rm -rf proxy2aws 						;
 export stack=$stack                                      	\
  && git clone https://github.com/secobau/proxy2aws.git   	\
  && chmod +x proxy2aws/Kubernetes/Shell/remove-config.sh 	\
  && ./proxy2aws/Kubernetes/Shell/remove-config.sh        	\
  && rm -rf proxy2aws 						;


```

Once you are finished you can remove the containers with the following script:

```BASH

# TO REMOVE THE APP
rm -rf proxy2aws 						;
export stack=$stack                                      	\
  && git clone https://github.com/secobau/proxy2aws.git 	\
  && chmod +x proxy2aws/Kubernetes/Shell/remove.sh       	\
  && ./proxy2aws/Kubernetes/Shell/remove.sh              	\
  && rm -rf proxy2aws 						;


```

You can optionally remove the AWS infrastructure created in CloudFormation otherwise you might be charged for any created object:

```BASH

# TO REMOVE THE CLOUDFORMATION STACK
aws cloudformation delete-stack --stack-name $stack		; 


```


