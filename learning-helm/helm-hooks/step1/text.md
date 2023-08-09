
Create Helm charts and use them to Deploy voting  applications

<br>

# Clone sample repo

Clone my github repo :

`cd ~ && git clone https://github.com/ishswar/example-voting-app.git`{{exec}}

All the code is in this repo

# Deploy using Helm 

We will use Helm charts to Deploy Voting application
Check-out branch using command `cd ~/example-voting-app && git checkout with-helm`{{exec}} this branch has all the charts for deploying all needed microservices.

## Install using Helm charts 

```plain
helm install db ./db 
helm install redis ./redis
helm install worker ./worker
helm install result ./result
helm install vote ./vote
```{{exec}} 

### List all charts 

`helm list`{{exec}} 

Sample output 

```plain
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
db      default         1               2023-02-22 04:10:32.109280565 +0000 UTC deployed        db-0.1.0        1.16.0     
redis   default         1               2023-02-22 04:10:34.518627295 +0000 UTC deployed        redis-0.1.0     1.16.0     
result  default         1               2023-02-22 04:10:36.716386874 +0000 UTC deployed        result-0.1.0    1.16.0     
vote    default         1               2023-02-22 04:10:38.735587035 +0000 UTC deployed        vote-0.1.0      1.16.0     
worker  default         1               2023-02-22 04:10:35.724799692 +0000 UTC deployed        worker-0.1.0    1.16.0  
```

The above shows all 5 charts are installed.   
Now you can try to access the same URLs as before to access the 
[ACCESS VOTE APP]({{TRAFFIC_HOST1_31000}})
application and 
[ACCESS RESULT APP]({{TRAFFIC_HOST1_31001}}) application.


This concludes our demo about how you can deploy same multi-tier application using Helm charts

Not much has changed as of now - but now in next topic we will start to see how to use Helm Hook to make some post Install/Upgrade changes. 

