# GCP_PUB-SUB_TF

### Updated Coding questions with solutions:
### 1. Create a simple application using any language of your choice that can be deployed to
Kubernetes or and satisfies the following requirements
a. An application that returns some data to https requests 
Ans: I have used python flask with ssl_context which accepts request on HTTPS with dummpy certs.

b. Is highly available
Ans: I have used replicaset to run application in HA and also we can go with HPA configuration.

c. Is able to persist data beyond the life of the application
Ans: Yes, I have used PV,PVC and mount PVC volume on deployment. My application code is not storing anything but we can use this way to persist the data beyond the life of application/Pod

d. Securely stores and accesses its web security certificate (this cert can be any dummy file)
Ans: I have used secret from k8 where is keeping key.pem and cert.pem in base64 encoded format. Below is the commad to create key.pem and cert.pem. Mount secret as volume in pod so that it can be picked by python app to start it. 

Bonus:
a. Only receives requests once the application is started
Ans: I have used readiness probe to achieve this task.

b. Automatically restarts if the application is unresponsive
Ans: I have used here liveness probe to achieve this.

c. Only one replica can be unavailable at any time
Ans: Pod Disruption Budget is the best option to run atleast 1 replica of application 

d. Organize Kubernetes resource manifests using Kustomize and/or Helm
Ans: Created Helm chart to deploy application smoothly

e. Deploy the application into a service mesh
Ans: Using Linkerd which lightweight and easy to integrate with on going application on K8 cluster. 


### Steps:
```bash
mayankkoli@mayankkoli-mac docker % git clone 
mayankkoli@mayankkoli-mac docker % cd docker 
mayankkoli@mayankkoli-mac docker % docker build -t myfirstapp:v1 .
```


##### Generating key.pem and cert.pem 
```bash
mayankkoli@mayankkoli-mac docker % cd ../k8/
mayankkoli@mayankkoli-mac docker % openssl req -x509 -newkey rsa:4096 -nodes -out cert.pem -keyout key.pem -days 365
mayankkoli@mayankkoli-mac docker % kubectl create secret generic certs --from-file=key.pem --from-file=cert.pem -o yaml --dry-run > ../k8/secret.yaml
```

##### To install application via helm charts
```bash
helm upgrade --install myfirstapp . -f values.yaml
helm list 
```

##### To verify app is deployed and running
```bash
mayankkoli@mayankkoli-mac docker % kubectl get svc
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP          3h45m
mysvc        NodePort    10.101.51.104    <none>        5000:32321/TCP   2m
```

##### Using curl to verify app is running fine
```bash
mayankkoli@mayankkoli-mac docker % curl https://localhost:32321 -k
{
  "data": "Please append /data in URL",
  "welcome page": "Please append /welcome in URL"
}
mayankkoli@mayankkoli-mac docker % curl https://localhost:32321/welcome -k
{
  "message": "welcome"
}
mayankkoli@mayankkoli-mac docker % curl https://localhost:32321/data -k   
[
  "Dockerfile",
  "cert.pem",
  "key.pem",
  "app.py",
  "requirements.txt"
]
```

mayankkoli@mayankkoli-mac k8 % kubectl get pdb
NAME        MIN AVAILABLE   MAX UNAVAILABLE   ALLOWED DISRUPTIONS   AGE
myapp-pdp   1               N/A               0                     81s


#### I had already setup linkerd so just inject the linkerd in running deployment
```bash
kubectl get deploy -o yaml | linkerd inject - | kubectl apply -f -
linkerd viz dashboard &
```




### 2. Develop Terraform code for creating and managing 10,000 Google Pub/Sub topics.
### Solution


### GCP Technical Questions:
1. <b>Question</b>: Considering app engine and cloud run. If the application is required to be mult-regional which service would you recommend?. Explain why? <br />
<b>Answer</b>:  Multi-region applications are resilient in ways that single region and single AZ applications cannot match. Single region architecture can survive machine failures. Single availability zone architecture can survive an AZ failure. But only multi-region application architecture can survive when an entire region fails. If our agenda is to achieve resilient and Reliability of the system then we should go with Cloud Run We can provision application in Cloud Run and that application can be accessed service which is running in multi regional with the help of other services i.e CLoud CDN to reduce latency near by edge locations and External LB which will route traffic to nearest regions of the source request.  here traffic management is a built-in feature. Every deployment creates a new immutable revision and you can route incoming requests to multiple revisions at the same time, to perform a gradual rollout (or rollout as fast as possible). Pros & Cons - It will cost you more but you will have system reliability there so that app is continously UP and responding to customers. App Engine Flexible is running on VMs, that's why it is a bit slower than Cloud Run to deploy a new revision of your app and scale-up. Cloud Run deployments are faster as they are not running on VMs


2. <b>Question</b>: What is the recommended most secure way to connect to CloudSQL? <br />
<b>Answer</b>: Using the Cloud SQL Auth proxy we can achieve the most secure way to connect to CLoud SQL because it recommends a method for authenticating connections to a Cloud SQL instance by using IAM permissions. It validates connections using credentials for a user or service account and wrapping the connection in a SSL/TLS layer that's authorized for a Cloud SQL instance


3. <b>Question</b>: What are some challenges working with a Shared VPC? <br />
<b>Answer</b>: We can not use shared VPC with Different organization. It will work with other service projects but they should be in same organization where you shared VPC created. i.e. while creating an instance involves selecting a zone, a network, and a subnet. Both the selected subnet and the selected zone must be in the same region and should be part of same organization. 

 
4. <b>Question</b>: What GCP service would you use to provide WAF for a public endpoint? <br />
<b>Answer</b>: Cloud Armor can be used as WAF service in GCP which will provide DDOS protections (IP Allow/Deny, Geo, WAF, Application attacks, SQL Injections) and it can be integrated with Load balancers. 
