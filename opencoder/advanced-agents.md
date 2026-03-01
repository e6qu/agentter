# OpenCode Advanced Agent Patterns

*Ephemeral agents, heartbeat monitoring, and specialized agent configurations*

---

## Overview

Beyond standard agents, OpenCode supports advanced agent patterns for specific use cases:

| Pattern | Use Case | Duration |
|---------|----------|----------|
| **Ephemeral Agents** | Safe experimentation, isolated testing | Temporary |
| **Heartbeat Agents** | Monitoring, periodic checks | Long-running |
| **Custom Agents** | Specialized workflows | Persistent |
| **Addon Agents** | Extended functionality | As needed |

---

## Ephemeral Agents

### What are Ephemeral Agents?

Ephemeral agents are temporary, isolated agent instances that:
- Run in a clean environment (fresh worktree/session)
- Cannot affect the main codebase
- Auto-destroy after task completion
- Perfect for experimentation and testing

### Use Cases

| Scenario | Ephemeral Agent Benefit |
|----------|------------------------|
| Testing dangerous commands | Isolated from production |
| Experimenting with new approaches | Easy cleanup if it fails |
| Parallel exploration | Multiple agents, no conflicts |
| Security-sensitive operations | Contained environment |

### Implementation in OpenCode

#### Method 1: Session Forking

```bash
# Create ephemeral session
opencode run --fork "Experiment with refactoring approach A"

# In another terminal, create another ephemeral session
opencode run --fork "Experiment with refactoring approach B"
```

Each fork gets:
- Isolated git worktree
- Independent context
- No impact on main session

#### Method 2: Temporary Worktree

```bash
# Create ephemeral worktree
git worktree add /tmp/ephemeral-$(date +%s)
cd /tmp/ephemeral-$(date +%s)

# Run OpenCode in worktree
opencode run "Test changes safely"

# Cleanup when done
git worktree remove /tmp/ephemeral-$(date +%s)
```

#### Method 3: Server Isolation

```bash
# Start isolated server
opencode serve --port $RANDOM

# Attach ephemeral client
opencode attach http://localhost:$PORT --session ephemeral-test
```

### Configuration for Ephemeral Agents

```json
// opencode.json - Ephemeral agent configuration
{
  "agent": {
    "ephemeral": {
      "mode": "subagent",
      "description": "Temporary isolated agent for safe experimentation",
      "model": "anthropic/claude-haiku-4-20250514",
      "temperature": 0.7,
      "tools": {
        "write": true,
        "edit": true,
        "bash": true
      },
      "steps": 20,
      "prompt": "You are an ephemeral agent. Your work is temporary and isolated.\n\nGuidelines:\n1. Experiment freely - nothing affects the main codebase\n2. Try bold approaches\n3. Document what you learn\n4. Report findings back to parent agent\n\nNote: Your session will be destroyed after completion."
    }
  }
}
```

### Ephemeral Agent Workflow

```
Parent Agent
    │
    ├── Spawns Ephemeral Agent A (worktree A)
    │       ├── Experiments safely
    │       └── Reports findings
    │
    ├── Spawns Ephemeral Agent B (worktree B)
    │       ├── Experiments safely
    │       └── Reports findings
    │
    └── Compares results
            └── Decides approach
```

---

## Heartbeat Agents

### What are Heartbeat Agents?

Heartbeat agents are long-running agents that:
- Execute periodically (e.g., every 30 minutes)
- Monitor system health or status
- Report findings or take actions
- Stay alive until explicitly stopped

### Use Cases

| Scenario | Heartbeat Agent Role |
|----------|---------------------|
| CI/CD monitoring | Check build status periodically |
| Dependency updates | Check for outdated packages |
| Security scanning | Periodic vulnerability checks |
| Documentation sync | Keep docs in sync with code |
| Test running | Periodic test execution |

### Implementation in OpenCode

#### Using Plugins

```javascript
// .opencode/plugins/heartbeat.js
export const HeartbeatPlugin = async ({ client, $ }) => {
  const INTERVAL = 30 * 60 * 1000; // 30 minutes
  
  const runHeartbeat = async () => {
    // Check test status
    const result = await $`npm test`.nothrow();
    
    if (result.exitCode !== 0) {
      await client.app.log({
        body: {
          service: "heartbeat",
          level: "warn",
          message: "Tests failing",
          timestamp: new Date().toISOString()
        }
      });
    }
  };
  
  // Initial run
  await runHeartbeat();
  
  // Schedule periodic runs
  setInterval(runHeartbeat, INTERVAL);
  
  return {};
};
```

#### Using Systemd/User Services

```bash
# ~/.config/systemd/user/opencode-heartbeat.service
[Unit]
Description=OpenCode Heartbeat Agent

[Service]
Type=simple
ExecStart=/usr/local/bin/opencode run --attach http://localhost:4096 "Check system status and report"
Restart=always
RestartSec=1800  # 30 minutes

[Install]
WantedBy=default.target
```

#### Using Cron

```bash
# Crontab entry for heartbeat
echo "*/30 * * * * cd /project && /usr/local/bin/opencode run 'Run health checks'" | crontab -
```

### Heartbeat Agent Configuration

```json
// opencode.json - Heartbeat agent
{
  "agent": {
    "heartbeat": {
      "mode": "primary",
      "description": "Periodic health check and monitoring agent",
      "model": "anthropic/claude-haiku-4-20250514",
      "temperature": 0.1,
      "tools": {
        "read": true,
        "bash": true,
        "grep": true
      },
      "prompt": "You are a heartbeat monitoring agent. Run every 30 minutes.\n\nTasks:\n1. Check test status\n2. Verify no security vulnerabilities\n3. Check documentation is up to date\n4. Report any issues found\n\nBe concise. Only report problems, not successes."
    }
  }
}
```

### Heartbeat Monitoring Dashboard

```javascript
// .opencode/plugins/heartbeat-dashboard.js
export const HeartbeatDashboard = async ({ client }) => {
  const checks = [];
  
  return {
    "session.idle": async () => {
      // Log heartbeat check
      checks.push({
        timestamp: Date.now(),
        status: 'completed'
      });
      
      // Keep only last 24 hours
      const dayAgo = Date.now() - 24 * 60 * 60 * 1000;
      const recentChecks = checks.filter(c => c.timestamp > dayAgo);
      
      await client.app.log({
        body: {
          service: "heartbeat-stats",
          checks24h: recentChecks.length,
          lastCheck: new Date().toISOString()
        }
      });
    }
  };
};
```

---

## Custom Agent Patterns

### Pattern 1: Task-Specific Agent

```json
{
  "agent": {
    "security-auditor": {
      "mode": "subagent",
      "description": "Security-focused code review agent",
      "system": "You are a security auditor. Review code for:\n- SQL injection\n- XSS vulnerabilities\n- Authentication issues\n- Secret exposure\n\nProvide specific fixes with code examples.",
      "allowed_tools": ["Read", "Grep", "Glob"],
      "model": "anthropic/claude-sonnet-4-20250514"
    }
  }
}
```

### Pattern 2: Multi-Model Agent

```json
{
  "agent": {
    "planning": {
      "mode": "primary",
      "model": "anthropic/claude-opus-4-20250514",
      "temperature": 0.1,
      "description": "Deep reasoning for complex planning"
    },
    "implementation": {
      "mode": "primary",
      "model": "anthropic/claude-sonnet-4-20250514",
      "temperature": 0.3,
      "description": "Fast implementation of planned tasks"
    }
  }
}
```

### Pattern 3: Context-Aware Agent

```markdown
---
name: context-aware
description: Agent that adapts based on project context
mode: primary
---

You are a context-aware agent.

If this is a React project:
- Use functional components
- Prefer hooks over class components
- Follow React best practices

If this is a Node.js project:
- Use async/await
- Follow Express patterns
- Use proper error handling

Adapt your approach based on the codebase structure you discover.
```

---

## Addons and Extensions

### MCP Server Addons

```json
{
  "mcp": {
    "security-scanner": {
      "command": "npx",
      "args": ["-y", "@company/security-mcp-server"]
    },
    "custom-linter": {
      "command": "node",
      "args": ["./scripts/custom-linter-mcp.js"]
    }
  }
}
```

### Plugin Addons

```javascript
// .opencode/plugins/custom-addon.js
export const CustomAddon = async (ctx) => {
  // Add custom functionality
  return {
    // Hooks
    "tool.execute.before": async (input, output) => {
      // Custom validation
    },
    
    // Custom tools
    tool: {
      customTool: {
        description: "Custom addon tool",
        execute: async (args) => {
          return "Custom result";
        }
      }
    }
  };
};
```

### Skill Addons

```markdown
---
name: custom-workflow
description: Custom project workflow
---

## Custom Workflow Steps

1. Validate environment
2. Run custom checks
3. Execute workflow
4. Verify results
5. Report status

This skill adds custom workflow capabilities to your agent.
```

---

## Agent Lifecycle Management

### Starting Agents

```bash
# Start ephemeral agent
opencode run --session ephemeral-$(uuidgen) "Task"

# Start heartbeat agent
opencode run --session heartbeat --continue "Monitoring task"

# Start custom agent
opencode run --agent security-auditor "Audit codebase"
```

### Monitoring Agents

```bash
# List active sessions
opencode session list

# Monitor specific agent
opencode session status <session-id>
```

### Stopping Agents

```bash
# Stop specific session
opencode session stop <session-id>

# Cleanup ephemeral sessions
opencode session cleanup --ephemeral
```

---

## Best Practices

### Ephemeral Agents
- Always clean up after use
- Use for experimentation only
- Don't store state in ephemeral agents
- Fork before dangerous operations

### Heartbeat Agents
- Keep heartbeat logic simple
- Log failures prominently
- Don't block on long operations
- Implement backoff for failures

### Custom Agents
- Clear, specific descriptions
- Limit tools to what's needed
- Document expected inputs/outputs
- Version your agent configurations

---

*Last Updated: March 1, 2026*
