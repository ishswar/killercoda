Go over Hook definition and talk about Cleanup 

<br>

# How does hook looks like 

As shown below [Helm Hook](https://helm.sh/docs/topics/charts_hooks/) is basically a definition of Kubernetes job - it creates a POD and waits for it to succeeds. 
If POD fails it will retry few times until it succeeds.

![](https://i.ibb.co/9w1dB4q/image.png)

## Cleanup 

As of now if you list pods - you will see that there is POD named `vote-post-task-<id>` ; and it's in `Completed` state
This is the POD that did work of copying content from Image to PVC. Ideally we don't want this job to linger after its work is done. 

`kubectl get pods`{{exec}}

```
NAME                      READY   STATUS      RESTARTS   AGE
db-7fc468458-rvdgr        1/1     Running     0          114s
redis-66949686f7-ctbtc    1/1     Running     0          113s
result-6b9bc65689-zpxhj   1/1     Running     0          111s
vote-564c8dcf4-8qr75      1/1     Running     0          47s
vote-post-task-tb858      0/1     Completed   0          13s
worker-6fc5d5b668-8d8w2   1/1     Running     0          112s
```

In order to get that behavior you need to add one more annotation to Hook definition and that is `"helm.sh/hook-delete-policy": hook-succeeded`; this will tell Hook to delete this JOB/POD after it finishes with exit code 0.

### Update hook to do cleanup 

We already have above annotation part of our Helm Hook Job definition but it is commented out 
Lets uncomment that 

`sed -i 's|# "helm.sh/hook-delete-policy"|"helm.sh/hook-delete-policy"|g' ~/example-voting-app/k8s-specifications/vote/templates/vote-hook.yaml`

Now let's uninstall old chart and apply new chart 

`cd ~/example-voting-app/k8s-specifications && helm uninstall vote && kubectl delete job vote-post-task && helm install vote ./vote`{{exec}}

Now if you try to get PODS 

`kubectl get pods`{{exec}}

You will see POD for Helm hook is gone 

```
NAME                      READY   STATUS    RESTARTS   AGE
db-7fc468458-pwh7n        1/1     Running   0          9m40s
redis-66949686f7-ws4z2    1/1     Running   0          9m39s
result-6b9bc65689-vl4mg   1/1     Running   0          9m37s
vote-564c8dcf4-4k7x2      1/1     Running   0          20s
worker-6fc5d5b668-z5cck   1/1     Running   0          9m38s
```

## Preserving the logs 

One issue we see with setting flag `"helm.sh/hook-delete-policy": hook-succeeded` is that POD gets deleted and with it all log of that Job is gone. 
One of the solution is we used here is to write the output of shell script to file that is in PVC so in future we can review that for any query we have about Hook's work.

You can see that lot file using below command 

`kubectl exec -i deployments/vote -c vote -- cat post-hook-output.txt`{{exec}}