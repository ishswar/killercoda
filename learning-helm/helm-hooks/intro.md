# Helm Hook

Here is a brief introduction to Helm hooks:

Helm hooks allow running arbitrary scripts and jobs at defined points during a release lifecycle. 

Key reasons hooks are useful:

- Perform initial setup like creating resources before the main deployment.

- Execute post-install steps like migrations, restarts after installation.

- Run cleanup logic like deregistering resources on deletion. 

- Synchronize ordering of dependent charts and resources.

- Trigger notifications to external systems when certain events occur.

Hooks are defined using annotations in Kubernetes manifests within a Helm chart. Helm will execute the hooks based on the release action happening.

This enables inserting automation, orchestration and notification logic around chart installation, upgrades, rollbacks etc. Hooks help extend Helm's capabilities to support complex deployment workflows.

So in summary, Helm hooks allow easily inserting automation and orchestration logic around release lifecycle events. This unlocks new possibilities for chart authors.

# Introduction 

In this demo we will start with multi tear web app, and see how we can use Helm Hook to manipulate/update setup after its deployed 

- Deploy voter app and all it's dependent micro services 
- Update Voter app to use Persistent volume 
- Use init container to move stuff from Docker Image to persistent stuff
- Use Helm Post install/upgrade Hook to update content of application 
- Notes on troubleshooting 

![](https://i.ibb.co/hFRCb4g/cat-vs-dog-animation.gif)

# Sample application

Sample deployment files that we will use in this demo come from Repo [example-voting-app](https://github.com/dockersamples/example-voting-app) - thanks a bunch to [Bret Fisher](https://github.com/BretFisher)

# Prerequisite

We expect you have running kubernetes and have kubectl configured and pointing to correct context so that it can connect to that cluster.
You will also need Helm and helmfile tool installed ( steps for helmfile install are given ) 

# Architecture of sample application  

We are deploying multi tier application 

- A front-end web app in Python which lets you vote between two options
- A Redis which collects new votes
- A .NET worker which consumes votes and stores them in…
- A Postgres database backed by a Docker volume
- A Node.js web app which shows the results of the voting in real time

Kubernetes view of this App

![](https://i.ibb.co/9yVvQ5p/voterapp.png)

General dataflow of this App

![](https://github.com/dockersamples/example-voting-app/blob/3accda954e7c79ca4d90c83100df0d827df0770d/architecture.excalidraw.png?raw=true)

