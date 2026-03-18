# OpenCode Setup Tutorial

*Reference guide based on official documentation and source code*

---

## Table of Contents

1. [Installation](#installation)
2. [Project Structure](#project-structure)
3. [Credential Management](#credential-management)
4. [Proxy Configuration](#proxy-configuration)
5. [Skills](#skills)
6. [Custom Agents](#custom-agents)
7. [Heartbeat Agents](#heartbeat-agents)
8. [Plugins](#plugins)
9. [Sandboxing](#sandboxing)
10. [Deterministic Checks](#deterministic-checks)

---

## Installation

### Prerequisites

- Node.js 18+ (verified with `node --version`)
- npm 8+ or compatible package manager

### Installation

```bash
# Via npm
npm install -g opencode

# Verify installation
opencode --version
```

### Multi-Provider Configuration

```bash
# Add providers
opencode provider add anthropic --api-key $ANTHROPIC_API_KEY
opencode provider add openai --api-key $OPENAI_API_KEY

# List configured providers
opencode provider list

# Set default
opencode provider default anthropic
```

### Project Initialization

```bash
cd /path/to/project
opencode init

# Creates directory structure:
# .opencode/
# ├── opencode.json
# ├── agents/
# ├── skills/
# └── plugins/
```

---

## Project Structure

### Directory Layout

```
project/
├── .opencode/
│   ├── opencode.json           # Main configuration
│   ├── opencode.local.json     # Local overrides (should be gitignored)
│   ├── AGENTS.md               # Project instructions
│   ├── agents/                 # Agent definitions
│   ├── skills/                 # SKILL.md files
│   ├── plugins/                # Plugin scripts
│   │   └── lib/                # Shared libraries
│   └── sandbox/                # Sandbox configurations
└── .gitignore
```

### Gitignore Configuration

```gitignore
# OpenCode local settings
.opencode/opencode.local.json
.opencode/.credentials/
.opencode/.logs/
.opencode/.cache/

# Generated state
.opencode/.heartbeat/
.opencode/.deterministic/
```

---

## Credential Management

### Environment Variables

```bash
# Shell configuration
export ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}"
export OPENAI_API_KEY="${OPENAI_API_KEY}"
export GITHUB_TOKEN="${GITHUB_TOKEN}"
```

### Local Configuration

```json
// .opencode/opencode.local.json
{
  "providers": {
    "anthropic": {
      "apiKey": "${ANTHROPIC_API_KEY}"
    }
  },
  "env": {
    "DATABASE_URL": "${DATABASE_URL}"
  }
}
```

### Credential Guard Plugin

```javascript
// .opencode/plugins/credential-guard.js
export const CredentialGuard = async (ctx) => {
  // Known credential patterns
  const patterns = [
    { regex: /sk-[a-zA-Z0-9]{48}/, name: 'API key' },
    { regex: /AKIA[0-9A-Z]{16}/, name: 'AWS key' },
    { regex: /gh[pousr]_[A-Za-z0-9_]{36}/, name: 'GitHub token' }
  ];

  return {
    "file.edited": async (event) => {
      const { content, path } = event;

      for (const { regex, name } of patterns) {
        if (regex.test(content)) {
          console.error(`Potential ${name} pattern in ${path}`);
          throw new Error('Credential pattern detected');
        }
      }
    }
  };
};
```

---

## Proxy Configuration

### Environment Variables

```bash
export HTTP_PROXY="http://proxy.example.com:8080"
export HTTPS_PROXY="http://proxy.example.com:8080"
export NO_PROXY="localhost,127.0.0.1"
```

### Per-Provider Configuration

```json
{
  "providers": {
    "anthropic": {
      "apiKey": "...",
      "proxy": {
        "url": "http://proxy.example.com:8080"
      }
    }
  }
}
```

---

## Skills

### Skill Format

```markdown
---
name: skill-name
description: Description of function
tools: [Read, Edit, Bash]
metadata:
  category: development
---

## Purpose

What this skill does.

## Steps

1. Step one
2. Step two
```

### Example: Refactoring Skill

```markdown
---
name: refactoring
description: Code refactoring workflow
tools: [Read, Edit, Grep, Bash]
---

## Prerequisites

- Tests exist
- Git working directory clean

## Process

1. Run existing tests
2. Make incremental changes
3. Run tests after each change
4. Commit changes
```

---

## Custom Agents

### Agent Configuration

```json
{
  "name": "agent-name",
  "description": "Agent function",
  "prompt": "System prompt",
  "tools": ["Read", "Edit"],
  "provider": "anthropic",
  "model": "claude-sonnet-4-20250514"
}
```

### Example Agents

```json
// .opencode/agents/code-reviewer.json
{
  "name": "code-reviewer",
  "description": "Code quality review",
  "prompt": "You review code for correctness, readability, and test coverage.",
  "tools": ["Read", "Grep"],
  "provider": "anthropic"
}
```

```json
// .opencode/agents/unstuck-monitor.json
{
  "name": "unstuck-monitor",
  "description": "Detects stuck states",
  "prompt": "You detect when implementation is stuck and suggest alternatives.",
  "tools": ["Read", "Bash"]
}
```

---

## Heartbeat Agents

### Unstuck Detection Plugin

```javascript
// .opencode/plugins/unstuck-detector.js
import fs from 'fs';
import path from 'path';

const STATE_DIR = '.opencode/.heartbeat';

export const UnstuckDetector = async (ctx) => {
  fs.mkdirSync(STATE_DIR, { recursive: true });

  const checkIfStuck = () => {
    const editLog = path.join(STATE_DIR, 'edits.jsonl');
    if (!fs.existsSync(editLog)) return;

    const recent = fs.readFileSync(editLog, 'utf8')
      .split('\n')
      .filter(Boolean)
      .slice(-50)
      .map(JSON.parse)
      .filter(e => e.timestamp > Date.now() - 600000);

    // Count edits per file
    const counts = {};
    for (const e of recent) {
      counts[e.path] = (counts[e.path] || 0) + 1;
    }

    const stuck = Object.entries(counts).filter(([_, c]) => c > 5);
    if (stuck.length > 0) {
      console.warn('High edit frequency detected', { files: stuck.map(([f]) => f) });
    }
  };

  setInterval(checkIfStuck, 300000);

  return {
    "session.created": async () => {
      console.info('Unstuck detector active');
    },

    "file.edited": async (event) => {
      const entry = {
        timestamp: Date.now(),
        path: event.path
      };
      fs.appendFileSync(
        path.join(STATE_DIR, 'edits.jsonl'),
        JSON.stringify(entry) + '\n'
      );
    }
  };
};
```

### Health Check Plugin

```javascript
// .opencode/plugins/health-check.js
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

const STATE_DIR = '.opencode/.heartbeat';
const INTERVAL = 30 * 60 * 1000; // 30 minutes

export const HealthCheck = async (ctx) => {
  fs.mkdirSync(STATE_DIR, { recursive: true });

  const runChecks = () => {
    const results = {};

    try {
      execSync('npm test --silent', { timeout: 120000 });
      results.tests = true;
    } catch {
      results.tests = false;
      console.error('Tests failing');
    }

    const reportFile = path.join(STATE_DIR, `report-${Date.now()}.json`);
    fs.writeFileSync(reportFile, JSON.stringify(results));
  };

  setInterval(runChecks, INTERVAL);

  return {
    "session.created": async () => {
      console.info('Health check plugin active');
    }
  };
};
```

---

## Plugins

### Plugin Structure

```javascript
// .opencode/plugins/example.js
export const ExamplePlugin = async ({ project, client, $ }) => {
  console.info('Plugin initialized');

  return {
    "session.created": async () => {
      console.info('Session started');
    },
    "tool.execute.before": async (input, output) => {
      // Pre-tool logic
    },
    "file.edited": async (event) => {
      // Post-write logic
    }
  };
};
```

### Safety Check Plugin

```javascript
// .opencode/plugins/safety-check.js
export const SafetyCheck = async (ctx) => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool === 'Bash' && output.args.command) {
        const dangerous = [
          /rm\s+-rf\s+\//,
          /sudo/,
          /mkfs/,
          /dd\s+if=/
        ];

        for (const pattern of dangerous) {
          if (pattern.test(output.args.command)) {
            console.error('Destructive command pattern detected');
            throw new Error('Command blocked');
          }
        }
      }
    }
  };
};
```

### Plugin Configuration

```json
{
  "plugin": [
    "opencode-credential-guard",
    "opencode-safety-check",
    "opencode-unstuck-detector"
  ]
}
```

---

## Sandboxing

### Docker Sandbox

```dockerfile
# .opencode/sandbox/Dockerfile
FROM node:20-alpine

WORKDIR /workspace
RUN addgroup -g 1000 opencode && \
    adduser -u 1000 -G opencode -D opencode

USER opencode
```

```yaml
# docker-compose.yml
version: '3.8'
services:
  sandbox:
    build: .opencode/sandbox
    volumes:
      - .:/workspace:ro
    security_opt:
      - no-new-privileges:true
    cap_drop:
      - ALL
    read_only: true
    network_mode: none
```

### Ephemeral Worktree Plugin

```javascript
// .opencode/plugins/ephemeral.js
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import os from 'os';

export const EphemeralPlugin = async ({ $ }) => {
  return {
    "session.created": async () => {
      const project = path.basename(process.cwd());
      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const worktree = path.join(
        os.homedir(),
        '.opencode-worktrees',
        `ephemeral-${project}-${timestamp}`
      );

      fs.mkdirSync(path.dirname(worktree), { recursive: true });
      execSync(`git worktree add -b "ephemeral/..." "${worktree}"`);

      console.info(`Worktree: ${worktree}`);
    }
  };
};
```

---

## Deterministic Checks

### Deterministic Checks Library

```javascript
// .opencode/plugins/lib/deterministic.js
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

export class DeterministicChecks {
  constructor(baseDir = '.opencode/.deterministic') {
    this.baseDir = path.join(process.cwd(), baseDir);
    fs.mkdirSync(this.baseDir, { recursive: true });
  }

  checksumCheck(content, namespace = 'default') {
    const hash = crypto.createHash('sha256').update(content).digest('hex');
    const marker = path.join(this.baseDir, namespace, `${hash}.checked`);

    if (fs.existsSync(marker)) {
      return { shouldRun: false };
    }

    return {
      shouldRun: true,
      markComplete: () => {
        fs.mkdirSync(path.dirname(marker), { recursive: true });
        fs.writeFileSync(marker, new Date().toISOString());
      }
    };
  }

  timeCheck(intervalMs, namespace = 'default') {
    const marker = path.join(this.baseDir, 'timestamps', `${namespace}.last`);
    const now = Date.now();

    if (fs.existsSync(marker)) {
      const last = parseInt(fs.readFileSync(marker, 'utf8'));
      if (now - last < intervalMs) {
        return { shouldRun: false };
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
}
```

### Usage in Plugins

```javascript
import { DeterministicChecks } from './lib/deterministic.js';
const checks = new DeterministicChecks();

export const ExpensiveCheckPlugin = async (ctx) => {
  return {
    "file.edited": async (event) => {
      const { path, content } = event;

      const check = checks.checksumCheck(content, `check:${path}`);
      if (!check.shouldRun) {
        console.debug(`Skipping ${path}`);
        return;
      }

      // Run check...

      check.markComplete();
    }
  };
};
```

---

## Configuration Reference

### opencode.json Structure

```json
{
  "name": "project-name",
  "providers": {
    "anthropic": {
      "apiKey": "...",
      "defaultModel": "..."
    }
  },
  "agent": {
    "agent-name": {
      "description": "...",
      "prompt": "...",
      "tools": ["..."]
    }
  },
  "plugin": [
    "opencode-my-plugin"
  ],
  "permission": {
    "Bash": {
      "allow": ["..."],
      "deny": ["..."]
    }
  }
}
```

### Available Events

| Event | Trigger |
|-------|---------|
| `session.created` | Session initialization |
| `session.deleted` | Session termination |
| `tool.execute.before` | Before tool execution |
| `tool.execute.after` | After tool execution |
| `file.edited` | When a file is edited |
| `session.idle` | Session becomes idle |


---

## Resources

### Official Documentation

| Resource | URL | Description |
|----------|-----|-------------|
| OpenCode Docs | https://opencode.ai/docs | Official documentation |
| GitHub Repository | https://github.com/anomalyco/opencode | Source code |
| Plugin SDK | https://github.com/opencode-ai/plugin | TypeScript SDK |

### Community Resources

| Resource | Description |
|----------|-------------|
| awesome-opencode | Curated resource list |

### Plugins

| Plugin | Author | Description |
|--------|--------|-------------|
| opencode-helicone-session | Community | Helicone analytics |
| opencode-wakatime | Community | Time tracking |
| opencode-sync-plugin | Community | Session sync |

### MCP Servers

| Server | Source | Description |
|--------|--------|-------------|
| filesystem | modelcontextprotocol | Local file access |
| github | modelcontextprotocol | GitHub API |
| postgres | modelcontextprotocol | PostgreSQL |
| sqlite | modelcontextprotocol | SQLite |
| puppeteer | modelcontextprotocol | Browser automation |

### Configuration Examples

| Repository | Description |
|------------|-------------|
| jjmartres/opencode | Config with agents, commands, skills |

---

*Last Updated: March 18, 2026*
