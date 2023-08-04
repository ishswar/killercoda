# Introduction 

In this demo we will start with multi tear web app, and see how we can deploy them to Kubernetes 

- Using just YAML/Manifests 
- Converting them to individual Helm charts 
- Creating multiple values file to support different deployment requirement 
- Running same set of Helm charts using Helmfile 
- Utilizing Helmfile to support different deployment requirements 

# Sample app

Sample deployment files that we will use in this demo come from Repo [https://github.com/dockersamples/example-voting-app](https://github.com/dockersamples/example-voting-app) - thanks a bunch to [Bret Fisher](https://github.com/BretFisher)

# Pre-req 

We expect you have running kubernetes and have kubectl configured and pointing to correct context so that it can connect to that cluster.
You will also need Helm and helmfile tool installed ( steps for helmfile install are given ) 

# Architecture  

We are deploying multi tier application 

- A front-end web app in Python which lets you vote between two options
- A Redis which collects new votes
- A .NET worker which consumes votes and stores them in…
- A Postgres database backed by a Docker volume
- A Node.js web app which shows the results of the voting in real time

![](https://i.ibb.co/9yVvQ5p/voterapp.png)



