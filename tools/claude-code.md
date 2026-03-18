# Claude Code

**Type**: Proprietary CLI Tool  
**License**: Proprietary (Anthropic)  
**Primary Developer**: Anthropic  
**Website**: https://code.claude.com/

## Overview

Claude Code is Anthropic's official terminal-based AI coding assistant. It runs locally, integrates deeply with Claude models, and provides features like subagents, hooks, and an extensible plugin system.

Source: [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code/)

## Key Features

### Subagents

Claude Code supports specialized subagents that run in isolated context windows:

> "Subagents are specialized AI assistants that handle specific types of tasks. Each subagent runs in its own context window with a custom system prompt, specific tool access, and independent permissions."

#### Built-in Subagents

| Subagent | Model | Tools | Purpose |
|----------|-------|-------|---------|
| Explore | Haiku | Read-only | Codebase search and analysis |
| Plan | Inherits | Read-only | Planning mode research |
| General-purpose | Inherits | All | Complex multi-step tasks |
| Bash | Inherits | Shell | Terminal commands |

Source: [Claude Code Subagents](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

#### Subagent Configuration

Subagents are defined in Markdown files with YAML frontmatter:

```markdown
---
name: code-reviewer
description: Reviews code for quality and best practices
tools: Read, Grep, Glob, Bash
model: sonnet
---

You are a code reviewer. When invoked, analyze the code and provide
specific, actionable feedback on quality, security, and best practices.
```

### Hooks System

Claude Code supports 8 lifecycle hook types:

| Hook | When It Fires |
|------|---------------|
| `PreToolUse` | Before a tool is called |
| `PostToolUse` | After a tool is called |
| `SessionStart` | At session start |
| `SessionEnd` | At session end |
| `UserPromptSubmit` | When user sends a message |
| `Stop` | When agent stops |
| `SubagentStart` | When a subagent begins |
| `SubagentStop` | When a subagent completes |

Source: [Claude Code Hooks](https://docs.anthropic.com/en/docs/claude-code/en/hooks)

### Plugin Marketplace

Claude Code includes an official plugin marketplace:

> "Shareable packages bundling slash commands, MCP servers, agents, and hooks into installable units."

Install plugins via:
```
/plugin install plugin-name
```

Source: [Claude Code Plugins](https://docs.anthropic.com/en/docs/claude-code/en/plugins)

### Persistent Memory

Subagents can have persistent memory across conversations:

| Scope | Location | Use Case |
|-------|----------|----------|
| `user` | `~/.claude/agent-memory/<name>/` | Cross-project knowledge |
| `project` | `.claude/agent-memory/<name>/` | Project-specific, version controlled |
| `local` | `.claude/agent-memory-local/<name>/` | Project-specific, not version controlled |

Source: [Claude Code Memory](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

## Installation

```bash
# macOS/Linux
curl -fsSL https://claude.ai/install.sh | bash

# Homebrew
brew install --cask claude-code

# npm
npm install -g @anthropic-ai/claude-code
```

Source: [Claude Code Installation](https://docs.anthropic.com/en/docs/claude-code/en/getting-started)

## Configuration

### Settings File

Configuration is stored in `~/.claude/settings.json`:

```json
{
  "model": "sonnet",
  "env": {
    "MAX_THINKING_TOKENS": "10000",
    "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "50"
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "npx eslint --fix \"$CLAUDE_FILE_PATH\""
          }
        ]
      }
    ]
  }
}
```

### Permission Modes

| Mode | Behavior |
|------|----------|
| `default` | Standard permission checking |
| `acceptEdits` | Auto-accept file edits |
| `dontAsk` | Auto-deny permission prompts |
| `bypassPermissions` | Skip all permission checks |
| `plan` | Read-only exploration |

Source: [Claude Code Permissions](https://docs.anthropic.com/en/docs/claude-code/en/permissions)

## API and Customization

### Agent SDK

Claude Code can be used programmatically via the Agent SDK for CI/CD and automation:

```javascript
import { Claude } from '@anthropic-ai/claude-code';

const claude = new Claude();
await claude.run({
  prompt: "Review this code",
  files: ["src/main.ts"]
});
```

Source: [Claude Code SDK](https://docs.anthropic.com/en/docs/claude-code/en/agent-sdk)

### CLI Flags

```bash
# Run with custom subagents
claude --agents '{"code-reviewer": {"description": "..."}}'

# Skip permissions (YOLO mode)
claude --dangerously-skip-permissions

# Disallow specific tools
claude --disallowedTools "Task(Explore)"
```

Source: [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code/en/cli)

### Custom Subagents

Define subagents at different scopes:

| Location | Scope | Priority |
|----------|-------|----------|
| `--agents` CLI flag | Current session | 1 (highest) |
| `.claude/agents/` | Current project | 2 |
| `~/.claude/agents/` | All projects | 3 |
| Plugin's `agents/` | Where plugin enabled | 4 (lowest) |

Source: [Claude Code Subagent Scopes](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

## Worktree Isolation

Subagents can run in isolated Git worktrees:

> "Set `isolation: worktree` to run the subagent in a temporary git worktree, giving it an isolated copy of the repository."

This enables parallel work on different branches without conflicts.

Source: [Claude Code Worktree Isolation](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

## Context Management

### Context Window

- Default: 200K tokens
- API access: Up to 1M tokens (beta)

### Compaction

```bash
# Manual compaction
/compact

# Auto-compaction at 95% (default) or custom percentage
# Set via CLAUDE_AUTOCOMPACT_PCT_OVERRIDE environment variable
```

Source: [Claude Code Token Optimization](https://docs.anthropic.com/en/docs/claude-code/en/token-optimization)

## Supported Models

Claude Code only supports Anthropic models:
- Claude 3.7 Sonnet
- Claude 3.5 Sonnet
- Claude 3 Opus
- Claude 3 Haiku

## Pricing

| Plan | Price | Features |
|------|-------|----------|
| Claude Pro | $17-20/month | Standard usage |
| Claude Max | $100-200/month | Heavy usage |
| API | Pay-per-token | Direct API access |

Source: [Anthropic Pricing](https://www.anthropic.com/pricing)

## Sources and References

1. [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code/)
2. [Claude Code Subagents](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)
3. [Claude Code Hooks](https://docs.anthropic.com/en/docs/claude-code/en/hooks)
4. [Claude Code Plugins](https://docs.anthropic.com/en/docs/claude-code/en/plugins)
5. [Claude Code Permissions](https://docs.anthropic.com/en/docs/claude-code/en/permissions)

---

*Last Updated: March 18, 2026*
