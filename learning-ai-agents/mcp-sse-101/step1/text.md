
Create Helm charts and use them to Deploy voting  applications

<br>

# Clone sample repo

Clone MCP github repo :

`cd ~ && git clone https://github.com/ishswar/mcp-demos.git`{{exec}}

All the code is in this repo

# Deploy using Helm 

We will use Helm charts to Deploy Voting application
Check-out branch using command `cd ~/example-voting-app && git checkout with-helm`{{exec}} this branch has all the charts for deploying all needed microservices.

## Install python MCP Module

```shell
exec bash -l
# Install MCP module
pip install -U "mcp[cli]"
```{{exec}}

## Start Story server
```shell
# cd in to story server directory
cd /root/mcp-demos/mcp_sse_101
# Start story server
python story_server.py
# we can start uisng this command too
# mcp run story_server.py  
```{{exec}}

Now we can access the MCP Story server at [MCP Story Server]({{HOST1_8080}})
