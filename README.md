This project consists of an NginX Reverse Proxy that will forward traffic from a cloud service to an internal service on premises and vice-versa.

The connection between the proxy and the services is done through HTTPS with Basic Authentication.

The proxy service is deployed in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

Please follow this link to create your infrastructure in AWS:
* https://github.com/secobau/docker/tree/master/AWS

Once your infrastructure has been created you will need a set of Configs and Secrets to set up the configuration of the application. You can deploy the following samples instead of creating your own configuration:

```BASH

# IN CASE YOU NEED TO DEPLOY THE SAMPLE CONFIG FILES
rm -rf proxy2aws					;
export stack=$stack                                     \
  && git clone https://github.com/secobau/proxy2aws.git \
  && chmod +x proxy2aws/Shell/deploy-config.sh  	\
  && ./proxy2aws/Shell/deploy-config.sh             	\
  && rm -rf proxy2aws					;


```

After the deployment is finished it is a good idea to remove the Configs and Secrets from the disk of the Manager:

```BASH

# TO REMOVE THE CONFIGS AND SECRETS FROM DISK
rm -rf proxy2aws 					;
 export stack=$stack                                    \
  && git clone https://github.com/secobau/proxy2aws.git \
  && chmod +x proxy2aws/Shell/remove-config.sh 		\
  && ./proxy2aws/Shell/remove-config.sh        		\
  && rm -rf proxy2aws 					;


```

