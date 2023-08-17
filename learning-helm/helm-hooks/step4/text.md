What if you don't want to hard code the script into POD

<br>

# Mount Post install script as configMap , use that in Hook

Checkout branch `with-helm-hook-scriptmount`

`git clean -fd && git checkout with-helm-hook-scriptmount`{{exec}}

Run command `tree ~/example-voting-app/k8s-specifications/vote`{{exec}} in this `vote` chart folder you will see we have two new files `postinstall.sh` and `vote-configmap-script.yaml` 

![](https://i.ibb.co/Bgy8KfP/image.png)

The Script code that was hardcoded in hook yaml now has moved into `postinstall.sh`
The new file `vote-configmap-script.yaml` reads a post install script and stores it as _Config Map_ in cluster 

![](https://i.ibb.co/t4KWVZn/image.png)

For file `vote-hook.yaml` as shown above all the script code is gone ( as that has moved to *postinstall.sh*)
Rather we mount config map as volume and then run that post install script during container startup 

## Apply new changes 

We do one more **upgrade** chart to see if our updated code for Hook works or not 

`cd ~/example-voting-app/k8s-specifications && kubectl delete job vote-post-task || echo { "No old job to delete" } && helm upgrade vote ./vote`{{exec}}

## Check logs 

You can see that lot file using below command 

`kubectl exec -i deployments/vote -c vote -- cat post-hook-output.txt`{{exec}}

Output should look like this 

```
File exists, proceeding...
Updating template
Done updating template
Received successful response!
```