
# Test MCP Story Server 

## Start a simple ping server first

⚠️ <span style="color:red">Run following commands in new Tab</span>

```
cd /root/mcp-demos/mcp_sse_101
python mcp_client_ping.py \
-url {{TRAFFIC_HOST1_8080}}/sse
```{{exec}}

## Start Intractive MCP Client 

```
cd /root/mcp-demos/mcp_sse_101
python mcp_client.py \
-url {{TRAFFIC_HOST1_8080}}/sse
```{{exec}}
