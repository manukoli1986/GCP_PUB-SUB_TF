# GCP_PUB-SUB_TF

### Coding Questions:
1. Create a simple application using any language of your choice that can be deployed to
Kubernetes or and satisfies the following requirements
a. An application that returns some data to https requests
b. Is highly available
c. Is able to persist data beyond the life of the application
d. Securely stores and accesses its web security certificate (this cert can be any
dummy file)
Bonus:
a. Only receives requests once the application is started
b. Automatically restarts if the application is unresponsive
c. Only one replica can be unavailable at any time
d. Organize Kubernetes resource manifests using Kustomize and/or Helm
e. Deploy the application into a service mesh
2. Develop Terraform code for creating and managing 10,000 Google Pub/Sub topics.

### GCP Technical Questions:
<b>Question</b>: Considering app engine and cloud run. If the application is required to be mult-regional which service would you recommend?. Explain why?
<b>Answer</b>:  Multi-region applications are resilient in ways that single region and single AZ applications cannot match. Single region architecture can survive machine failures. Single availability zone architecture can survive an AZ failure. But only multi-region application architecture can survive when an entire region fails.

If our agenda is to achieve resilient and Reliability of the system then we should go with Cloud Run We can provision application in Cloud Run and that application can be accessed service which is running in multi regional with the help of other services i.e CLoud CDN to reduce latency near by edge locations and External LB which will route traffic to nearest regions of the source request.  here traffic management is a built-in feature. Every deployment creates a new immutable revision and you can route incoming requests to multiple revisions at the same time, to perform a gradual rollout (or rollout as fast as possible).

Pros & Cons - It will cost you more but you will have system reliability there so that app is continously UP and responding to customers. App Engine Flexible is running on VMs, that's why it is a bit slower than Cloud Run to deploy a new revision of your app and scale-up. Cloud Run deployments are faster as they are not running on VMs



<b>Question</b>: What is the recommended most secure way to connect to CloudSQL?
<b>Answer</b>: Using the Cloud SQL Auth proxy we can achieve the most secure way to connect to CLoud SQL because it recommends a method for authenticating connections to a Cloud SQL instance by using IAM permissions. It validates connections using credentials for a user or service account and wrapping the connection in a SSL/TLS layer that's authorized for a Cloud SQL instance


<b>Question</b>: What are some challenges working with a Shared VPC?
<b>Answer</b>: We can not use shared VPC with Different organization. It will work with other service projects but they should be in same organization where you shared VPC created. i.e. while creating an instance involves selecting a zone, a network, and a subnet. Both the selected subnet and the selected zone must be in the same region and should be part of same organization. 

 
<b>Question</b>: What GCP service would you use to provide WAF for a public endpoint?
<b>Answer</b>: Cloud Armor can be used as WAF service in GCP which will provide DDOS protections (IP Allow/Deny, Geo, WAF, Application attacks, SQL Injections) and it can be integrated with Load balancers. 
