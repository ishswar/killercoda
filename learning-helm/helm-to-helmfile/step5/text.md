Managing Kubernetes Deployments at Scale with Helmfile

<br>

# Helm files orchestrator - helmfile tool  

Reasons to use Helmfile instead of just Helm when deploying multiple charts:

## Simplified management of multiple releases

Helmfile allows deploying entire environments specified in a simple declarative YAML format. Much easier than running helm install/upgrade commands.  
Charts, values, namespaces, etc. can be specified together for the overall environment.  
Supports templating to reduce duplication across similar releases.  

## Synchronization of releases

Helmfile has primitives like hooks, wait, retries, and timeouts to handle ordering and synchronize releases.  
E.g. Wait for a database chart to be up before deploying the backend. Retry failed installations.  
Such cross-release coordination is difficult to orchestrate with just Helm.  

## Environment separation

Helmfile can maintain different files for dev, staging, prod environments.  
Switch environments easily by changing context in a single command.  
Helm needs extra scripts and flags to achieve separation between environments.  

_In summary, once you reach a certain scale, Helmfile becomes indispensable for managing the complexity of multi-release deployments, release coordination, and multi-environment workflows._

## Install Helmfile  

Installing helmfile is easy - sample steps are like below 

```plain
wget https://github.com/helmfile/helmfile/releases/download/v0.151.0/helmfile_0.151.0_linux_amd64.tar.gz
tar -xvf helmfile_0.151.0_linux_amd64.tar.gz 
mv helmfile /usr/sbin/
```{{exec}}

Af you installed it you can run `version` command to see if it got installed successfully or not 

`helmfile -v`{{exec}}

Sample output 

`helmfile version v0.139.9`

You can now check-out branch `with-helmfile` 

`git checkout with-helmfile`{{exec}}

Under `k8s-specifications` you will find a _new_ file named `helmfile.yaml` - if you open it is is very simple as shown below :  

```
---
releases:

- name: db
  chart: db
- name: result
  chart: result
- name: redis
  chart: redis
- name: worker
  chart: worker
- name: vote
  chart: vote
```

** Note ** : File does not need to be called helmfile.yaml - but that is default file name that is expected if you want to use your own name you will need to pass flag `--file newname-helmfile.yaml` to provided new name.

What it means is it will deploy all of above charts in order they shows up.
You can also run a command `helmfile list` on helmfile to see what all chart will get installed and in what order

```
cd ~/example-voting-app/k8s-specifications
helmfile list
```{{exec}}

Sample output : 

```
NAME  	NAMESPACE	ENABLED	LABELS	CHART 	VERSION
db    	         	true   	      	db
result	         	true   	      	result
redis 	         	true   	      	redis
worker	         	true   	      	worker
vote  	         	true   	      	vote
```

## Deploying using helmfile 

Deploying using helmfile is easy; command to initiate deployment is 

`helmfile sync`{{exec}}

Sample out put is shown below 
You can see that it installed each helm chart in oder that we defined in `helmfile.yaml`

```
Building dependency release=db, chart=db
Building dependency release=redis, chart=redis
Building dependency release=worker, chart=worker
Building dependency release=vote, chart=vote
Building dependency release=result, chart=result
Affected releases are:
  db (db) UPDATED
  redis (redis) UPDATED
  result (result) UPDATED
  vote (vote) UPDATED
  worker (worker) UPDATED

Upgrading release=result, chart=result
Upgrading release=db, chart=db
Upgrading release=redis, chart=redis
Upgrading release=vote, chart=vote
Upgrading release=worker, chart=worker
Release "redis" does not exist. Installing it now.
NAME: redis
LAST DEPLOYED: Thu Aug  3 21:01:40 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1

Listing releases matching ^redis$
Release "worker" does not exist. Installing it now.
NAME: worker
LAST DEPLOYED: Thu Aug  3 21:01:40 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1

Listing releases matching ^worker$
Release "result" does not exist. Installing it now.
NAME: result
LAST DEPLOYED: Thu Aug  3 21:01:40 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1

Listing releases matching ^result$
Release "vote" does not exist. Installing it now.
NAME: vote
LAST DEPLOYED: Thu Aug  3 21:01:40 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1

Listing releases matching ^vote$
Release "db" does not exist. Installing it now.
NAME: db
LAST DEPLOYED: Thu Aug  3 21:01:40 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1

Listing releases matching ^db$
redis	default  	1       	2023-08-03 21:01:40.752330859 +0000 UTC	deployed	redis-0.1.0	1.16.0

worker	default  	1       	2023-08-03 21:01:40.771005718 +0000 UTC	deployed	worker-0.1.0	1.16.0

vote	default  	1       	2023-08-03 21:01:40.780854103 +0000 UTC	deployed	vote-0.1.0	1.16.0

result	default  	1       	2023-08-03 21:01:40.77468087 +0000 UTC	deployed	result-0.1.0	1.16.0

db  	default  	1       	2023-08-03 21:01:40.777775696 +0000 UTC	deployed	db-0.1.0	1.16.0


UPDATED RELEASES:
NAME     CHART    VERSION
redis    redis      0.1.0
worker   worker     0.1.0
result   result     0.1.0
vote     vote       0.1.0
db       db         0.1.0
```

## Updating value in charts 

After above deployment is succeeds you can check the nodePort used by `vote` chart - you can see it is using default value of `31004` - this value is defined in `chart/values.yaml` file 

```
kubectl get svc -l app=vote
NAME   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
vote   NodePort   10.104.56.191   <none>        5000:31004/TCP   59m
```

What if you want to update that value - now you don't have to go to that chart and update values.yaml - you can do that right from `helmfile.yaml` file 
Below is example that shows how you can provide values for each individual charts 


```
---
releases:

- name: db
  chart: db
- name: result
  chart: result
- name: redis
  chart: redis
- name: worker
  chart: worker
- name: vote
  chart: vote
  values:
   - service:
      nodeport: 31009
```

If you update the value of `helmfile.yaml` with above value and run `helmfile sync`{{exec}} you will see the nodePort for `vote` service will be now using port `31009`

```
kubectl get svc -l app=vote
NAME   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
vote   NodePort   10.104.56.191   <none>        5000:31009/TCP   71m
```

### Multiple environment 

Going back to our previous example of having one `default` set of values and one for `development` environment setting - how do we do that now in `helmfile` ? 
One way of doing that is to create a 2 go template file ( it's a basically yaml file - but it is proceed by go lang so you can use some go formatting/conditioning thee)

Let's create two files called `default.gotmpl` and `env.gotmpl` 

env.gotmpl

```
---
vote:
  service:
    nodeport: "31007"
```

default.gotmpl

```
---
vote:
  service:
    nodeport: "31008"
```

Save them in same directory as where `helmfile.yaml` is present. 

Now update the helmfile.yaml like below 

```
environments:
  default:
   values:
    - default.gotmpl
  dev:
    values:
      - env.gotmpl
---

releases:

- name: db
  chart: db
- name: result
  chart: result
- name: redis
  chart: redis
- name: worker
  chart: worker
- name: vote
  chart: vote
  values:
    - service:
        type: NodePort
        nodeport: {{ .Environment.Values.vote.service.nodeport }}  
```

So - here what we are doing is - we are getting value for nodeport from `.Environment.Values` YAML object. 
Hirarchey after .Environment.Values - is founder inside *.gotmpl found . So kept the same format like before so it start with `vote` then `service` and last the value of `nodeport`

Now we can easily swith between two set of values . 

If we don't give any flag and run `helmfile sync` values will be picked up from `default.gotmpl` 
** Node ** - It is not becuse file is named `default.gotmpl` thus it gets picked up by default. It is becuse in `helmfile.yaml` under environments.default we are using that file thus it gets picked up as defalut values .

Now if you want to swith to usering `Devlopment` environment value we can run same command as above but with addtional `-e` flag

```
helmfile -e dev sync
```

The the wrod `dev` comes from `helmfile.yaml` as there is addtional environment is defined called `dev` and it gets values from `env.gotempl`
If you look at file `env.gotmpl` the value of vote.service.nodeport is defined to be value of 31007 and after above command suceedes if you check the nodePort of vote service it will have value of 31007 - see below 

```
kubectl get svc -l app=vote
NAME   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
vote   NodePort   10.104.56.191   <none>        5000:31007/TCP   88m
```