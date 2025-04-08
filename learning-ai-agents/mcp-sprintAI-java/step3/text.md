### 🛠️ Steps to Register an MCP SSE Server

1. **Go to the Site**  
   Open [https://open-mcp-client.vercel.app/](https://open-mcp-client.vercel.app/) in your browser.

2. **Click on “+ Add Server”**  
   On the top right of the dashboard, click the **“+ Add Server”** button.

3. **Select Server Type**  
   In the popup, choose the server type as **“SSE Server”** (if it gives you options between Studio, SSE, etc.).

4. **Enter Server Details**  
   Fill in the required fields:
   - **Name**: Any name you want to give your server (e.g., `My Java SSE Server`)
   - **Endpoint URL**: Paste the public URL where your Spring AI MCP SSE server is running (e.g., `{{TRAFFIC_HOST1_8081}}/sse` or your tunnel/exposed URL if using `ngrok` or `localhost.run`)
   - Optionally add tags or notes if the UI supports it.

5. **Click “Save” or “Add”**  
   After filling in the info, confirm by clicking **“Save”** or **“Add”**.

6. **Verify Server Registration**  
   - Your server will now appear in the **Server List** under “SSE Servers”.
   - You should see metrics like tool count or endpoint status populate if the server is up.

7. **Test the Tools**  
   Once the server is connected, use the **chat or prompt interface on the right** (as seen in the GIF) to issue a prompt like:  
   ```
   Using tools, build a story about the Three Musketeers
   ```

---

### ✅ Tips

- If your server is local, use a tunneling service like [`ngrok`](https://ngrok.com/), [`localhost.run`](https://localhost.run), or [`cloudflared`](https://developers.cloudflare.com/cloudflared/) to expose it.
- Make sure your SSE server endpoint returns valid MCP-compliant metadata when queried by the client.

### Demo 

Below animated gif shows you above steps 

![MCP Client](https://i.ibb.co/GQFMBVzV/2025-04-08-08-23-34-1.gif)