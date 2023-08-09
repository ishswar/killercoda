
Add persistent storage to Vote application so we can use Helm hook to manipulate data

<br>

# Add PVC and update vote deployment 

For this step you can check out branch `with-helm-hook`

`git checkout with-helm`{{exec}}

In this repo folder `vote/templates` has been updated

```
tree vote/templates/
vote/templates/
|-- _helpers.tpl
|-- _vote-hook.yaml
|-- tests
|   `-- test-connection.yaml
|-- vote-deployment.yaml
|-- vote-pvc.yaml
`-- vote-service.yaml

1 directory, 6 files
```

In this you will see we have one new file called `vote-pvc.yaml`
There is also file called `_vote-hook.yaml` ignore it for now 

If you also see `vote-deployment.yaml` that file has now been updated to do two think : 

1. It uses PVC `vote-pvc` and folder `/app` is mounted from that storage 
2. We also use on init container that start when POD starts and it's job is to copy `/app` folder from Image to PVC storage 

`cd ~/example-voting-app/k8s-specifications && helm upgrade vote ./vote`{{exec}}

We are using `upgrade` command as we already have `vote` chart installed 

After upgrade command succeeds if you query cluster using command `kubectl get pods,pvc,svc -l app=vote`{{exec}} you will see new PVC has been added else vote application is running as usually 

```
NAME                       READY   STATUS            RESTARTS   AGE
pod/vote-fb9c8d847-nl4w5   0/1     PodInitializing   0          9s

NAME                             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/vote-pvc   Bound    pvc-c90576f4-bbc5-4bee-8ffe-e7c288dd4889   1Gi        RWO            local-path     9s

NAME           TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/vote   NodePort   10.96.229.141   <none>        5000:31004/TCP   9s
```

## So what changed 

What changed is now `vote` application is using persistent storage and part of `vote` POD startup there is `init-container` that uses same image as `vote` app but it's sole job is to move folder named `/app` to persistent storage. Voting app mounts that storage now part of it's container and uses `/app` folder from there 