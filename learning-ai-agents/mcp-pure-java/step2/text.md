
# Test MCP story-server 

In this step will walk you through testing the MCP Story Server.  
You'll start by launching a lightweight ping server and then run the interactive MCP client to explore tools and prompts.

---

## Start a simple ping server first

Before launching the main client, we’ll start a **simple ping server** in a new terminal tab to simulate server-side activity.

⚠️ <span style="color:red">Run following commands in new Tab</span>

<details>
<summary>Steps to Open new Tab</summary>

![New Tab](https://i.ibb.co/b59kdLmy/new-tab.gif)

</details>


## Start Intractive MCP Client 

Now, let's start the Python MCP client to interact with the story server.

```
cd /root/mcp-demos/mcp_sse_101
python mcp_client.py \
--url {{TRAFFIC_HOST1_8282}}/sse
```{{exec}}

### Sample Output

<details>
<summary>Click to see output</summary>

![MCP Client](https://i.ibb.co/4RGPGzLT/mcp-client.gif)

</details>