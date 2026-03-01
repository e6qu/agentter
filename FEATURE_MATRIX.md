# AI Coding Agents - Feature Comparison Matrix

*Research Date: March 1, 2026*

## Legend
- ✅ Yes / Fully Supported
- ⚠️ Partial / Limited / Via Extension
- ❌ No / Not Supported

---

## Interface & Access

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Terminal UI (TUI) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ |
| CLI Non-Interactive | ✅ | ✅ | ⚠️ | ✅ | ✅ | ✅ | ❌ | ❌ | ⚠️ |
| VS Code Extension | ✅ | ⚠️ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ |
| JetBrains/Other IDE | ⚠️ | ⚠️ | ❌ | ⚠️ | ❌ | ⚠️ | ❌ | ❌ | ✅ |
| Desktop Application | ✅ | ❌ | ❌ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| Web Interface | ⚠️ | ❌ | ⚠️ | ✅ | ❌ | ❌ | ❌ | ❌ | ✅ |

---

## Model Support & Pricing

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Multi-Provider (75+) | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ |
| Claude Models | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ |
| OpenAI/GPT Models | ✅ | ✅ | ❌ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ |
| Gemini Models | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Kimi Models | ⚠️ | ⚠️ | ❌ | ❌ | ❌ | ⚠️ | ⚠️ | ⚠️ | ✅ |
| Local Models (Ollama) | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ |
| BYOK Support | ✅ | ✅ | ⚠️ | ❌ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Free Tier Available | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Fixed-Price Subscription | ⚠️* | ⚠️* | ❌ | ❌ | ❌ | ⚠️* | ⚠️* | ⚠️* | ✅ |
| Open Source License | ✅ MIT | ✅ Apache 2 | ❌ | ❌ | ✅ Apache 2 | ✅ Apache 2 | ✅ | ✅ | ✅ |

*Via BYOK to Kimi Code or GLM Code

---

## File Operations

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Read Files | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Write Files | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Edit/Modify Files | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Search/Grep | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Glob Patterns | ✅ | ✅ | ✅ | ✅ | ⚠️ | ✅ | ✅ | ✅ | ✅ |
| LSP Integration | ✅ | ❌ | ❌ | ⚠️ | ❌ | ❌ | ⚠️ | ⚠️ | ❌ |
| Repo Map | ⚠️ | ✅ | ⚠️ | ⚠️ | ❌ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

---

## Code Execution & Environment

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Bash/Shell Execution | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Shell Command Mode | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Cloud Sandbox | ❌ | ❌ | ⚠️ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Local Sandbox (Seatbelt) | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Auto Lint on Change | ✅ | ✅ | ✅ | ✅ | ❌ | ⚠️ | ✅ | ✅ | ⚠️ |
| Auto Test on Change | ✅ | ✅ | ✅ | ✅ | ❌ | ⚠️ | ✅ | ✅ | ⚠️ |
| Test Failure Auto-Fix | ⚠️ | ✅ | ⚠️ | ✅ | ❌ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

---

## Git Integration

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Automatic Git Commits | ⚠️ | ✅ | ⚠️ | ✅ | ❌ | ✅ | ⚠️ | ⚠️ | ⚠️ |
| Auto Commit Messages | ⚠️ | ✅ | ⚠️ | ✅ | ❌ | ✅ | ⚠️ | ⚠️ | ⚠️ |
| Git Worktrees Support | ❌ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Branch Management | ⚠️ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| PR Creation | ⚠️ | ⚠️ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| GitHub Integration | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

---

## AI Capabilities

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Multi-Agent/Subagents | ✅ | ❌ | ✅ | ✅ | ❌ | ⚠️ | ❌ | ✅ | ✅ |
| Parallel Execution | ✅ | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ⚠️ | ⚠️ |
| Background Agents | ⚠️ | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Planning Mode | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ | ✅ | ✅ |
| Context Compaction | ⚠️ | ⚠️ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Reasoning Control | ⚠️ | ✅ | ⚠️ | ✅ | ❌ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

---

## Input Methods

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Text Prompts | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Voice Input | ❌ | ✅ | ❌ | ⚠️ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Image Input | ❌ | ✅ | ❌ | ❌ | ✅ | ❌ | ✅ | ✅ | ⚠️ |
| PDF/Documents | ❌ | ⚠️ | ❌ | ❌ | ✅ | ❌ | ⚠️ | ⚠️ | ⚠️ |
| Web Page Context | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ✅ |

---

## Browser & External Tools

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Browser Automation | ❌ | ❌ | ⚠️ | ⚠️ | ❌ | ⚠️ | ✅ | ⚠️ | ⚠️ |
| Web Search | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ✅ | ⚠️ | ⚠️ | ⚠️ | ✅ |
| Screenshot Capture | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ⚠️ | ❌ |
| MCP Support | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| ACP Support | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |

---

## Session Management

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Session Persistence | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Session Resume | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Session Sharing (Links) | ✅ | ❌ | ❌ | ⚠️ | ❌ | ❌ | ❌ | ❌ | ⚠️ |
| Multi-Session Parallel | ✅ | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ⚠️ | ⚠️ |
| Conversation Checkpoints | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Checkpoint Rollback | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | ⚠️ | ✅ | ✅ | ⚠️ |

---

## Automation & Workflows

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Custom Commands/Skills | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ⚠️ |
| Slash Commands | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ |
| Event Hooks | ✅ | ❌ | ✅ | ⚠️ | ❌ | ❌ | ❌ | ⚠️ | ❌ |
| Scheduled Automations | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Recipe/Workflow System | ⚠️ | ❌ | ⚠️ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| Plugin Marketplace | ⚠️ | ❌ | ✅ | ⚠️ | ❌ | ❌ | ❌ | ❌ | ❌ |

---

## Security & Permissions

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Granular Permissions | ✅ | ⚠️ | ✅ | ✅ | ⚠️ | ✅ | ✅ | ✅ | ✅ |
| Per-Action Approval | ✅ | ⚠️ | ✅ | ✅ | ⚠️ | ✅ | ✅ | ✅ | ✅ |
| Auto-Approve Options | ⚠️ | ❌ | ⚠️ | ⚠️ | ❌ | ❌ | ❌ | ⚠️ | ⚠️ |
| YOLO Mode (Dangerous) | ⚠️ | ❌ | ⚠️ | ⚠️ | ❌ | ❌ | ❌ | ⚠️ | ❌ |
| Secret Detection | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Sandbox Restrictions | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |

---

## Context & Project Understanding

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Project Config File | ✅ | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Context Window | 200K | 200K | 200K-1M | 192K | 1M | Varies | Varies | Varies | 200K+ |
| Repo Structure Analysis | ✅ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ✅ |
| Cross-File Dependencies | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Documentation Awareness | ⚠️ | ⚠️ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

---

## Language Support

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Python | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| JavaScript/TypeScript | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Go | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Rust | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Java | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| C/C++ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 100+ Languages | ⚠️ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ✅ | ✅ | ⚠️ |

---

## Summary Statistics

| Tool | Total ✅ | Total ⚠️ | Total ❌ | Best For |
|------|:--------:|:--------:|:--------:|----------|
| **OpenCode** | 36 | 14 | 11 | Provider flexibility, privacy, multi-session |
| **Aider** | 33 | 10 | 18 | Git integration, voice coding, repo maps |
| **Claude Code** | 34 | 13 | 14 | Deep reasoning, subagents, plugins |
| **Codex CLI** | 33 | 12 | 16 | Parallel agents, automations, GitHub integration |
| **Gemini CLI** | 21 | 10 | 30 | Free tier, search grounding, 1M context |
| **Goose** | 27 | 16 | 18 | Open source, MCP, planning-first |
| **Cline** | 28 | 10 | 23 | Human-in-the-loop, browser automation |
| **Roo Code** | 28 | 13 | 20 | Multi-agent in VS Code, specialized modes |
| **Kimi Code** | 31 | 16 | 14 | Fixed-price, shell integration, Kimi models |

---

## Quick Reference: Best Tool For...

| Use Case | Recommended Tool | Why |
|----------|-----------------|-----|
| Maximum provider choice | OpenCode | 75+ providers, LSP, multi-session |
| Best Git workflow | Aider | Automatic commits, repo map, voice |
| Complex multi-step tasks | Claude Code | Subagents, hooks, planning mode |
| Parallel task delegation | Codex CLI | Cloud agents, scheduling, worktrees |
| Zero-cost start | Gemini CLI | 1000 free requests/day |
| Fully open source | Goose | Apache 2.0, MCP-first, recipes |
| Maximum control | Cline | Approve every change, browser tools |
| VS Code multi-agent | Roo Code | Specialized modes, auto-approve |
| Fixed-price billing | Kimi Code | ¥49-199/month predictable cost |
| Shell+AI integration | Kimi Code | Ctrl-X shell mode, Zsh plugin |

---

## Kimi Code Specific Features

| Feature | Description |
|---------|-------------|
| **Shell Command Mode** | Press `Ctrl-X` to toggle between AI and shell mode without leaving the terminal |
| **ACP Protocol** | Agent Client Protocol for IDE integration (Zed, JetBrains) |
| **Zsh Integration** | Native Zsh plugin for AI-powered shell experience |
| **Fixed Pricing** | ¥49-199/month (~$7-28) for unlimited usage |
| **Web UI** | Built-in web interface accessible via browser |
| **Kimi Models** | Optimized for kimi-k2.5 and kimi-for-coding models |

---

*Last Updated: March 1, 2026*
