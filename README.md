This project consists of an NginX Reverse Proxy that will forward traffic from one service to another and vice-versa.  
The connection between the proxy and the services is done through HTTPS with Basic Authentication.


The services could represent services in the cloud, on premises or a combination of both.


You will find below instructions on how to deploy this project in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

* https://github.com/secobau/docker-aws/tree/master
