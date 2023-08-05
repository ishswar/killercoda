
<br>

### What did we just learned 

- We demonstrated deploying a multi-tier voting application on Kubernetes, first using raw YAML manifests, then converting the manifests to Helm charts to gain benefits like templating and centralized configuration. 
- We showed how to externalize application configuration like ports into Helm values.yaml and pass them to templates, facilitating customization across environments. Techniques included overriding values with --set during helm install and using separate values files for dev vs prod. 
- We then defined chart dependencies to install the whole application stack in one Helm command, and override child chart values from the parent chart. 
- Finally, we introduced Helmfile to simplify managing and deploying these multiple interconnected Helm charts declaratively, supporting multiple environments and synchronizing cross-release ordering. 

In summary, we progressed from basic YAML deployments to full-fledged application orchestration using Helm and Helmfile, learning various best practices around templating configurations, managing environments, defining dependencies, and multi-release coordination. The key takeaway is how tools like Helm and Helmfile enable scaling Kubernetes deployments from individual components to complex multi-tier applications in a robust and organized fashion.
