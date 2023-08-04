How use templates to insert/provide values for application configuration

<br>

# All about HTTP Port 

In next few topics we are going to focus on how one can provide the value for HTTP Port for `vote` and `result` app.
We want to learn how we can provide this values during chart creation as well how we can overwrite these values during chart installation 

![](https://i.ibb.co/Y0KTHd0/voterapp-2.png)

# Use of values file in helm chart 

Each helm chart has value.yaml - you can imagine as input file or configuration file or properties file for Chart. 

- You define a nested structure in values.yaml 
- And you update your chart to use that values file 

Just becurse you see some values in _value.yaml_ does not mean chart is using it; you need to check actual chart yaml(s) to see it is indeed using those values. 

So lets see that in action 

Start by checking out branch `with-helm-values`

You can use command 

`git checkout with-helm-values`{{exec}} 

If you go to file `k8s-specifications/vote/templates/vote-service.yaml` 

you will two changes 

![](https://i.ibb.co/kDz5ZVZ/image.png)

Value of service `type` and _nodePort_ values are now coming from `.Values` object
This is how you refer values from _value.yaml_ file 

```
apiVersion: v1
kind: Service
metadata:
  labels:
    app: vote
  name: vote
spec:
  type: {{ .Values.service.type }}
  ports:
  - name: "vote-service"
    port: 5000
    targetPort: 80
    nodePort: {{ .Values.service.nodeport }}
  selector:
    app: vote
```

And if you look at values file you will see entry like 

![](https://i.ibb.co/HxXrzrx/image.png)

```
debug:
  enabled: false

service:
  type: NodePort
  nodeport: 31004
```

You can see value.yaml also defines few more value like `debug` that is used by file `k8s-specifications/vote/templates/vote-deployment.yaml`
That means any helm chart yaml can use value from value.yaml using same format `.Values.<path-to-value>`

Now lets deploy all charts just like before 

```plain 
helm install db ./db 
helm install redis ./redis
helm install worker ./worker
helm install result ./result
helm install vote ./vote
```{{exec}}

We can now check if `nodePort` for `vote` service is indeed using port 31004 or not - using below command 

`kubectl get svc -l app=vote`{{exec}}

Sample output 

```plain
NAME   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
vote   NodePort   10.110.168.80   <none>        5000:31004/TCP   52s
```

We can confirm it is indeed using that value.

Optional : If you want you can change the value of nodePort from 31004 to 31005 - you can use vi/nano to do that or use below command 

`sed -i 's/31004/31005/g' vote/values.yaml`{{exec}} 

After that you can upgrade only `vote` chart using example and then check the port again 

`helm upgrade vote ./vote`{{exec}} 

Output of upgrade should look like this : 

```
Release "vote" has been upgraded. Happy Helming!
NAME: vote
LAST DEPLOYED: Thu Aug  3 00:29:20 2023
NAMESPACE: default
STATUS: deployed
REVISION: 2
```

And if you check the port for `vote` service it should be using port `31005`

`kubectl get svc -l app=vote`{{exec}}

Sample output 

```
NAME   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
vote   NodePort   10.110.168.80   <none>        5000:31005/TCP   101s
```
### Tear down the setup 

Remove all charts and apps using this command 

`helm uninstall db redis worker result vote `{{exec}} 