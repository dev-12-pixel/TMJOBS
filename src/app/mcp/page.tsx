'use client';
import { useState } from 'react';
import { Layout } from '../../components/Layout';
import { Card } from '../../components/ui/Card';
import { Button } from '../../components/ui/Button';
import { Input } from '../../components/ui/Input';
import {
  Sparkles,
  MessageCircle,
  Loader2,
  Code,
  Database,
  Settings,
  Zap,
  CheckCircle,
  AlertCircle,
} from 'lucide-react';
import { supabase } from '../../lib/supabase';

export default function MCPPage() {
  const [prompt, setPrompt] = useState('');
  const [response, setResponse] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [connected, setConnected] = useState(false);
  const [activeTab, setActiveTab] = useState<'chat' | 'tools' | 'settings'>('chat');

  const mcpTools = [
    {
      name: 'get_dashboard_summary',
      description: 'Get overall dashboard metrics for all clients',
      parameters: ['date_range?', 'client_id?'],
    },
    {
      name: 'get_client_metrics',
      description: 'Get detailed metrics for a specific client',
      parameters: ['client_id', 'date_range?'],
    },
    {
      name: 'get_candidate_status',
      description: 'Get tracking status for a specific candidate',
      parameters: ['candidate_id'],
    },
    {
      name: 'get_earnings',
      description: 'Get referral earnings breakdown',
      parameters: ['period?', 'client_id?'],
    },
    {
      name: 'add_candidate',
      description: 'Add a new candidate to the system',
      parameters: ['client_id', 'job_profile_id', 'first_name', 'last_name', 'email'],
    },
    {
      name: 'update_referral_status',
      description: 'Update referral status (applied, signed_up, hired, not_hired)',
      parameters: ['referral_id', 'status'],
    },
    {
      name: 'get_earnings_by_profile',
      description: 'Get earnings breakdown per job profile',
      parameters: ['client_id', 'profile_id?'],
    },
    {
      name: 'get_hired_candidates',
      description: 'Get all hired candidates with details',
      parameters: ['client_id', 'date_range?'],
    },
  ];

  const handleSendPrompt = async () => {
    if (!prompt.trim()) return;
    setLoading(true);
    setResponse(null);

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) {
        setResponse('Please sign in to use the MCP connector.');
        setLoading(false);
        return;
      }

      const { data, error } = await supabase.functions.invoke('mcp-process', {
        body: { prompt, userId: session.user.id },
      });

      if (error) throw error;
      setResponse(data?.response || 'No response from MCP connector.');
    } catch (error: unknown) {
      const message = error instanceof Error ? error.message : 'An error occurred';
      setResponse(`Error: ${message}`);
    } finally {
      setLoading(false);
    }
  };

  const handleToolCall = async (toolName: string) => {
    setPrompt(`Call ${toolName} tool`);
    setLoading(true);
    setResponse(null);

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) {
        setResponse('Please sign in.');
        setLoading(false);
        return;
      }

      const { data, error } = await supabase.functions.invoke('mcp-tool', {
        body: { tool: toolName, userId: session.user.id },
      });

      if (error) throw error;
      setResponse(JSON.stringify(data, null, 2));
    } catch (error: unknown) {
      const message = error instanceof Error ? error.message : 'Error';
      setResponse(`Error: ${message}`);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Layout>
      <div className="space-y-6 animate-fade-in">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 bg-purple-600 rounded-xl flex items-center justify-center">
              <Sparkles className="w-6 h-6 text-white" />
            </div>
            <div>
              <h2 className="text-3xl font-bold text-gray-800">MCP Connector</h2>
              <p className="text-gray-500">Connect with Claude AI for instant insights</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            {connected ? (
              <span className="flex items-center gap-2 text-green-600 text-sm">
                <CheckCircle className="w-4 h-4" />
                Connected
              </span>
            ) : (
              <Button onClick={() => setConnected(true)}>
                Connect
              </Button>
            )}
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <div className="lg:col-span-2">
            <Card title="Claude MCP Chat" className="h-[600px] flex flex-col">
              <div className="flex-1 overflow-y-auto space-y-4 p-4">
                {response ? (
                  <div className="bg-blue-50 rounded-lg p-4">
                    <div className="flex items-center gap-2 mb-2">
                      <Sparkles className="w-4 h-4 text-blue-600" />
                      <span className="font-medium text-blue-800">Claude</span>
                    </div>
                    <pre className="text-sm text-gray-700 whitespace-pre-wrap">{response}</pre>
                  </div>
                ) : (
                  <div className="text-center text-gray-400 py-12">
                    <MessageCircle className="w-12 h-12 mx-auto mb-3 opacity-30" />
                    <p>Ask Claude anything about your referrals</p>
                    <p className="text-xs mt-1">Or select a tool below</p>
                  </div>
                )}
              </div>

              <div className="border-t border-gray-200 p-4">
                <div className="flex gap-2">
                  <Input
                    placeholder="Ask Claude about your dashboard..."
                    value={prompt}
                    onChange={(e) => setPrompt(e.target.value)}
                    onKeyDown={(e) => e.key === 'Enter' && handleSendPrompt()}
                    disabled={loading}
                  />
                  <Button
                    onClick={handleSendPrompt}
                    disabled={loading || !prompt.trim()}
                  >
                    {loading ? (
                      <Loader2 className="w-4 h-4 animate-spin" />
                    ) : (
                      'Send'
                    )}
                  </Button>
                </div>
              </div>
            </Card>
          </div>

          <div className="space-y-4">
            <Card title="Available Tools">
              <div className="space-y-2">
                {mcpTools.map((tool) => (
                  <button
                    key={tool.name}
                    onClick={() => handleToolCall(tool.name)}
                    disabled={loading || !connected}
                    className="w-full text-left p-3 rounded-lg border border-gray-200 hover:border-primary-300 hover:bg-primary-50 transition-colors disabled:opacity-50"
                  >
                    <div className="flex items-center gap-2">
                      <Code className="w-4 h-4 text-gray-500" />
                      <span className="font-medium text-sm text-gray-800">{tool.name}</span>
                    </div>
                    <p className="text-xs text-gray-500 mt-1">{tool.description}</p>
                  </button>
                ))}
              </div>
            </Card>

            <Card title="MCP Status">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="text-sm text-gray-600">Connection</span>
                  {connected ? (
                    <span className="badge-success">Connected</span>
                  ) : (
                    <span className="badge-warning">Disconnected</span>
                  )}
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm text-gray-600">Last Sync</span>
                  <span className="text-sm text-gray-800">2 min ago</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm text-gray-600">Models Available</span>
                  <span className="text-sm text-gray-800">Claude 3.5 Sonnet</span>
                </div>
              </div>
            </Card>
          </div>
        </div>
      </div>
    </Layout>
  );
}
