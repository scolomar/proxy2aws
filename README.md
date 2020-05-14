This project consists of an NginX Reverse Proxy that will forward traffic from a cloud service to an internal service on premises and vice-versa.  
The connection between the proxy and the services is done through HTTPS with Basic Authentication.

The proxy service is deployed in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

Please follow the shell commands below to set up your infrastructure in AWS.
You will be able to choose your orchestrator with the "mode" variable:

```BASH 

#########################################################################
debug=false                                                     	;
debug=true                                                     		;
deploy=latest                                                   	;
deploy=release                                                   	;
HostedZoneName=example.com                                  	 	;
HostedZoneName=sebastian-colomar.com                                   	;
Identifier=c3f3310b-f4ed-4874-8849-bd5c2cfe001f                         ;
mode=Kubernetes                                                       	;
mode=Swarm                                                       	;
RecordSetName1=service-1                                   		;
RecordSetName2=service-2                                   		;
RecordSetName3=service-3                                   		;
s3domain=docker-aws.s3.ap-south-1.amazonaws.com				;
stack=docker                                                     	;
#########################################################################
export debug								;
export deploy								;
export HostedZoneName							;
export Identifier							;
export mode								;
export RecordSetName1							;
export RecordSetName2							;
export RecordSetName3							;
export s3domain								;
export stack								;
#########################################################################
domain=raw.githubusercontent.com					;
path=secobau/proxy2aws/master/Shell					;
file=deploy.sh								;
curl -O https://$domain/$path/$file					;
chmod +x ./$file							;
nohup ./$file								&
#########################################################################


```

