
Create Helm charts and use them to Deploy same set of applications


<br>

# Clone sample repo

Clone my github repo :

`git clone https://github.com/ishswar/example-voting-app.git`{{exec}}

All the code is in this repo for this demo

# Deploy using Helm 

Next step we can deploy same application as before but this time using helm charts. 
We will create 5 charts - one for each of application. 

General steps : 

1. Create a Helm chart using `helm create` command
1. Delete YAML files created by above command 
1. Move our original Helm files for each application under `templates` subfolder 
1. Use `helm install` to install chart 

You have two choices - create charts manually (follow below steps) or check-out branch using command `git checkout with-helm` this will get you same charts that you will have if you follow below steps.


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

## Tear down the setup 

`helm uninstall db redis worker result vote `{{exec}} 

Not much has changed as of now - but now in next topic we will start to externalize some of  the information so during deployment we can provide updated values. 

