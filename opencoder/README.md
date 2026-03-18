# OpenCode Documentation

*Complete guide to OpenCode CLI - features, agents, skills, hooks, and configuration*

---

## Overview

**OpenCode** is an open-source AI coding agent CLI that enables developers to interact with LLMs through a terminal interface. It features a client/server architecture, multi-agent support, custom skills, and extensive configuration options.

### Key Features

| Feature | Description |
|---------|-------------|
| **Multi-Agent System** | Primary agents (Build, Plan) + Subagents (General, Explore) |
| **Modes** | Build (full tools) and Plan (read-only) modes |
| **Skills System** | Reusable SKILL.md definitions for specific tasks |
| **MCP Support** | Model Context Protocol for external tool integration |
| **Plugin Architecture** | JavaScript/TypeScript plugins with 25+ event hooks |
| **Custom Commands** | Slash commands for repetitive tasks |
| **HTTP Server** | API access via `opencode serve` |
| **Web Interface** | Browser-based UI via `opencode web` |

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        OPENCODE ARCHITECTURE                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐  │
│  │    TUI       │◄────►│   Server     │◄────►│     LLM      │  │
│  │  (Terminal)  │      │  (Node/Bun)  │      │  (Provider)  │  │
│  └──────────────┘      └──────┬───────┘      └──────────────┘  │
│                               │                                  │
│          ┌────────────────────┼────────────────────┐            │
│          ▼                    ▼                    ▼            │
│  ┌──────────────┐   ┌──────────────┐   ┌──────────────┐        │
│  │  MCP Servers │   │   Plugins    │   │   Skills     │        │
│  │  (Tools)     │   │  (Events)    │   │  (SKILL.md)  │        │
│  └──────────────┘   └──────────────┘   └──────────────┘        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Quick Start

### Installation

```bash
# macOS
brew install opencode

# Linux
curl -fsSL https://opencode.ai/install.sh | sh

# Windows (via scoop)
scoop install opencode

# npm
npm install -g @opencode-ai/cli
```

### First Run

```bash
# Authenticate with provider
opencode auth login

# Start TUI
opencode

# Or run single command
opencode run "Explain this codebase"
```

---

## Core Concepts

### 1. [Agents](./agents.md)

Agents are specialized AI assistants with custom prompts, models, and tool access.

**Types**:
- **Primary Agents**: Main assistants (Build, Plan)
- **Subagents**: Specialized assistants invoked via `@mention`

**Built-in Agents**:
| Agent | Type | Description |
|-------|------|-------------|
| `build` | Primary | Full tool access, default agent |
| `plan` | Primary | Read-only, for analysis and planning |
| `general` | Subagent | Multi-step tasks, full tools |
| `explore` | Subagent | Fast, read-only codebase exploration |

[Learn more about Agents →](./agents.md)

---

### 2. [Modes](./modes.md)

Modes customize behavior, tools, and prompts for different use cases.

**Built-in Modes**:
- **Build**: All tools enabled (default)
- **Plan**: Read-only, for analysis without changes

**Switching**: Press `Tab` to cycle between modes

[Learn more about Modes →](./modes.md)

---

### 3. [Skills](./skills.md)

Reusable instructions defined in `SKILL.md` files that agents can load on-demand.

**Structure**:
```markdown
---
name: git-release
description: Create consistent releases and changelogs
---
## What I do
- Draft release notes from merged PRs
- Propose version bump
```

**Loading**: Agents call `skill({ name: "git-release" })`

[Learn more about Skills →](./skills.md)

---

### 4. [Commands](./commands.md)

Custom slash commands for repetitive tasks.

**Example**: `.opencode/commands/test.md`
```markdown
---
description: Run tests with coverage
---
Run the full test suite with coverage report.
```

**Usage**: `/test` in TUI

[Learn more about Commands →](./commands.md)

---

### 5. [Plugins & Hooks](./plugins-hooks.md)

JavaScript/TypeScript modules that hook into 25+ lifecycle events.

**Example Plugin**:
```javascript
export const MyPlugin = async ({ project, client, $ }) => {
  return {
    "tool.execute.before": async (input, output) => {
      // Modify tool execution
    },
    "session.idle": async () => {
      // Notification on completion
    }
  }
}
```

[Learn more about Plugins & Hooks →](./plugins-hooks.md)

---

### 6. [Configuration](./configuration.md)

Configure via `opencode.json` (JSON/JSONC) or markdown files.

**Locations** (in precedence order):
1. Remote config (`.well-known/opencode`)
2. Global config (`~/.config/opencode/opencode.json`)
3. Custom path (`OPENCODE_CONFIG`)
4. Config content (`OPENCODE_CONFIG_CONTENT`)
5. Project config (`opencode.json`)
6. `.opencode/` directory

**Key Sections**:
- `agent`: Custom agent definitions
- `mode`: Mode configurations
- `tools`: Tool enable/disable
- `mcp`: MCP server configuration
- `plugin`: Plugin loading
- `permission`: Permission rules

[Learn more about Configuration →](./configuration.md)

---

## CLI Commands

| Command | Description |
|---------|-------------|
| `opencode` | Start TUI (default) |
| `opencode run "prompt"` | Execute single command |
| `opencode serve` | Start HTTP server |
| `opencode web` | Start web interface |
| `opencode attach <url>` | Attach to running server |
| `opencode agent create` | Create new agent |
| `opencode agent list` | List available agents |
| `opencode mcp add` | Add MCP server |
| `opencode session list` | List sessions |
| `opencode stats` | Show usage statistics |

---

## Directory Structure

```
project/
├── opencode.json              # Project config
├── .opencode/
│   ├── agents/               # Custom agents (*.md)
│   ├── commands/             # Custom commands (*.md)
│   ├── modes/                # Custom modes (*.md)
│   ├── skills/               # Skills (*/SKILL.md)
│   ├── plugins/              # Plugins (*.js/*.ts)
│   └── plans/                # Plan mode output
└── AGENTS.md                 # Project instructions

~/.config/opencode/
├── opencode.json             # Global config
├── tui.json                  # TUI settings
├── agents/                   # Global agents
├── commands/                 # Global commands
├── modes/                    # Global modes
├── skills/                   # Global skills
└── plugins/                  # Global plugins
```

---

## Configuration Files

### AGENTS.md

Project instructions for AI agents (similar to Cursor rules):

```markdown
# Project Guidelines

## Coding Standards
- Use TypeScript for all new code
- Follow ESLint configuration
- Write tests for all functions

## Architecture
- Frontend: React + Vite
- Backend: Node.js + Express
- Database: PostgreSQL
```

### opencode.json

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "anthropic/claude-sonnet-4-20250514",
  "agent": {
    "code-reviewer": {
      "mode": "subagent",
      "description": "Reviews code for quality",
      "prompt": "You are a code reviewer...",
      "tools": { "write": false, "edit": false }
    }
  },
  "mcp": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    }
  }
}
```

---

## MCP (Model Context Protocol)

OpenCode supports MCP servers for external tool integration:

```json
{
  "mcp": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"]
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://localhost/mydb"]
    }
  }
}
```

**Management**:
```bash
opencode mcp add          # Add MCP server
opencode mcp list         # List MCP servers
opencode mcp auth <name>  # Authenticate with OAuth
```

---

## Server Mode

Start OpenCode as a server for API access:

```bash
# Start server
opencode serve --port 4096

# Attach from another terminal
opencode attach http://localhost:4096

# Or use API directly
curl http://localhost:4096/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello"}'
```

**Use Cases**:
- Share sessions across devices
- Integrate with CI/CD
- Build custom UIs
- Run multiple clients

---

## Best Practices

### 1. Use Modes Appropriately

- **Build mode**: Active development, file editing
- **Plan mode**: Analysis, understanding codebase, creating specs

### 2. Create Skills for Repetitive Tasks

```markdown
# .opencode/skills/deployment/SKILL.md
---
name: deployment
description: Deploy to production following our process
---
1. Run tests: npm test
2. Build: npm run build
3. Deploy: npm run deploy
4. Verify health checks pass
```

### 3. Use Subagents for Parallel Work

```
@explore find all API endpoints
@general write tests for auth module
@general write tests for user module
```

### 4. Configure Project-Specific Agents

```json
{
  "agent": {
    "backend-dev": {
      "description": "Backend development specialist",
      "prompt": "You are a backend developer...",
      "tools": { "bash": true, "write": true }
    }
  }
}
```

### 5. Version Control Your Configuration

Check these into Git:
- `opencode.json`
- `.opencode/agents/`
- `.opencode/commands/`
- `.opencode/skills/`
- `AGENTS.md`

---

## Troubleshooting

### Common Issues

**Issue**: Agents not showing up
- Verify file is in correct location
- Check JSON/markdown syntax
- Restart OpenCode

**Issue**: Skills not loading
- Ensure `SKILL.md` is in all caps
- Verify frontmatter has `name` and `description`
- Check permissions in config

**Issue**: MCP servers failing
- Verify command is correct
- Check OAuth authentication
- Review server logs

**Issue**: Plugins not loading
- Verify file extension is `.js` or `.ts`
- Ensure exported function name matches conventions
- Check for syntax errors with `node -c <file>`
- Confirm plugin is in `.opencode/plugins/` or listed in `opencode.json` under `plugin`

**Issue**: Hooks not firing
- Event names are case-sensitive (use `session.created` not `on:session:start`)
- Verify the event actually occurs during your workflow
- Add `console.log` at plugin init to confirm loading

---

## Resources

- [Official Documentation](https://opencode.ai/docs)
- [GitHub Repository](https://github.com/anomalyco/opencode)
- [Discord Community](https://discord.gg/opencode)
- [Plugin SDK](https://github.com/opencode-ai/plugin)

---

## Ecosystem & Community

### Official Projects

| Project | Description | Link |
|---------|-------------|------|
| **opencode** | Main CLI repository | [anomalyco/opencode](https://github.com/anomalyco/opencode) |
| **plugin SDK** | TypeScript SDK for plugins | [opencode-ai/plugin](https://github.com/opencode-ai/plugin) |
| **awesome-opencode** | Curated list of resources | [awesome-opencode/awesome-opencode](https://github.com/awesome-opencode/awesome-opencode) |

### Community Plugins

| Plugin | Description | Install |
|--------|-------------|---------|
| **opencode-helicone-session** | Helicone analytics integration | `npm install opencode-helicone-session` |
| **opencode-wakatime** | WakaTime time tracking | `npm install opencode-wakatime` |
| **opencode-sync-plugin** | Session synchronization | `npm install opencode-sync-plugin` |

### Configuration Examples

| Repository | Description |
|------------|-------------|
| [jjmartres/opencode](https://github.com/jjmartres/opencode) | Complete config with agents, commands, skills, MCP |

---

## GitHub Integration

### GitHub Agent

OpenCode includes a GitHub agent for repository automation:

```bash
# Install GitHub agent
opencode github install

# Run GitHub agent (typically in CI)
opencode github run --event push
```

### GitHub Skills

Create `.claude/skills/` for GitHub-specific workflows:
- PR review automation
- Release management
- Issue triage

---

## MCP Server Ecosystem

### Official MCP Servers

| Server | Description | Install |
|--------|-------------|---------|
| **filesystem** | Local file access | `@modelcontextprotocol/server-filesystem` |
| **github** | GitHub API access | `@modelcontextprotocol/server-github` |
| **postgres** | PostgreSQL database | `@modelcontextprotocol/server-postgres` |
| **sqlite** | SQLite database | `@modelcontextprotocol/server-sqlite` |
| **puppeteer** | Browser automation | `@modelcontextprotocol/server-puppeteer` |

### Community MCP Servers

- **Snyk**: Security scanning
- **Stripe**: Payment operations
- **Vercel**: Deployment management

---

## Subpages

| Page | Content |
|------|---------|
| [Tutorial](./TUTORIAL.md) | Complete setup guide with plugins, skills, security |
| [Agents](./agents.md) | Primary/subagents, configuration, usage |
| [Modes](./modes.md) | Build vs Plan, custom modes, switching |
| [Skills](./skills.md) | SKILL.md format, discovery, permissions |
| [Commands](./commands.md) | Custom slash commands, arguments, templates |
| [Plugins & Hooks](./plugins-hooks.md) | Plugin API, 25+ events, custom tools |
| [Configuration](./configuration.md) | opencode.json, TUI config, precedence |
| [Advanced Agents](./advanced-agents.md) | Ephemeral, heartbeat, custom patterns |

---

*Last Updated: March 18, 2026*
