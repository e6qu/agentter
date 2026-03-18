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
      "prompt": "You are a security auditor. Review code for:\n- SQL injection\n- XSS vulnerabilities\n- Authentication issues\n- Secret exposure\n\nProvide specific fixes with code examples.",
      "tools": { "read": true, "grep": true, "glob": true },
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

## Triggering Claude Code CLI from OpenCode Hooks

### Overview

OpenCode can trigger Claude Code CLI from its plugin hooks to leverage Claude's capabilities alongside OpenCode's multi-provider flexibility. Combined with **deterministic checks**, this creates powerful cross-tool automation.

### Why Trigger Claude Code from OpenCode?

| OpenCode Strength | Claude Code Strength | Combined Benefit |
|-------------------|---------------------|------------------|
| Multi-provider (75+) | Deep Claude reasoning | Use Claude for analysis, OpenCode for implementation |
| MCP ecosystem | Built-in subagents | MCP tools + Claude subagents |
| JSON configuration | Natural language UX | Structured triggers with LLM flexibility |

### Basic Pattern: OpenCode Hook → Claude Code

```javascript
// .opencode/plugins/claude-integration.js
import { execSync } from 'child_process';

export const ClaudeIntegration = async ({ client }) => {
  return {
    "session.created": async () => {
      console.info('Session started - checking if Claude review needed');

      // Deterministic check: Only run if unreviewed changes exist
      const hasChanges = await checkForUnreviewedChanges();
      if (!hasChanges) {
        console.info('No unreviewed changes - skipping Claude review');
        return;
      }

      // Trigger Claude Code for review
      try {
        const result = execSync(
          'claude -p "Review recent changes for security issues" --allow-tools "Read,Grep"',
          { encoding: 'utf8', timeout: 60000 }
        );
        console.info('Claude review completed', { result });
      } catch (error) {
        console.error('Claude review failed', { error: error.message });
      }
    }
  };
};
```

### Pattern 1: Pre-Tool Deterministic Check

```javascript
// .opencode/plugins/claude-safety-check.js
import crypto from 'crypto';
import fs from 'fs';
import { execSync } from 'child_process';
import path from 'path';

export const ClaudeSafetyCheck = async (ctx) => {
  return {
    "tool.execute.before": async (input, output) => {
      // Only check Bash tool with destructive commands
      if (input.tool !== 'Bash') return;
      if (!output.args.command.match(/rm\s+-rf|sudo|drop\s+database/i)) return;

      // Deterministic check: Hash of command + context
      const checkKey = crypto
        .createHash('sha256')
        .update(output.args.command + process.cwd())
        .digest('hex');

      const stateDir = path.join(process.cwd(), '.opencode', '.claude-checks');
      const stateFile = path.join(stateDir, `${checkKey}.approved`);

      // Check if already approved
      if (fs.existsSync(stateFile)) {
        console.info('Command pre-approved by Claude safety check');
        return;
      }

      // Run Claude Code for safety analysis
      console.warn('Destructive command detected - consulting Claude Code');

      try {
        const result = execSync(
          `claude -p "Review this command for safety: '${output.args.command}'.
          Context: CWD=${process.cwd()}, Git branch=$(git branch --show-current 2>/dev/null || echo 'N/A')

          Is this command safe? Reply with APPROVE or BLOCK: [reason]"
          --allow-tools "Read,Glob" --output /tmp/claude-safety.txt`,
          { encoding: 'utf8', timeout: 30000 }
        );

        const claudeResponse = fs.readFileSync('/tmp/claude-safety.txt', 'utf8');

        if (claudeResponse.includes('APPROVE')) {
          fs.mkdirSync(stateDir, { recursive: true });
          fs.writeFileSync(stateFile, claudeResponse);
          console.info('Claude approved destructive command');
        } else {
          const reason = claudeResponse.match(/BLOCK: (.+)/)?.[1] || 'Safety check failed';
          throw new Error(`Claude safety check BLOCKED: ${reason}`);
        }
      } catch (error) {
        if (error.message.includes('BLOCKED')) {
          throw error;
        }
        console.error('Claude safety check error', { error: error.message });
        // Fail closed - block on error
        throw new Error('Safety check could not complete - command blocked');
      }
    }
  };
};
```

Configuration in `opencode.json`:
```json
{
  "plugin": ["opencode-claude-safety-check"]
}
```

### Pattern 2: Scheduled Heartbeat with Claude

```javascript
// .opencode/plugins/claude-heartbeat.js
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

const STATE_DIR = path.join(process.cwd(), '.opencode', '.heartbeat');
const INTERVAL_MS = 30 * 60 * 1000; // 30 minutes

export const ClaudeHeartbeat = async (ctx) => {
  const runHeartbeat = async () => {
    const timestamp = Date.now();
    const lastRunFile = path.join(STATE_DIR, 'last-claude-check');

    // Deterministic time-based check
    if (fs.existsSync(lastRunFile)) {
      const lastRun = parseInt(fs.readFileSync(lastRunFile, 'utf8'));
      if (timestamp - lastRun < INTERVAL_MS) {
        return; // Too soon
      }
    }

    console.info('Running scheduled Claude Code analysis');

    try {
      // Run comprehensive analysis via Claude
      execSync(
        `claude -p "
        Analyze this codebase for:
        1. Security vulnerabilities in dependencies (check package.json, requirements.txt)
        2. Outdated dependencies (npm outdated, pip list --outdated)
        3. Code quality issues (complex functions, duplicated code)
        4. Documentation gaps

        Format: JSON with categories and findings.
        " --allow-tools "Read,Grep,Glob,Bash"
        --output ${path.join(STATE_DIR, `report-${timestamp}.json`)}`,
        { timeout: 120000 }
      );

      fs.mkdirSync(STATE_DIR, { recursive: true });
      fs.writeFileSync(lastRunFile, timestamp.toString());

      console.info('Heartbeat analysis complete');
    } catch (error) {
      console.error('Heartbeat analysis failed', { error: error.message });
    }
  };

  // Start heartbeat
  setInterval(runHeartbeat, INTERVAL_MS);

  return {
    "session.created": async () => {
      console.info('Claude heartbeat started (30min interval)');
    }
  };
};
```

### Pattern 3: Code Review on File Change

```javascript
// .opencode/plugins/claude-code-review.js
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const REVIEW_DIR = path.join(process.cwd(), '.opencode', '.code-reviews');

export const ClaudeCodeReview = async (ctx) => {
  return {
    "file.edited": async (event) => {
      const { path: filePath } = event;

      // Only review source files
      if (!filePath.match(/\.(js|ts|py|java|go|rs)$/)) return;

      // Deterministic: Check if content changed
      const content = fs.readFileSync(filePath, 'utf8');
      const contentHash = crypto.createHash('sha256').update(content).digest('hex');
      const reviewMarker = path.join(REVIEW_DIR, `${filePath.replace(/\//g, '-')}-${contentHash}.reviewed`);

      if (fs.existsSync(reviewMarker)) {
        console.debug(`Skipping review - already reviewed: ${filePath}`);
        return;
      }

      console.info(`Requesting Claude Code review for: ${filePath}`);

      try {
        execSync(
          `claude -p "
          Review this file for:
          - Security issues
          - Code quality
          - Best practices
          - Potential bugs

          File: ${filePath}

          Provide structured feedback.
          " --allow-tools "Read" --output /tmp/claude-review.txt`,
          { timeout: 60000 }
        );

        const review = fs.readFileSync('/tmp/claude-review.txt', 'utf8');

        // Store review
        fs.mkdirSync(REVIEW_DIR, { recursive: true });
        fs.writeFileSync(reviewMarker, review);

        // Log to console
        if (review.toLowerCase().includes('issue') || review.toLowerCase().includes('warning')) {
          console.warn(`Claude found issues in ${filePath}:`, { review: review.substring(0, 500) });
        } else {
          console.info(`Claude review passed for ${filePath}`);
        }
      } catch (error) {
        console.error(`Claude review failed for ${filePath}`, { error: error.message });
      }
    }
  };
};
```

### Pattern 4: Ephemeral CI Integration

```javascript
// .opencode/plugins/claude-ci.js
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

const CI_DIR = path.join(process.cwd(), '.opencode', '.ci-checks');

export const ClaudeCi = async (ctx) => {
  return {
    "session.idle": async () => {
      const commit = execSync('git rev-parse HEAD', { encoding: 'utf8' }).trim();
      const stateFile = path.join(CI_DIR, `${commit}.json`);

      // Deterministic: Check if already CI-checked
      if (fs.existsSync(stateFile)) {
        const state = JSON.parse(fs.readFileSync(stateFile, 'utf8'));
        if (state.status === 'passed') {
          console.info(`CI already passed for ${commit.substring(0, 8)}`);
          return;
        }
      }

      console.info(`Running Claude CI check for ${commit.substring(0, 8)}`);

      // Create ephemeral worktree
      const worktree = path.join(CI_DIR, 'worktrees', commit);
      execSync(`git worktree add ${worktree} ${commit} 2>/dev/null || true`);

      try {
        // Run Claude Code CI
        execSync(
          `claude --worktree ${worktree} -p "
          Run CI pipeline:
          1. Install deps
          2. Run lint
          3. Run tests
          4. Build check

          Output: PASS or FAIL with details.
          " --output /tmp/claude-ci-result.txt`,
          { timeout: 300000 }
        );

        const result = fs.readFileSync('/tmp/claude-ci-result.txt', 'utf8');
        const passed = result.includes('PASS');

        fs.mkdirSync(CI_DIR, { recursive: true });
        fs.writeFileSync(stateFile, JSON.stringify({
          commit,
          status: passed ? 'passed' : 'failed',
          timestamp: Date.now(),
          summary: result.substring(0, 1000)
        }));

        if (passed) {
          console.info(`CI passed for ${commit.substring(0, 8)}`);
        } else {
          console.error(`CI failed for ${commit.substring(0, 8)}`);
        }
      } finally {
        // Cleanup worktree
        execSync(`git worktree remove ${worktree} --force 2>/dev/null || rm -rf ${worktree}`);
      }
    }
  };
};
```

### Pattern 5: MCP + Claude Coordination

```javascript
// .opencode/plugins/mcp-claude-coordination.js
import { execSync } from 'child_process';
import fs from 'fs';

export const McpClaudeCoordination = async (ctx) => {
  return {
    "tool.execute.after": async (input, output) => {
      // Trigger Claude when MCP tool finds issues
      if (input.tool === 'security_scan' && output.result?.vulnerabilities?.length > 0) {
        console.warn('Security vulnerabilities found - consulting Claude');

        execSync(
          `claude -p "
          Security scan found vulnerabilities:
          ${JSON.stringify(output.result.vulnerabilities, null, 2)}

          Suggest fixes for each vulnerability.
          Prioritize by severity (critical, high, medium, low).
          Provide code examples where applicable.
          " --output /tmp/claude-security-advice.txt`,
          { timeout: 60000 }
        );

        const advice = fs.readFileSync('/tmp/claude-security-advice.txt', 'utf8');
        console.warn('Claude security recommendations:', { advice: advice.substring(0, 1000) });
      }
    }
  };
};
```

### Deterministic Check Strategies

```javascript
// Utility functions for deterministic checks
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';

export class DeterministicChecks {
  constructor(baseDir = '.opencode/.deterministic') {
    this.baseDir = path.join(process.cwd(), baseDir);
    fs.mkdirSync(this.baseDir, { recursive: true });
  }

  // Checksum-based: Content hasn't changed
  checksumCheck(content, namespace = 'default') {
    const hash = crypto.createHash('sha256').update(content).digest('hex');
    const marker = path.join(this.baseDir, namespace, `${hash}.checked`);

    if (fs.existsSync(marker)) {
      return { shouldRun: false, reason: 'Content already checked' };
    }

    return {
      shouldRun: true,
      markComplete: () => {
        fs.mkdirSync(path.dirname(marker), { recursive: true });
        fs.writeFileSync(marker, Date.now().toString());
      }
    };
  }

  // Time-based: Minimum interval between runs
  timeBasedCheck(intervalMs, namespace = 'default') {
    const marker = path.join(this.baseDir, 'timestamps', `${namespace}.last`);
    const now = Date.now();

    if (fs.existsSync(marker)) {
      const last = parseInt(fs.readFileSync(marker, 'utf8'));
      if (now - last < intervalMs) {
        return {
          shouldRun: false,
          reason: `Last run ${Math.floor((now - last) / 1000)}s ago (min: ${intervalMs/1000}s)`
        };
      }
    }

    return {
      shouldRun: true,
      markComplete: () => {
        fs.mkdirSync(path.dirname(marker), { recursive: true });
        fs.writeFileSync(marker, now.toString());
      }
    };
  }

  // Git-based: Check if commit already processed
  gitCommitCheck(commit = null) {
    const { execSync } = require('child_process');
    const targetCommit = commit || execSync('git rev-parse HEAD')
      .toString()
      .trim();

    const marker = path.join(this.baseDir, 'commits', `${targetCommit}.processed`);

    if (fs.existsSync(marker)) {
      return { shouldRun: false, commit: targetCommit, reason: 'Commit already processed' };
    }

    return {
      shouldRun: true,
      commit: targetCommit,
      markComplete: () => {
        fs.mkdirSync(path.dirname(marker), { recursive: true });
        fs.writeFileSync(marker, Date.now().toString());
      }
    };
  }
}
```

### Configuration Example

```json
{
  "plugin": [
    "opencode-claude-safety-check",
    "opencode-claude-heartbeat",
    "opencode-claude-code-review"
  ],
  "agent": {
    "claude-trigger": {
      "description": "Triggers Claude Code for complex analysis",
      "prompt": "You coordinate with Claude Code for deep analysis tasks. Use deterministic checks to avoid redundant processing."
    }
  }
}
```

### Best Practices

**Do:**
- Use deterministic checks to prevent redundant Claude Code calls
- Set appropriate timeouts for Claude Code invocations
- Store state in `.opencode/` (already gitignored)
- Handle errors gracefully - fail closed for safety checks
- Use `--allow-tools` to restrict Claude's capabilities
- Log all cross-tool interactions for debugging

**Don't:**
- Trigger Claude Code synchronously on every keystroke
- Store sensitive data in state files
- Allow unlimited Claude Code execution without throttling
- Forget to clean up ephemeral worktrees
- Ignore API rate limits

---

*Last Updated: March 18, 2026*
