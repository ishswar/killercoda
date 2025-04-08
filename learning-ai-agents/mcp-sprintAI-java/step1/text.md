
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
cd /root/mcp-demos/mcp_java
# Maven clean and install
mvn clean install
```{{exec}}

## Start the server

```shell
# Start Java MCP Server
java -jar target/story-builder-server-0.0.1-SNAPSHOT.jar
```{{exec}}

### Sample output 

Once you run above server you should see below output 

```shell
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/

 :: Spring Boot ::                (v3.4.4)

2025-04-08T06:52:11.740Z  INFO 4244 --- [story-builder-server] [           main] s.s.StoryBuilderServerApplication        : Starting StoryBuilderServerApplication v0.0.1-SNAPSHOT using Java 24 with PID 4244 (/root/mcp-demos/mcp_java/target/story-builder-server-0.0.1-SNAPSHOT.jar started by root in /root/mcp-demos/mcp_java)
2025-04-08T06:52:11.745Z  INFO 4244 --- [story-builder-server] [           main] s.s.StoryBuilderServerApplication        : No active profile set, falling back to 1 default profile: "default"
2025-04-08T06:52:14.220Z  INFO 4244 --- [story-builder-server] [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port 8081 (http)
2025-04-08T06:52:14.259Z  INFO 4244 --- [story-builder-server] [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2025-04-08T06:52:14.260Z  INFO 4244 --- [story-builder-server] [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/10.1.39]
2025-04-08T06:52:14.547Z  INFO 4244 --- [story-builder-server] [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2025-04-08T06:52:14.551Z  INFO 4244 --- [story-builder-server] [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 2685 ms
2025-04-08T06:52:16.456Z  INFO 4244 --- [story-builder-server] [           main] o.s.a.a.m.s.MpcServerAutoConfiguration   : Registered tools6 notification: true
2025-04-08T06:52:16.461Z  INFO 4244 --- [story-builder-server] [           main] o.s.a.a.m.s.MpcServerAutoConfiguration   : Registered prompts1 notification: true
2025-04-08T06:52:16.651Z  INFO 4244 --- [story-builder-server] [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 8081 (http) with context path '/'
2025-04-08T06:52:16.686Z  INFO 4244 --- [story-builder-server] [           main] s.s.StoryBuilderServerApplication        : Started StoryBuilderServerApplication in 6.199 seconds (process running for 7.416)
2025-04-08T06:52:40.835Z  INFO 4244 --- [story-builder-server] [nio-8081-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
2025-04-08T06:52:40.837Z  INFO 4244 --- [story-builder-server] [nio-8081-exec-1] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
2025-04-08T06:52:40.839Z  INFO 4244 --- [story-builder-server] [nio-8081-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 2 ms
```

Now we can access the MCP Story server at [MCP Story Server]({{TRAFFIC_HOST1_8081}}/sse)

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