
# Test MCP Story Server 

## Start a simple ping server first

⚠️ <span style="color:red">Run following commands in new Tab</span>

<details>
<summary>Read more</summary>
![New Tab](https://i.ibb.co/b59kdLmy/new-tab.gif)

</details>

### Ping Server

Run below command to start a simple ping server

```
cd /root/mcp-demos/mcp_sse_101
python mcp_client_ping.py \
--url {{TRAFFIC_HOST1_8080}}/sse
```{{exec}}

## Start Intractive MCP Client 

Now, let's start the MCP client to interact with the story server.

```
cd /root/mcp-demos/mcp_sse_101
python mcp_client.py \
--url {{TRAFFIC_HOST1_8080}}/sse
```{{exec}}

### Sample Output

<details>
<summary>Click to see output</summary>

![MCP Client](https://i.ibb.co/4RGPGzLT/mcp-client.gif)

<p><img src="https://i.ibb.co/4RGPGzLT/mcp-client.gif" alt="MCP Client"></p>

</details>