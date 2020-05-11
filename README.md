This project consists of an NginX Reverse Proxy that will forward traffic from a cloud service to an internal service on premises and vice-versa.

The connection between the proxy and the services is done through HTTPS with Basic Authentication.

The proxy service is deployed in AWS on a production-grade highly available and secure infrastructure consisting of private and public subnets, NAT gateways, security groups and application load balancers in order to ensure the isolation and resilience of the different components.

Before creating the infrastructure you will need a Hosted Zone in AWS Route53:

```bash

# TO LIST THE EXISTING HOSTED ZONES
aws route53 list-hosted-zones --output text ;


```

In case you want to use HTTPS then you will also need a previously provisioned AWS Certificate:

```bash

# TO LIST THE EXISTING CERTIFICATES IN CASE YOU NEED HTTPS
aws acm list-certificates --output text ;


```

The template will create 6 EC2 machines spread on 3 different Availability Zones with Docker-CE installed, 3 Private and Public Subnets, 3 NAT Gateways, 2 Security Groups, 2 Application Load Balancers and the necessary Routes, Roles and attachments to ensure the isolation of the EC2 machines and the security and resilience of the whole infrastructure.

The EC2 machines do not have any open port accessible from outside.

We will use AWS Systems Manager to connect and maintain the EC2 machines without the need of any bastion or breaking the isolation.

Here follow the links to the CloudFormation templates that define the infrastructure (you can choose to use HTTP, HTTPS or a mix of both):
* https://github.com/secobau/proxy2aws/tree/master/AWS/AMI

After you have successfully deployed the infrastructure in AWS you will create a Cloud9 instance to access your infrastructure with AWS Systems Manager.

You might need the following information if you want to connect to the machines via SSH (not necessary in principle):
* https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html
* https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-linux

Now you have two ways to deploy your application. Please follow the links below depending on the orchestrator of your choice: 
* Swarm: https://github.com/secobau/proxy2aws/tree/master/Swarm
* Kubernetes: https://github.com/secobau/proxy2aws/tree/master/Kubernetes
