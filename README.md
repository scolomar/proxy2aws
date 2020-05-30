This project consists of an NginX Reverse Proxy that will forward traffic from one service to another and vice-versa.  
The connection between the proxy and the services is done through HTTPS with Basic Authentication.


The services could represent services in the cloud, on premises or a combination of both.


The proxy service is deployed in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.


You can set up your infrastructure in AWS running the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:


```BASH



#########################################################################
apps=" aws2cloud.yaml aws2prem.yaml "                                   \
branch_app=master                                                       \
branch_docker_aws=master                                                \
debug=false                                                             \
debug=true                                                              \
domain=raw.githubusercontent.com                                        \
HostedZoneName=sebastian-colomar.com                                    \
Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                         \
KeyName=proxy2aws                                                       \
mode=kubernetes                                                         \
mode=swarm                                                              \
RecordSetName1=aws2cloud                                                \
RecordSetName2=aws2prem                                                 \
RecordSetName3=service-3                                                \
repository_app=proxy2aws                                                \
repository_docker_aws=docker-aws                                        \
s3name=docker-aws                                                       \
s3region=ap-south-1                                                     \
stack=proxy2aws                                                         \
template=https.yaml                                                     \
TypeManager=t3a.nano                                                    \
TypeWorker=t3a.nano                                                     \
username_app=secobau                                                    \
username_docker_aws=secobau                                             \
                                                                        ;
#########################################################################
export apps                                                             \
&&                                                                      \
export AWS=$username_docker_aws/$repository_docker_aws/$branch_docker_aws \
&&                                                                      \
export branch_app                                                       \
&&                                                                      \
export debug                                                            \
&&                                                                      \
export deploy                                                           \
&&                                                                      \
export branch_docker_aws                                                \
&&                                                                      \
export repository_docker_aws                                            \
&&                                                                      \
export domain                                                           \
&&                                                                      \
export HostedZoneName                                                   \
&&                                                                      \
export Identifier                                                       \
&&                                                                      \
export KeyName                                                          \
&&                                                                      \
export mode                                                             \
&&                                                                      \
export RecordSetName1                                                   \
&&                                                                      \
export RecordSetName2                                                   \
&&                                                                      \
export RecordSetName3                                                   \
&&                                                                      \
export repository_app                                                   \
&&                                                                      \
export s3name                                                           \
&&                                                                      \
export s3region                                                         \
&&                                                                      \
export stack                                                            \
&&                                                                      \
export template                                                         \
&&                                                                      \
export TypeManager                                                      \
&&                                                                      \
export TypeWorker                                                       \
&&                                                                      \
export username_app                                                     \
                                                                        ;
#########################################################################
date=$( date +%F_%H%M )                                                 \
file=init.sh                                                            \
path=$AWS/bin                                                           \
                                                                        ;
#########################################################################
mkdir $date                                                             \
&&                                                                      \
cd $date                                                                \
&&                                                                      \
curl --remote-name https://$domain/$path/$file                          \
&&                                                                      \
chmod +x ./$file                                                        \
&&                                                                      \
nohup ./$file                                                           &
#########################################################################



```


If you are running a BLUE/GREEN deployment the following commands will be useful.


The following command will swap the load balancer so as to point to the BLUE deployment:
```BASH



#########################################################################
date=$( date +%F_%H%M )                                                 \
file=aws-target-blue.sh                                                 \
path=$AWS/bin                                                           \
                                                                        ;
#########################################################################
mkdir $date                                                             \
&&                                                                      \
cd $date                                                                \
&&                                                                      \
curl --remote-name https://$domain/$path/$file                          \
&&                                                                      \
chmod +x ./$file                                                        \
&&                                                                      \
nohup ./$file                                                           &
#########################################################################



```


The following command will swap back the load balancer so as to point again to the GREEN deployment:


```BASH



#########################################################################
date=$( date +%F_%H%M )                                                 \
file=aws-target-green.sh                                                \
path=$AWS/bin                                                           \
                                                                        ;
#########################################################################
mkdir $date                                                             \
&&                                                                      \
cd $date                                                                \
&&                                                                      \
curl --remote-name https://$domain/$path/$file                          \
&&                                                                      \
chmod +x ./$file                                                        \
&&                                                                      \
nohup ./$file                                                           &
#########################################################################



```


You can optionally remove the AWS infrastructure created in CloudFormation otherwise you might be charged for any created object:


```BASH



#########################################################################
## TO REMOVE THE CLOUDFORMATION STACK                                   #
aws cloudformation delete-stack --stack-name $stack                     ;
#########################################################################



```



