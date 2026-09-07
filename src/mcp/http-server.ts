import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { StreamableHTTPServerTransport } from '@modelcontextprotocol/sdk/server/streamableHttp.js';
import { createMcpExpressApp } from '@modelcontextprotocol/sdk/server/express.js';
import { z } from 'zod';
import type { Request, Response } from 'express';
import { createMcpSupabaseClient, TOOL_DEFINITIONS, callTool } from './tools.js';

// Remote (HTTP) transport for the same tools src/mcp/server.ts exposes over
// stdio - this is what a hosted client like ChatGPT needs, since it can't
// spawn a local stdio process. Meant to run locally and be exposed via a
// tunnel (ngrok); every request must carry the bearer token below, since
// this becomes a public URL serving candidate/bonus data.

const API_KEY = process.env.MCP_API_KEY;
if (!API_KEY) {
  console.error('MCP_API_KEY is not set in the environment - refusing to start an unauthenticated public MCP server.');
  process.exit(1);
}

const supabase = createMcpSupabaseClient();

function buildServer() {
  const server = new McpServer({ name: 'tmjobs-mcp', version: '2.0.0' });
  for (const tool of TOOL_DEFINITIONS) {
    const shape: Record<string, z.ZodTypeAny> = {};
    const props = (tool.inputSchema as { properties?: Record<string, unknown>; required?: string[] }).properties || {};
    const required = new Set((tool.inputSchema as { required?: string[] }).required || []);
    for (const key of Object.keys(props)) {
      shape[key] = required.has(key) ? z.string() : z.string().optional();
    }
    server.registerTool(
      tool.name,
      { description: tool.description, inputSchema: shape },
      async (args: Record<string, string>) => {
        const result = await callTool(supabase, tool.name, args);
        return { content: [{ type: 'text', text: JSON.stringify(result, null, 2) }] };
      }
    );
  }
  return server;
}

const app = createMcpExpressApp({ host: '0.0.0.0' });

app.use((req: Request, res: Response, next: () => void) => {
  const auth = req.headers.authorization;
  if (auth !== `Bearer ${API_KEY}`) {
    res.status(401).json({ jsonrpc: '2.0', error: { code: -32001, message: 'Unauthorized' }, id: null });
    return;
  }
  next();
});

app.post('/mcp', async (req: Request, res: Response) => {
  try {
    const server = buildServer();
    const transport = new StreamableHTTPServerTransport({ sessionIdGenerator: undefined });
    await server.connect(transport);
    await transport.handleRequest(req, res, req.body);
    res.on('close', () => {
      transport.close();
      server.close();
    });
  } catch (error) {
    console.error('Error handling MCP request:', error);
    if (!res.headersSent) {
      res.status(500).json({ jsonrpc: '2.0', error: { code: -32603, message: 'Internal server error' }, id: null });
    }
  }
});

app.get('/mcp', (_req: Request, res: Response) => {
  res.status(405).json({ jsonrpc: '2.0', error: { code: -32000, message: 'Method not allowed' }, id: null });
});

const PORT = process.env.MCP_PORT ? parseInt(process.env.MCP_PORT, 10) : 3333;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`TMJOBS MCP HTTP server listening on http://localhost:${PORT}/mcp`);
  console.log('Tunnel it with: ngrok http ' + PORT);
});
