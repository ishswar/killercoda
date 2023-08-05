
Check out Git Repo and Deploy

_In this step we are not dot using Helm yet - we are just using Kubernetes yaml/manifest file to deploy applications to understand how all it works_

<br>

# Deploying using yaml/manifest files 

Clone my github repo :

`git clone https://github.com/ishswar/example-voting-app.git`{{exec}}

These has all the code we will use during this demo 

Change into to directory k8s-specifications `cd example-voting-app/k8s-specifications/`{{exec}}
These have all YAML files for deployment

1. Voting app - web app once vote received (via browser) - they are saved into Redis
2. Redis server
3. .NET code that scans Redis server and inserts votes into Database 
4. Database to store Votes   
5. Result app that shows votes via reading Database 

There are five apps above - which means we should have 5 Kubernetes deployment files - that is what you will find in `k8s-specifications` folder

Now we also need a stable end-point to access apps above. 
The voting app and result app are exposed outside the cluster via NodePort and DB and Redis are exposed internally using ClusterIP.

`tree ~/example-voting-app/k8s-specifications/`{{exec}}

Output 

```
|-- db-deployment.yaml
|-- db-service.yaml
|-- redis-deployment.yaml
|-- redis-service.yaml
|-- result-deployment.yaml
|-- result-service.yaml
|-- vote-deployment.yaml
|-- vote-service.yaml
`-- worker-deployment.yaml
```

## Deploy them 

We can deploy all of them in one shot using command (assuming you are in that directory ) 

`kubectl create -f ~/example-voting-app/k8s-specifications/`{{exec}} 

output should look like 

```
controlplane $ kubectl create -f .
deployment.apps/db created
service/db created
deployment.apps/redis created
service/redis created
deployment.apps/result created
service/result created
deployment.apps/vote created
service/vote created
deployment.apps/worker created
```

Ideally, we should deploy DB and Redis first , then .NET app and last voting  app and result app - but above command does not guarantee that

After few seconds you should see all pods and service up and running..

Everything gets deployed in `default` namespace.

`kubectl get pods && kubectl get svc`{{exec}} 

Sample output : 
================

```
NAME                     READY   STATUS    RESTARTS   AGE
db-989b6b476-jqw6r       1/1     Running   0          2m28s
redis-7fdbb9576f-2vqvq   1/1     Running   0          2m28s
result-f9f4fbbc7-kzz6d   1/1     Running   0          2m28s
vote-5f865477fc-fb629    1/1     Running   0          2m28s
worker-667975666-8lbkr   1/1     Running   0          2m28s
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
db           ClusterIP   10.97.51.10      <none>        5432/TCP         2m28s
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP          26d
redis        ClusterIP   10.104.196.148   <none>        6379/TCP         2m28s
result       NodePort    10.97.138.2      <none>        5001:31001/TCP   2m28s
vote         NodePort    10.96.230.143    <none>        5000:31000/TCP   2m28s
```

You should be able to access voting GUI via URL [ACCESS VOTE APP]({{TRAFFIC_HOST1_31000}}) - it will look like this : 


![](https://i.ibb.co/s5QMMtM/image.png)

Submit your vote and now you can access result page via URL like: [ACCESS RESULT APP]({{TRAFFIC_HOST1_31001}}) - it might look like this : 

![](https://i.ibb.co/r6RxLHf/image.png)

So, now it should be evidently clear to you that we have two applications which are expose to end-user - applications for voting and application for checking the result 

![](https://i.ibb.co/YXfZXG2/voterapp-1.png)

This concludes our steps of deploying multi-tier applications on kubernetes using YAML files.  

# Teardown all that we deployed 

Before we go to next step lets delete everything that we just deployed 

`kubectl delete -f ~/example-voting-app/k8s-specifications/`{{exec}} 

# Summary of this step 

- The goal is to deploy a multi-tier voting application using Kubernetes YAML manifests.
- A Git repo with the app code and YAML specs is cloned.
- There are 5 components: vote app, result app, redis, .NET worker, and database.
- Each has a Kubernetes deployment and service YAML file.
- kubectl create is used to deploy all manifests to the default namespace.
- The vote and result apps are exposed via NodePort services.
- The deployed apps can be accessed on the provided URLs.
- This demonstrates deploying a multi-tier app on Kubernetes using raw YAML manifests.
- The YAML files define the replica count, images, ports, etc for each component.
- Finally, kubectl delete is used to tear down the deployment and clean up.

In summary, the key points are:

Cloning Git repo with YAML manifests
Deploying YAMLs for each app component
Exposing vote and result apps via NodePort
Accessing the deployed application
Deploying a multi-tier app on Kubernetes using YAML
Tearing down deployment using kubectl delete
Overall, it shows how to deploy a multi-tier, multi-component application on Kubernetes using raw manifest YAML files.