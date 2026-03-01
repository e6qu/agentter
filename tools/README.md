# Tools Documentation

This directory contains detailed documentation for each AI coding agent tool.

## Available Documentation

| Tool | Type | License | Best For |
|------|------|---------|----------|
| [OpenCode](./opencode.md) | CLI/TUI | MIT | Provider flexibility (75+ providers) |
| [Aider](./aider.md) | CLI | Apache 2.0 | Git integration, repo maps, voice |
| [Claude Code](./claude-code.md) | CLI/TUI | Proprietary | Subagents, plugins, deep reasoning |
| [Codex CLI](./codex-cli.md) | CLI | Proprietary | Cloud agents, scheduled automations |
| [Gemini CLI](./gemini-cli.md) | CLI | Apache 2.0 | Free tier, search grounding |
| [Goose](./goose.md) | CLI/Desktop | Apache 2.0 | Fully open source, MCP-first |
| [Cline](./cline.md) | VS Code Extension | Open Source | Human-in-the-loop control |
| [Roo Code](./roo-code.md) | VS Code Extension | Open Source | Multi-agent in VS Code |
| [Kimi Code](./kimi-code.md) | CLI/TUI | Open Source | Fixed-price subscription |

## Quick Comparison

### CLI/TUI Tools
- **OpenCode**: 75+ providers, LSP, multi-session
- **Aider**: Best Git workflow, repo maps, voice
- **Claude Code**: Subagents, hooks, planning mode
- **Codex CLI**: Cloud sandboxes, parallel agents
- **Gemini CLI**: 1000 free requests/day
- **Goose**: Apache 2.0, recipes, MCP-UI
- **Kimi Code**: Fixed pricing (¥49-199/month)

### IDE Extensions
- **Cline**: Approve every change, browser automation
- **Roo Code**: Multi-agent, specialized modes

## Feature Highlights by Tool

### OpenCode
- Native LSP integration (30+ languages)
- Client/server architecture with HTTP API
- Multi-session parallel agents
- 75+ model providers via Models.dev

### Aider
- Repository map for codebase understanding
- Automatic Git commits with generated messages
- Voice-to-code input
- Image and web page context

### Claude Code
- Subagents with isolated contexts
- 8 lifecycle hook types
- Plugin marketplace
- Persistent memory (user/project/local scopes)

### Codex CLI
- Cloud sandbox execution
- Scheduled automations
- Skills system
- Git worktree isolation for parallel agents

### Gemini CLI
- 60 req/min, 1000 req/day free tier
- Google Search grounding
- 1M token context window
- Multimodal input (images, PDFs)

### Goose
- Fully Apache 2.0 licensed
- Recipes for reusable workflows
- MCP-UI rendering in desktop app
- Custom distribution building

### Cline
- Human-in-the-loop approval model
- Browser automation with screenshots
- Workspace checkpoints
- VS Code native integration

### Roo Code
- Multi-agent orchestration
- Specialized modes (Ask, Architect, Code, Debug)
- Custom mode creation
- Built on Cline foundation

### Kimi Code
- Unique Ctrl-X shell mode toggle
- ACP protocol for IDE integration
- Zsh plugin for shell integration
- Fixed-price subscription model

## Sources

All documentation includes citations to:
- Official documentation
- GitHub repositories
- Verified third-party reviews
- Configuration examples

Last Updated: March 1, 2026
