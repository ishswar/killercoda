
Check out Git Repo and Deploy

<br>

# Deploying using yaml/manifest files 

Clone my github repo :

`git clone https://github.com/ishswar/example-voting-app.git`{{exec}}

These has all the code we will use during this demo 

Change into to directory k8s-specifications `cd example-voting-app/k8s-specifications/`{{exec}}
These have YAML files to deploy 

1. Voting app - web app once vote received (via browser) - they are saved into Redis
1. Redis server
1. .NET code that scans Redis server and inserts votes into Database 
1. Database to store Votesthe  
1. Result app that shows votes via reading Database 

There are five apps above - which means we should have 5 Kubernetes deployment files - that is what you will find in `k8s-specifications` 
Now we also need a stable end-point to access apps above. 
The votting app and result app are exposed outside the cluster via NodePort and DB and Redis are exposed internally using ClusterIP.

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

`kubectl create -f .`{{exec}} 

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

```
controlplane $ kubectl get pods && kubectl get svc
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

You should be able to access voting GUI via URL like http://(node-ip):31000 - it will look like this : 

![](https://i.ibb.co/s5QMMtM/image.png)

Submit your vote and now you can access result page via URL like: http://(node-ip):31001 - it might look like this : 

![](https://i.ibb.co/r6RxLHf/image.png)

This concludes our steps of deploying multi-tier applications on kubernetes using YAML files.  
