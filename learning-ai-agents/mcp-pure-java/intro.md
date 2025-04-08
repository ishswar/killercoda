## Introduction

Welcome to this Killercoda scenario on building and running a **pure Java MCP Server** using the [Model Context Protocol (MCP) Java SDK](https://modelcontextprotocol.io/sdk/java/mcp-overview). This server functions as a **Book MCP Server**, providing a rich storytelling experience with a collection of **characters, backstories, and superpowers**.

In this tutorial, we will:
- **Build and compile** a Java application that serves as the MCP server.
- **Run** the server to expose MCP-compatible tools and prompts.
- **Test** it using an existing Python MCP client.
- Later, we’ll also test the server with a **web-based MCP client** and the **Claud desktop** to ensure seamless integration across environments.

By the end of this scenario, you'll have a functional MCP server capable of responding to prompts and providing creative storytelling capabilities through well-defined tools.

---

### Prerequisites

- Basic understanding of Java.
- Familiarity with HTTP APIs and JSON.
- (Optional) Exposure to the MCP protocol and Python scripting.

---

### Scenario Outline

1. **Cloning the GitHub Repository** – Fetch the Java MCP server codebase.
2. **Installing Java & Maven** – Set up your environment to compile the Java project.
3. **Building the Java Application** – Compile the MCP server and generate a runnable JAR.
4. **Running the MCP Server** – Start the Java MCP server and expose endpoints.
5. **Testing with Python MCP Client** – Use the existing Python client to interact with the server.
6. **Using Web-based MCP Client** – Test the server from a browser-based client.
7. **Claud Desktop Integration** – Connect and test from Claud desktop as an MCP client.

---

**Note:** This scenario focuses on using the **pure Java MCP SDK** without incorporating Spring AI. 