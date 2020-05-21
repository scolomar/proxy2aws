This project consists of an NginX Reverse Proxy that will forward traffic from a cloud service to an internal service on premises and vice-versa.  
The connection between the proxy and the services is done through HTTPS with Basic Authentication.

The proxy service is deployed in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

You can set up your infrastructure in AWS running the following commands from a terminal in a Cloud9 environment with enough privileges.
You may also configure the variables so as to customize the setup:

```BASH 


#########################################################################
debug=false                                                     	;
debug=true                                                     		;
deploy=latest                                                   	;
deploy=release                                                   	;
HostedZoneName=example.com                                  	 	;
HostedZoneName=sebastian-colomar.com                                   	;
# Identifier is the ID of the certificate in case you are using HTTPS	#
Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                         ;
KeyName=mySSHpublicKey							;
KeyName=proxy2aws							;
mode=kubernetes                                                       	;
mode=swarm                                                       	;
RecordSetName1=service-1                                   		;
RecordSetName1=aws2cloud                                   		;
RecordSetName2=service-2                                   		;
RecordSetName2=aws2prem                                   		;
RecordSetName3=service-3                                   		;
stack=mystack                                                     	;
stack=proxy2aws                                                     	;
TypeManager=t3a.nano                                                    ;
TypeWorker=t3a.nano                                                     ;
#########################################################################
export apps=" aws2cloud.yaml aws2prem.yaml "				;
export AWS=secobau/docker/master/AWS					;
export debug								;
export deploy								;
export domain=raw.githubusercontent.com					;
export HostedZoneName							;
export Identifier							;
export KeyName								;
export mode								;
export RecordSetName1							;
export RecordSetName2							;
export RecordSetName3							;
export repository=proxy2aws						;
export stack								;
export TypeManager                                                      ;
export TypeWorker                                                       ;
export username=secobau							;
#########################################################################
path=$AWS/bin								;
file=init.sh								;
date=$( date +%F_%H%M )							;
mkdir $date								;
cd $date								;
curl --remote-name https://$domain/$path/$file				;
chmod +x ./$file							;
nohup ./$file								&
#########################################################################



```

