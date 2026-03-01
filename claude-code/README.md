# Claude Code Documentation

*Complete guide to Claude Code - features, agents, skills, hooks, and configuration*

---

## Overview

**Claude Code** is an agentic coding tool by Anthropic that lives in your terminal, understands your codebase, and helps you code faster by executing routine tasks, explaining complex code, and handling git workflows.

### Key Features

| Feature | Description |
|---------|-------------|
| **Agentic Coding** | Autonomous task execution with tool use |
| **Subagents** | Spawn specialized agents for parallel work |
| **Agent Teams** | Multiple agents working on different files |
| **Skills** | Reusable SKILL.md instructions |
| **Hooks** | Lifecycle automation with shell commands |
| **MCP Support** | Model Context Protocol integration |
| **Git Integration** | Native git workflows and PR creation |
| **Worktrees** | Isolated git worktrees for parallel work |

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                       CLAUDE CODE ARCHITECTURE                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐  │
│  │   Terminal   │◄────►│  Claude Code │◄────►│   Claude     │  │
│  │   (TUI)      │      │   (Node.js)  │      │   (Anthropic)│  │
│  └──────────────┘      └──────┬───────┘      └──────────────┘  │
│                               │                                  │
│          ┌────────────────────┼────────────────────┐            │
│          ▼                    ▼                    ▼            │
│  ┌──────────────┐   ┌──────────────┐   ┌──────────────┐        │
│  │  MCP Servers │   │    Hooks     │   │   Skills     │        │
│  │  (Tools)     │   │  (Lifecycle) │   │  (SKILL.md)  │        │
│  └──────────────┘   └──────────────┘   └──────────────┘        │
│                                                                  │
│  ┌──────────────┐   ┌──────────────┐                            │
│  │  Subagents   │   │  Agent Teams │                            │
│  │  (Explore)   │   │  (Parallel)  │                            │
│  └──────────────┘   └──────────────┘                            │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Quick Start

### Installation

```bash
# macOS
brew install claude-code

# npm
npm install -g @anthropics/claude-code

# Or use without installing
npx @anthropics/claude-code
```

### Authentication

```bash
# Login to Anthropic
claude auth login

# Or set API key
export ANTHROPIC_API_KEY=your_key
```

### First Run

```bash
# Start Claude Code
claude

# In a specific directory
claude /path/to/project

# With a prompt
claude "Explain this codebase"
```

---

## Core Concepts

### 1. [Agents](./agents.md)

Claude Code has built-in agents and supports custom subagents:

**Built-in Agents**:
| Agent | Purpose | Tools |
|-------|---------|-------|
| **Default** | General coding | All tools |
| **Explore** | Read-only exploration | Read, Grep, Glob |
| **Plan** | Analysis and planning | Read-only |

**Custom Subagents**: Create specialized agents in `~/.claude/agents/`

[Learn more about Agents →](./agents.md)

---

### 2. [Skills](./skills.md)

Skills extend Claude's capabilities with reusable instructions in `SKILL.md` files.

**Bundled Skills**:
- `/simplify` - Code cleanup with parallel review agents
- `/batch <instruction>` - Large-scale codebase changes
- `/debug [description]` - Troubleshoot session issues

**Custom Skills**: Create in `.claude/skills/<name>/SKILL.md`

[Learn more about Skills →](./skills.md)

---

### 3. [Hooks](./hooks.md)

Hooks are user-defined shell commands, HTTP endpoints, or LLM prompts that execute automatically at lifecycle events.

**Hook Events**:
- `PreToolUse` - Before tool execution (can block)
- `PostToolUse` - After tool success
- `SessionStart` - When session begins
- `SessionEnd` - When session ends
- `SubagentStart` / `SubagentStop` - Subagent lifecycle

[Learn more about Hooks →](./hooks.md)

---

### 4. [Agent Teams](./agent-teams.md)

Multiple agents working in parallel on different aspects of a task.

**Features**:
- File-disjoint parallel execution
- Task claiming with file locking
- Automatic coordination
- Git worktree isolation

[Learn more about Agent Teams →](./agent-teams.md)

---

### 5. [Configuration](./configuration.md)

Configure via `settings.json` files:

**Locations**:
- `~/.claude/settings.json` - Global settings
- `.claude/settings.json` - Project settings
- `.claude/settings.local.json` - Local (gitignored)

**Key Sections**:
- `hooks` - Lifecycle automation
- `agents` - Custom agent definitions
- `permissions` - Tool permissions

[Learn more about Configuration →](./configuration.md)

---

## Directory Structure

```
project/
├── .claude/
│   ├── settings.json          # Project settings
│   ├── settings.local.json    # Local settings (gitignored)
│   ├── agents/               # Custom agents
│   │   └── reviewer.json
│   ├── skills/               # Project skills
│   │   └── deployment/
│   │       └── SKILL.md
│   ├── hooks/                # Hook scripts
│   │   └── pre-commit.sh
│   └── commands/             # Slash commands
│       └── test.md
├── .claude.md                # Project instructions
└── CLAUDE.md                 # Alternative name

~/.claude/
├── settings.json             # Global settings
├── agents/                   # Global agents
├── skills/                   # Global skills
└── hooks/                    # Global hooks
```

---

## Key Commands

### Slash Commands

| Command | Description |
|---------|-------------|
| `/init` | Initialize Claude Code in project |
| `/clear` | Clear conversation history |
| `/compact` | Compact conversation context |
| `/cost` | Show token usage and cost |
| `/help` | Show help |
| `/exit` | Exit Claude Code |

### Built-in Skills

| Command | Description |
|---------|-------------|
| `/simplify` | Clean up recent changes |
| `/batch <instruction>` | Large-scale changes |
| `/debug [description]` | Debug session issues |

---

## Configuration Files

### CLAUDE.md / .claude.md

Project instructions for Claude:

```markdown
# Project Guidelines

## Tech Stack
- React 18 + TypeScript
- Node.js + Express backend
- PostgreSQL database

## Coding Standards
- Use functional components with hooks
- Write tests for all API endpoints
- Follow existing code style

## Git Workflow
- Create feature branches
- Write descriptive commit messages
- Open PRs for review
```

### settings.json

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/validate.sh"
          }
        ]
      }
    ]
  },
  "permissions": {
    "allow": {
      "Bash": ["npm test", "npm run build"]
    }
  }
}
```

---

## MCP (Model Context Protocol)

Claude Code supports MCP servers for external tool integration:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"]
    }
  }
}
```

---

## Git Integration

### Worktrees

Claude Code uses git worktrees for isolation:

```bash
# Automatic worktree creation for subagents
# Each subagent gets isolated git environment

# Manual worktree with --worktree flag
claude --worktree /path/to/worktree
```

### PR Creation

```bash
# Create PR from current branch
claude "Create a PR for this branch"

# With specific title and description
claude "Create PR with title 'Fix auth bug' and description"
```

---

## Best Practices

### 1. Use Skills for Workflows

```markdown
# .claude/skills/deploy/SKILL.md
---
name: deploy
description: Deploy to production
disable-model-invocation: true
---
1. Run tests: npm test
2. Build: npm run build
3. Deploy: npm run deploy
4. Verify health checks
```

### 2. Set Up Hooks for Safety

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/safety-check.sh"
          }
        ]
      }
    ]
  }
}
```

### 3. Create Project-Specific Agents

```json
{
  "agents": {
    "backend": {
      "description": "Backend specialist",
      "system": "You are a backend developer..."
    }
  }
}
```

### 4. Use Agent Teams for Large Tasks

```
"@backend implement the API endpoints
@frontend create the UI components
In parallel, then integrate them"
```

---

## Troubleshooting

### Common Issues

**Issue**: Claude can't find skills
- Check `.claude/skills/<name>/SKILL.md` exists
- Verify frontmatter has `name` and `description`
- Restart Claude Code

**Issue**: Hooks not firing
- Verify JSON syntax in settings.json
- Check hook script permissions (`chmod +x`)
- Review hook logs

**Issue**: Agent teams conflicting
- Ensure tasks are file-disjoint
- Check worktree permissions
- Review `.claude/current_tasks/`

---

## Resources

- [Official Documentation](https://code.claude.com/docs)
- [Anthropic Blog](https://www.anthropic.com/blog)
- [Claude Code on X](https://x.com/anthropic)

---

## Ecosystem & Community

### Official Resources

| Resource | Description | Link |
|----------|-------------|------|
| **Documentation** | Official docs | [code.claude.com/docs](https://code.claude.com/docs) |
| **Anthropic** | Company blog | [anthropic.com](https://www.anthropic.com) |
| **Claude API** | API reference | [docs.anthropic.com](https://docs.anthropic.com) |

### Community Projects

| Project | Description | Link |
|---------|-------------|------|
| **awesome-claude-code** | Curated resources | [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) |
| **awesome-agent-skills** | 380+ agent skills | [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) |
| **awesome-claude-skills** | Practical skills | [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) |
| **claude-code-commands** | Commands & skills | [shakacode/claude-code-commands-skills-agents](https://github.com/shakacode/claude-code-commands-skills-agents) |
| **claude-code-hooks** | Hooks mastery | [disler/claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery) |

### Configuration Examples

| Repository | Description |
|------------|-------------|
| [shakacode/claude-code-commands](https://github.com/shakacode/claude-code-commands-skills-agents) | Complete setup with agents, skills, hooks |
| [waylandzhang/claude-config](https://gist.github.com/waylandzhang/7b40f058a76ac8f3a74f2e3b17dcccd4) | Best practices configuration |

---

## Subpages

| Page | Content |
|------|---------|
| [Tutorial](./TUTORIAL.md) | Complete setup guide with skills, agents, security |
| [Agents](./agents.md) | Built-in and custom subagents |
| [Skills](./skills.md) | SKILL.md format, bundled skills, creation |
| [Hooks](./hooks.md) | 15+ hook events, configuration, examples |
| [Agent Teams](./agent-teams.md) | Parallel execution, coordination |
| [Configuration](./configuration.md) | settings.json, permissions, MCP |
| [Advanced Agents](./advanced-agents.md) | Subagents, ephemeral, heartbeat patterns |

---

*Last Updated: March 1, 2026*
