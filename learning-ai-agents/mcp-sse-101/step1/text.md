
Install MCP CLI and start Story server (MCP Server) using Python


# Clone sample repo

Clone MCP github repo :

`cd ~ && git clone https://github.com/ishswar/mcp-demos.git`{{exec}}

All the code is in this repo

# Introduction to MCP 

The Model Context Protocol (MCP) is a lightweight, open standard that allows AI models to interact with external tools or data sources in real time. It enables models to fetch context dynamically, making them more capable and responsive.

MCP supports multiple transport methods, including:

- **Standard Input/Output (Stdio):** Best suited for local communication between tools running on the same machine.
- **Server-Sent Events (SSE):** Ideal for remote communication, allowing servers to stream real-time data to clients over HTTP.

In this GitHub repository, the provided sample called the "storytelling server" demonstrates an MCP server using SSE to broadcast characters and narrative prompts in real time. Let’s get started by installing and running the server.

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
# we can start using this command too
# mcp run story_server.py  
```{{exec}}

### Sample output 

Once you run above server you should see below output 

```shell
MCP Story Server is running using SSE transport ...
INFO:     Started server process [2996]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8080 (Press CTRL+C to quit)
```

Now we can access the MCP Story server at [MCP Story Server]({{TRAFFIC_HOST1_8080}}/sse)

**Right click on above link and copy URL as you will need this in next steps.**

## Optional 

If you click on above URL you can confirm that server is running if you look output like this (wait for few seconds)

```shell
event: endpoint
data: /messages/?session_id=fcd0bdb6dbf249a693c659ef47866c9a

: ping - 2025-03-29 17:35:58.453327+00:00

: ping - 2025-03-29 17:36:13.454774+00:00

: ping - 2025-03-29 17:36:28.456207+00:00

: ping - 2025-03-29 17:36:43.457875+00:00

: ping - 2025-03-29 17:36:58.459073+00:00
```