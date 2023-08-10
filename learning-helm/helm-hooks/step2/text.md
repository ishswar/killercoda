
Add persistent storage to Vote application so we can use Helm hook to manipulate data

<br>

# Add PVC and update vote deployment 

For this step you can check out branch `with-helm-hook`

`git checkout with-helm-hook`{{exec}}

In this repo; folder `vote/templates` has been updated

`cd ~/example-voting-app/k8s-specifications && tree vote/templates/`{{exec}}

```
vote/templates/
|-- _helpers.tpl
|-- _vote-hook.yaml
|
|-- vote-deployment.yaml
|-- vote-pvc.yaml
`-- vote-service.yaml

1 directory, 6 files
```

In this you will see we have one new file called `vote-pvc.yaml`
There is also file called `_vote-hook.yaml` ignore it for now 

# Let install latest chart 

`cd ~/example-voting-app/k8s-specifications && helm upgrade vote ./vote`{{exec}}

We are using `upgrade` command as we already have `vote` chart installed 

After upgrade command succeeds if you query cluster using command `kubectl get pods,pvc,svc -l app=vote`{{exec}} you will see _new PVC_ has been added else vote application is running as usual 

```
NAME                       READY   STATUS            RESTARTS   AGE
pod/vote-fb9c8d847-nl4w5   0/1     PodInitializing   0          9s

NAME                             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/vote-pvc   Bound    pvc-c90576f4-bbc5-4bee-8ffe-e7c288dd4889   1Gi        RWO            local-path     9s

NAME           TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/vote   NodePort   10.96.229.141   <none>        5000:31000/TCP   9s
```

## So what changed ?

What changed is now `vote` application is using persistent storage and part of `vote` POD startup there is `init-container` that uses same image as `vote` app but it's sole job is to move folder named `/app` to persistent storage. Voting app mounts that storage now part of it's container and uses `/app` folder from that persistent storage 

![](https://i.ibb.co/VvpCQGW/voter-app-change.gif)

### Update to YAML 

Below image shows how voter app's deployment YAML change from previous step to this step 

If you also see `vote-deployment.yaml` that file has now been updated to do two thing : 

1. It uses PVC `vote-pvc` and folder `/app` is mounted from that storage 
2. We also use one init container that start when POD starts and it's job is to copy `/app` folder from Image to PVC storage 

![](https://i.ibb.co/wKgnvxn/image.png)

## File check before hook is invoked 

`kubectl exec -i deploy/vote -c vote -- cat /app/templates/index.html | grep title`{{exec}}

output should show like this : 

`<title>{{option_a}} vs {{option_b}}!</title>`

As you can see there is word `vs` in it - so in next topic we will see how using Helm hook we can replace string "vs" to "or"

## Adding Helm Hook 

Now lets add Helm hook that runs during Post install or Post upgrade - that way anytime we do deployment this Hook will be called
Helm hook YAML is already there - we just have to remove "_" from it's name (Helm skips any file that start with "_" in `template` folder)

This will move "_" file file name 
`mv vote/templates/_vote-hook.yaml vote/templates/vote-hook.yaml`{{exec}}

Now let's upgrade chart one more time to add Hook in mix 

`cd ~/example-voting-app/k8s-specifications && helm upgrade vote ./vote`{{exec}}

## File check after Hook has run 

Now if we do same test as before we can see the template file has been updated to use "or" in place of word "vs" 

`kubectl exec -i deploy/vote -c vote -- cat /app/templates/index.html | grep title`{{exec}}

`kubectl logs -l job-name=vote-info --tail=-1`{{exec}}