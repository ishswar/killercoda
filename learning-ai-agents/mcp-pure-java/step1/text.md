
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


## Build Spring AI MCP Server 

```shell
# cd in to story server directory
cd /root/mcp-demos/mcp-server-story
# Maven clean and install
mvn clean install
```{{exec}}

## Start the server

```shell
# Start Java MCP Server
java -jar java -jar target/mcp-server-story.jar
```{{exec}}

### Sample output 

Once you run above server you should see below output 

```shell
2025-04-08 19:59:13.027 [main] DEBUG reactor.util.Loggers - Using Slf4j logging framework
2025-04-08 19:59:13.039 [main] DEBUG i.m.server.McpAsyncServer - Added prompt handler: get_characters
2025-04-08 19:59:13.041 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.055 [main] DEBUG i.m.server.McpAsyncServer - Added prompt handler: get_backstory
2025-04-08 19:59:13.056 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.057 [main] DEBUG i.m.server.McpAsyncServer - Added prompt handler: get_superpower
2025-04-08 19:59:13.058 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.060 [main] DEBUG i.m.server.McpAsyncServer - Added prompt handler: save_story
2025-04-08 19:59:13.060 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.062 [main] DEBUG i.m.server.McpAsyncServer - Added prompt handler: get_story
2025-04-08 19:59:13.063 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.322 [main] DEBUG i.m.server.McpAsyncServer - Added tool handler: list_characters
2025-04-08 19:59:13.323 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.328 [main] DEBUG i.m.server.McpAsyncServer - Added tool handler: get_backstory
2025-04-08 19:59:13.329 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.332 [main] DEBUG i.m.server.McpAsyncServer - Added tool handler: get_superpower
2025-04-08 19:59:13.333 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.335 [main] DEBUG i.m.server.McpAsyncServer - Added tool handler: save_story
2025-04-08 19:59:13.335 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:13.340 [main] DEBUG i.m.server.McpAsyncServer - Added tool handler: get_story
2025-04-08 19:59:13.342 [main] DEBUG i.m.s.t.HttpServletSseServerTransportProvider - No active sessions to broadcast message to
2025-04-08 19:59:14.028 [main] INFO  org.story.builder.SseServer - Jetty HTTP server started on http://0.0.0.0:8282
```

Now we can access the MCP Story server at [MCP Story Server]({{TRAFFIC_HOST1_8282}}/sse)

**Right click on above link and copy URL as you will need this in next steps.**

## Optional 

If you click on above URL you can confirm that server is running if you look output like this (wait for few seconds)

```shell
event: endpoint
data: /message?sessionId=51b3cd6b-5145-4e40-b463-75ff00e65fb6
```