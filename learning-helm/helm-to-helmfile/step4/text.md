How to meet a need for having environment specific values 

<br>

## Different setup Different values file    

Now, for example you have Development setup and Production setup - but in Dev setup need to use one set of commands/values and production needs to use different. 
For this you can potentially come up with separate `values.yaml` and pass that value during installation . 

You can see there is one extra `values-dev.yaml` that is found under `vote` folder - if you inspect it has some extra parameters so if you want to use that you can re-run `helm` install command like 

`helm install vote ./vote -f ~/example-voting-app/k8s-specifications/vote/values-dev.yaml`{{exec}} 

So, this way you can use `/vote/values.yaml` for production but for development environment if you want to use additional or different parameters you can just have separate values.yaml file and use that for that purpose.

If you ever wanted to see what actual values that chart is using in k8s cluster you can run command like below that will fetch actual values currently used in cluster 

For example if I want to use what value chart `vote` is using I can use this command

```plain
helm get values vote
```{{exec}} 

Sample output : 

```plain
USER-SUPPLIED VALUES:
debug:
  enabled: true
  startup:
    command: '"gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile",
      "-","--log-level=DEBUG", "--workers", "4", "--keep-alive", "0"'
service:
  nodeport: 31005
  type: NodePort
```

Let's check service is indeed using port `31005` as stated above  - we can use command `kubectl get svc -l app=vote`{{exec}} - this prints info only about `vote` service.

### Giving values during helm install 

In above example we saw we can provide additional or alternative values for parameters that are defined in `values.yaml` by providing new file during install. But what if you want to just overwrite only one value - how would we do that ? For that you can use flag `--set` and give full yaml path to that parameter that you want to overwrite .

For example if I want to use different port for vote charts service
Currently it is using value `31005` as it was defined in values-dev.yaml - what if I want to update that or during install I want to change that.

```
kubectl get svc -l app=vote
NAME   TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
vote   NodePort   10.98.231.89   <none>        5000:31005/TCP   5m9s
```

If you want to update on existing installed chart you can again use command **upgrade** and run command like below 

`helm upgrade vote ./vote -f ~/example-voting-app/k8s-specifications/vote/values-dev.yaml --set service.nodeport=31006`{{exec}} 

You can see value gets updated 

`kubectl get svc -l app=vote`{{exec}}

Sample output 

```
NAME   TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
vote   NodePort   10.98.231.89   <none>        5000:31006/TCP   5m35s
```

<img src="https://www.goodfreephotos.com/albums/vector-images/info-symbol-vector-graphics.png" alt="Girl in a jacket" width="30" height="30"> You can use same `--set` flag during installed as well - above example show it in use with `upgrade` command as we already had chart `vote` installed 

### Tear down the setup 

Remove all charts and apps using this command 

`helm uninstall db redis worker result vote `{{exec}} 

# One Chart to rule all charts  

Before proceed with this - remove all old charts (`helm uninstall db redis worker result vote`{{exec}}) and checkout branch `with-helm-dependency`

`git checkout -f with-helm-dependency`{{exec}}

So far in above examples you have seen we have to install all charts one by one - what if you want to install all of them in one shot ? 
We know chart `vote` is sort of parent chart and all other charts are needed dependencies - so in that we can make them dependent chart for vote 

You do that by adding below lines to `vote/Charts.yaml`

```yaml
dependencies:
  - name: db
    version: 0.1.0
    repository: file://../db
  - name: redis
    version: 0.1.0
    repository: file://../redis
  - name: worker
    version: 0.1.0
    repository: file://../worker
  - name: result
    version: 0.1.0
    repository: file://../result
```

What this does is - it adds all of dependent charts under "Charts" folder for `vote`
As you can see currently that folder is empty 

```
$tree vote/
vote/
├── Chart.lock
├── Chart.yaml
├── charts
├── templates
│   ├── _helpers.tpl
│   ├── tests
│   │   └── test-connection.yaml
│   ├── vote-deployment.yaml
│   └── vote-service.yaml
├── values-dev.yaml
└── values.yaml
```

Now if you run a command as shown below that will tar all charts and put them under `Charts` folder 

`helm dependency update ~/example-voting-app/k8s-specifications/vote`{{exec}}

Sample output 

```
helm dependency update ./vote
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "nfs-subdir-external-provisioner" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 4 charts
Deleting outdated charts
```

And now if you see the `charts` folder under `vote` chart has all dependent charts tar-ed and copied there 

`tree ~/example-voting-app/k8s-specifications/vote/`{{exec}}

Sample output

```
vote/
├── Chart.lock
├── Chart.yaml
├── charts
│   ├── db-0.1.0.tgz
│   ├── redis-0.1.0.tgz
│   ├── result-0.1.0.tgz
│   └── worker-0.1.0.tgz
├── templates
│   ├── _helpers.tpl
│   ├── tests
│   │   └── test-connection.yaml
│   ├── vote-deployment.yaml
│   └── vote-service.yaml
├── values-dev.yaml
└── values.yaml

3 directories, 12 files
```

Now to install all charts only thing we need to do is install chart `vote` and it will installed all dependent charts 

`helm install vote ~/example-voting-app/k8s-specifications/vote`{{exec}}

You will see `vote` chart is installed - unfortunately dependent charts are installed but `helm ls` does not list them 

`helm ls`{{exec}}

Sample output

```
NAME                           	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART                                 	APP VERSION
vote                           	default  	1       	2023-08-03 18:49:57.765825687 +0000 UTC	deployed	vote-0.1.0                            	1.16.0
```

But you can see all the pods are running so that shows that all charts got installed 

`kubectl get pods,svc`{{exec}}

Sample output 

```
NAME                                               READY   STATUS    RESTARTS      AGE
db-5595c8db95-gclq2                                1/1     Running   0             9s
redis-6986c5d458-k95xg                             1/1     Running   0             9s
result-7b598bf7b8-smf62                            1/1     Running   0             9s
vote-595ffc978b-mfphx                              1/1     Running   0             9s
worker-7594c66d85-h987r                            1/1     Running   0             9s
```

### How to overwrite values for sub charts ? 

What if you want to update provide new values for nodePort for `result` chart ? 
We know service for worker is using values and by default it gets value from it's values.yaml - but since now `result` chart is dependent chart we need to provide that updated value differently .

One of the way you can do is update the `vote/values.yaml` file like this : 

```
result:
  service:
    nodeport: 31025
```

This way when helm installs dependent charts it will pass value `service.nodeport` to `result` chart while it installs that chart 

If you want you can play with this - you can uncomment values in `vote/values.yaml` and run `helm upgrade vote ./vote` and you will see value for `result` service is now having value of `31025`

### Tear down the setup 

Remove all charts and apps using this command 

`helm uninstall vote `{{exec}} 

# Summary of this step 

Here is a summary of the key points from the provided Markdown text:

- Different values.yaml files can be used for different environments like dev vs prod.

- helm install can reference a specific values file using -f flag.

- helm get values displays actual runtime values for a release.

- --set allows overriding specific values during install/upgrade.

- Dependencies can be defined in Chart.yaml to install related charts.  

- helm dependency update pulls in dependent charts.

- Installing the parent chart now installs child dependencies.

- Child chart values can be overridden by setting values in parent's values.yaml.

- This allows installing a full application stack in one helm install command.

- Different values per environment and component can be provided.

In summary, the key points are:

- Using different values files for dev vs prod
- Overriding install values with --set 
- Defining chart dependencies
- Install parent chart to install dependencies
- Customize child values from parent values.yaml
- Single install for full application stack
- Override child component values as needed

This demonstrates various techniques in Helm to handle multiple environments, customize applications, and install dependencies.