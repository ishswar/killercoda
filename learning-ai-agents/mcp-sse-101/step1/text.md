
Install MCP CLI and start Story server (MCP Server) using Python


# Clone sample repo

Clone MCP github repo :

`cd ~ && git clone https://github.com/ishswar/mcp-demos.git`{{exec}}

All the code is in this repo

# Introduction to MCP 

The Model Context Protocol (MCP) is an open standard designed to facilitate seamless integration between AI applications and external data sources or tools. It enables AI models to dynamically access relevant context, enhancing their performance and versatility. citeturn0search3

MCP supports various communication transports, including:

- **Standard Input/Output (Stdio):** Ideal for local integrations, utilizing standard input and output streams for communication.

- **Server-Sent Events (SSE):** Suited for remote interactions, allowing servers to push real-time updates to clients over HTTP. citeturn0search2

In this tutorial, we'll focus on the "storytelling server" sample provided in the GitHub repository, which employs SSE for communication. This approach ensures that the MCP server is accessible to clients globally, facilitating real-time data streaming. Let's begin by installing and configuring this server. 

## Install python MCP Python Module

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
