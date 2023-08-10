How to use templates to insert/provide values for application configuration

<br>

# All about HTTP Port 

In the next few sections, we will focus on techniques to provide the HTTP port value for the `vote` and `result` applications. We'll learn approaches to set these values both during chart creation and installation.

![](https://i.ibb.co/Y0KTHd0/voterapp-2.png)

# Use of values file in helm chart 

Each Helm chart has a `values.yaml` file that serves as an input file for configuration values. 

- You can define a nested structure of values in `values.yaml`. 

- The chart templates can then reference these values.

Simply defining values in `values.yaml` doesn't mean the chart uses them. You need to check the chart's YAML templates to confirm they reference the values. 

Let's look at an example to see this in action.

Checkout the `with-helm-values` branch:

You can use command 

`git checkout -f with-helm-values`{{exec}} 

If you go to file `k8s-specifications/vote/templates/vote-service.yaml` 

you will see two changes 

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

<img src="https://www.goodfreephotos.com/albums/vector-images/info-symbol-vector-graphics.png" alt="Girl in a jacket" width="30" height="30"> If you remember originally vote application was exposed on `31000` but now since in values.yaml it is changed to `31004` after we deploy we need to update our URL that we use to access Vote application 

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

Now you can try to access the same URLs as before to access the 
[ACCESS VOTE APP]({{TRAFFIC_HOST1_31004}})

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

# Summery of this step 

Here is a summary of the key points from the provided Markdown text:

- The goal is to use Helm values to externalize application configuration like ports.

- The vote and result app Helm charts are modified to reference `.Values`. 

- Their service YAMLs now use `.Values.service.type` and `.Values.service.nodeport`.

- These values are defined in values.yaml for each chart.

- Helm templates can reference values using `.Values.<path>`. 

- The apps are deployed using helm install referencing the chart directories.

- The vote service nodePort is verified to be using the value from values.yaml.

- The port value is updated directly in values.yaml and vote chart upgraded. 

- The service picks up the new nodePort value from values.yaml.

- This demonstrates externalizing config like ports into values.yaml.

- Templates can then consume these values.

- Useful for customizing charts for different environments.

- Finally, all charts are uninstalled to clean up.

In summary, the key points are:

- Externalizing app config values into values.yaml
- Modifying chart templates to reference .Values
- Passing values from values.yaml to templates 
- Updating values and upgrading chart
- Consuming customized values from templates
- Uninstalling charts to cleanup

Overall, it shows how to effectively parameterize application configuration using Helm values and templates.