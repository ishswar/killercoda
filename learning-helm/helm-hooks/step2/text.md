
Add persistent storage to Vote application so we can use Helm hook to manipulate data

<br>

# Add PVC and update vote deployment 

For this step you can check out branch `with-helm-hook`

`git checkout with-helm`{{exec}}

In this you will see we have one new file called `vote-pvc.yaml`
There is also file called `_vote-hook.yaml` ignore it for now 

If you also see `vote-deployment.yaml` that file has now been updated to do two think : 

1. It uses PVC `vote-pvc` and folder `/app` is mounted from that storage 
2. We also use on init container that start when POD starts and it's job is to copy `/app` folder from Image to PVC storage 

`cd ~/example-voting-app/k8s-specifications && helm upgrade vote ./vote`{{exec}}
