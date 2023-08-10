Go over Hook definition and talk about Cleanup 

<br>

# How does hook looks like 

As shown below it is basically a definition of Kubernetes job - it creates a POD and waits for it to succeeds. 
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

In order to get that behavior you need to add one more annotation to Hook definition and that is ``; this will tell Hook to delete this JOB/POD after it finishes with exit code 0.

## Preserving the logs 

One issue we see with setting flag `` is that POD gets deleted and with it all log of that Job is gone. 
One of the solution is we used here is to write the output of shell script to file that is in PVC so in future we can review that for any query we have about Hook's work.

You can see that lot file using below command 

`kubectl exec -i deployments/vote -c vote -- cat post-hook-output.txt`{{exec}}