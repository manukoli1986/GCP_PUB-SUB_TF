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
1. Considering app engine and cloud run. If the application is required to be mult-regional
which service would you recommend?. Explain why?
2. What is the recommended most secure way to connect to CloudSQL?
3. What are some challenges working with a Shared VPC?
4. What GCP service would you use to provide WAF for a public endpoint?
