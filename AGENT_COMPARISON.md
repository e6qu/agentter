# Comprehensive Comparison of AI Coding Agents

*Research conducted: March 1, 2026*

## Summary Table

| Tool | Type | License | Supported Models | Pricing | Fixed-Price Option |
|------|------|---------|------------------|---------|-------------------|
| **OpenCode** | TUI/CLI | Open Source (MIT) | 75+ providers via Models.dev | Free (BYOK) | Via Kimi/GLM BYOK |
| **Aider** | TUI/CLI | Open Source (Apache 2.0) | Claude, GPT, Gemini, local via Ollama | Free (BYOK) | Via Kimi/GLM BYOK |
| **Claude Code** | TUI/CLI | Source-available | Claude models only | $20-200/month or API | ❌ Pay-per-token |
| **Continue.dev** | IDE Plugin | Open Source | Multiple providers | Free (BYOK) | Via Kimi/GLM BYOK |
| **Cody** | IDE Plugin/CLI | Proprietary (Sourcegraph) | Multiple providers | Freemium | ❌ Usage-based |
| **Codex CLI** | TUI/CLI | Open Source (Apache 2.0) | o4-mini, o3, GPT-4.1 | ChatGPT subscription | ❌ Included in sub |
| **Kimi Code** | TUI/CLI | Proprietary (Moonshot AI) | Moonshot models | ¥49-199/month | ✅ Fixed-price tiers |
| **GLM Code** | TUI/CLI | Proprietary (Zhipu AI) | GLM models | $3-60/month | ✅ Fixed-price tiers |
| **Cline** | IDE Extension | Open Source | Multiple via OpenRouter | Free (BYOK) | Via Kimi/GLM BYOK |
| **Roo Code** | IDE Extension | Open Source | Multiple providers | Free (BYOK) | Via Kimi/GLM BYOK |
| **Gemini CLI** | TUI/CLI | Open Source (Apache 2.0) | Gemini models | Free tier + API | ❌ Usage-based |

---

## Feature Comparison Matrix

| Feature Category | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|------------------|----------|-------|-------------|-----------|------------|-------|-------|----------|

### Core Interface

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **TUI Interface** | ✅ Full TUI | ✅ Terminal UI | ✅ Full TUI | ✅ Full TUI | ✅ Terminal UI | ✅ Desktop + CLI | VS Code panel | VS Code panel |
| **CLI Mode** | ✅ Non-interactive | ✅ Yes | ✅ Full (`-p` flag, Agent SDK) | ✅ Yes | ✅ Yes | ✅ Yes | ❌ IDE only | ❌ IDE only |
| **IDE Extension** | ✅ Available | ⚠️ Watch mode only | ✅ VS Code (beta) | ✅ VS Code, Cursor | ❌ | ✅ Available | ✅ Native | ✅ Native |

### Model Support

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **Multi-Provider** | ✅ 75+ providers | ✅ Multiple | ❌ Claude only | ❌ OpenAI only | ❌ Gemini only | ✅ Any LLM | ✅ OpenRouter | ✅ Multiple |
| **Local Models** | ✅ Ollama | ✅ Ollama | ❌ | ❌ | ❌ | ✅ Ollama | ✅ Ollama | ✅ Ollama |
| **BYOK Support** | ✅ Yes | ✅ Yes | ⚠️ API option | ❌ Subscription | ✅ API key | ✅ Yes | ✅ Yes | ✅ Yes |

### File & Code Operations

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **File Read** | ✅ read tool | ✅ Read files | ✅ Read tool | ✅ read_file | ✅ File read | ✅ Read | ✅ Read | ✅ Read |
| **File Write** | ✅ write tool | ✅ Write files | ✅ Write tool | ✅ create_file | ✅ File write | ✅ Write | ✅ Write | ✅ Write |
| **File Edit** | ✅ edit tool | ✅ Edit files | ✅ Edit tool | ✅ apply_patch | ✅ File edit | ✅ Edit | ✅ Edit | ✅ Edit |
| **Glob/Search** | ✅ glob, grep | ✅ Repo map | ✅ Glob, Grep | ✅ search_files | ✅ Search | ✅ Search | ✅ Search | ✅ Search |
| **LSP Integration** | ✅ Native LSP | ❌ | ❌ | ⚠️ Via MCP | ❌ | ❌ | ⚠️ Via extension | ⚠️ Via extension |

### Execution & Environment

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **Bash/Shell** | ✅ bash tool | ✅ Yes | ✅ Bash tool | ✅ shell | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **Sandbox** | ❌ Local | ❌ Local | ⚠️ Seatbelt (macOS) | ✅ Cloud sandbox | ❌ | ❌ Local | ❌ Local | ❌ Local |
| **Auto-lint** | ✅ Configurable | ✅ Automatic | ✅ Via hooks | ✅ Auto-fix | ❌ | ✅ Via MCP | ✅ Auto-apply | ✅ Auto-apply |
| **Auto-test** | ✅ Configurable | ✅ Automatic | ✅ Via hooks | ✅ Auto-run | ❌ | ✅ Via MCP | ✅ Auto-run | ✅ Auto-run |

### Git Integration

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **Auto-commit** | ⚠️ Via commands | ✅ Automatic | ✅ Via plugins | ✅ Yes | ❌ | ✅ Yes | ⚠️ Manual | ⚠️ Manual |
| **Git worktrees** | ❌ | ✅ Yes | ✅ Yes | ✅ Yes | ❌ | ❌ | ❌ | ❌ |
| **Commit messages** | ⚠️ Manual | ✅ Auto-generated | ✅ Via plugins | ✅ Auto | ❌ | ✅ Auto | ⚠️ Manual | ⚠️ Manual |
| **PR creation** | ⚠️ Via GitHub MCP | ⚠️ Manual | ✅ Via plugins | ✅ Yes | ⚠️ Via Actions | ⚠️ Via MCP | ⚠️ Manual | ⚠️ Manual |

### Advanced Capabilities

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **MCP Support** | ✅ Full MCP | ❌ | ✅ Full MCP | ✅ MCP (Feb 2026) | ✅ MCP | ✅ Full MCP | ✅ MCP | ✅ MCP |
| **Multi-Agent** | ✅ @general subagent | ❌ | ✅ Subagents/Teams | ✅ Parallel agents | ❌ | ⚠️ Via recipes | ❌ | ✅ Yes |
| **Browser Automation** | ❌ | ❌ | ⚠️ Via plugins | ⚠️ Via skills | ❌ | ⚠️ Via MCP | ✅ Built-in | ⚠️ Via tools |
| **Voice Input** | ❌ | ✅ Yes | ❌ | ⚠️ Experimental | ❌ | ❌ | ❌ | ❌ |
| **Image Input** | ❌ | ✅ Yes | ✅ Yes (via Read tool) | ❌ | ✅ Yes | ❌ | ✅ Yes | ✅ Yes |
| **Web Fetch** | ✅ webfetch | ⚠️ Manual | ⚠️ Via MCP | ⚠️ Cached search | ✅ Search grounding | ⚠️ Via MCP | ⚠️ Via browser | ⚠️ Via tools |

### Session Management

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **Session Persistence** | ✅ Yes | ✅ Yes | ✅ Checkpoints | ✅ Yes | ✅ Checkpoints | ✅ Yes | ✅ Checkpoints | ✅ Yes |
| **Session Sharing** | ✅ Share links | ❌ | ❌ | ⚠️ Via GitHub | ❌ | ❌ | ❌ | ❌ |
| **Multi-Session** | ✅ Parallel sessions | ❌ | ✅ Background agents | ✅ Parallel threads | ❌ | ❌ | ❌ | ⚠️ Limited |
| **Session Resume** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| **Compact/Context Mgmt** | ⚠️ Auto | ⚠️ Manual | ✅ /compact command | ✅ Auto | ⚠️ Manual | ⚠️ Manual | ⚠️ Manual | ⚠️ Manual |

### Workflow & Automation

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **Planning Mode** | ✅ plan agent | ✅ Structured mode | ✅ Planning mode | ✅ Plan mode | ❌ | ✅ Planning-first | ❌ | ✅ Architect mode |
| **Custom Commands** | ✅ 32+ commands | ✅ Slash commands | ✅ Plugins | ✅ Skills | ❌ | ✅ Recipes | ✅ Custom modes | ✅ Custom modes |
| **Hooks/Automation** | ✅ Plugin hooks | ❌ | ✅ 8 hook types | ⚠️ Automations | ❌ | ❌ | ❌ | ✅ Auto-approve |
| **Scheduled Tasks** | ❌ | ❌ | ❌ | ✅ Automations | ❌ | ❌ | ❌ | ❌ |

### Security & Permissions

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **Permission System** | ✅ Granular | ⚠️ Basic | ✅ Granular | ✅ Granular | ⚠️ Basic | ✅ Granular | ✅ Granular | ✅ Granular |
| **Approval Required** | ✅ Per-action | ⚠️ Configurable | ✅ Configurable | ✅ Configurable | ⚠️ Basic | ✅ Configurable | ✅ Always | ✅ Configurable |
| **YOLO Mode** | ⚠️ Configurable | ❌ | ⚠️ --dangerously-skip | ⚠️ Configurable | ❌ | ❌ | ❌ | ⚠️ Auto-approve |
| **Secret Detection** | ✅ Yes | ❌ | ✅ Hook-based | ❌ | ❌ | ❌ | ❌ | ❌ |

### Pricing Model

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code |
|---------|----------|-------|-------------|-----------|------------|-------|-------|----------|
| **Base Cost** | Free | Free | Subscription | Subscription | Free tier | Free | Free | Free |
| **Model Cost** | BYOK | BYOK | Included or API | Included | BYOK or free tier | BYOK | BYOK | BYOK |
| **Free Tier Available** | ✅ Unlimited | ✅ Unlimited | ❌ | ❌ (requires sub) | ✅ 1000 req/day | ✅ Unlimited | ✅ Unlimited | ✅ Unlimited |

---

## Detailed Analysis by Tool

### OpenCode
**Best for**: Developers wanting maximum provider flexibility, privacy, and multi-session capabilities

**Key Strengths**:
- 75+ LLM providers via Models.dev integration
- Native LSP integration for type-aware code intelligence
- Multi-session support (run parallel agents on same project)
- Session sharing via links for collaboration
- Client/server architecture enables remote mobile control
- Privacy-first: no code stored externally
- Supports GitHub Copilot/ChatGPT Plus auth (no separate API key needed)
- Two built-in agents: `build` (full-access) and `plan` (read-only)

**Limitations**:
- Configuration can be overwhelming due to breadth of options
- `build` agent can be aggressive with file modifications
- No native git auto-commit (requires commands)

**Supported Models**: Claude, GPT, Gemini, Groq, AWS Bedrock, Azure OpenAI, OpenRouter, Ollama local models, and 60+ more

---

### Aider
**Best for**: Developers wanting precise Git-safe edits with automatic commits

**Key Strengths**:
- Best-in-class Git integration: every change auto-committed with descriptive messages
- Repo map: structural understanding of entire codebase
- Voice-to-code: hands-free coding via speech
- IDE watch mode: add `# aider:` comments in IDE, Aider acts automatically
- Image and web page context support
- Automatic linting and testing with auto-fix loops
- Works with 100+ programming languages
- Supports thinking-tokens and reasoning-effort controls

**Limitations**:
- Pair programmer rather than fully autonomous agent
- Not designed for system-wide orchestration
- Limited to file-level focused edits
- No built-in MCP support (as of research date)

**Supported Models**: Claude 3.7 Sonnet, DeepSeek R1/V3, GPT-4o, o1, o3-mini, Gemini, local Ollama models

---

### Claude Code
**Best for**: Developers wanting deep reasoning, subagent orchestration, and extensive plugin ecosystem

**Key Strengths**:
- Subagents (July 2025): spawn specialized parallel AI agents
- Background agents: concurrent processing without blocking
- 8 hook types for lifecycle automation (PreToolUse, PostToolUse, SessionStart, etc.)
- Rich plugin marketplace with 50+ skills
- Remote control (Feb 2026): continue sessions from mobile/browser
- Planning mode with structured outlines and risk identification
- Automatic checkpoints for easy rollback
- Worktree isolation for conflict-free parallel work
- HTTP hooks for external service integration (Feb 2026)
- 200K context window (up to 1M via API)
- Image input supported via the Read tool (PNG, JPG, etc.)

**Limitations**:
- Claude models only (no provider flexibility)
- Subscription gate ($20-200/month)
- Can be overkill for simple, focused tasks

**Supported Models**: Claude Sonnet, Opus, Haiku (Anthropic models only)

---

### Codex CLI
**Best for**: Teams already using ChatGPT who want parallel task delegation and scheduled automations

**Key Strengths**:
- Cloud sandbox with isolated execution environment
- Parallel agent execution (5+ agents simultaneously)
- Scheduled automations for recurring tasks (CI triage, release notes)
- GitHub-native integration: @Codex in PRs for auto-review
- Skills system: reusable instruction bundles (Figma, Linear, deployment)
- Git worktrees for conflict-free multi-agent work
- AGENTS.md configuration for project context
- Multi-platform: macOS app, CLI, IDE extensions, web
- Voice transcription (experimental)

**Limitations**:
- OpenAI models only
- Requires ChatGPT subscription
- Cloud execution sends code to OpenAI servers
- No local model support

**Supported Models**: o4-mini (default), o3, GPT-4.1

---

### Gemini CLI
**Best for**: Cost-conscious developers wanting a generous free tier with search capabilities

**Key Strengths**:
- Most generous free tier: 60 req/min, 1000 req/day with Google account
- Built-in Google Search grounding for real-time information
- 1M token context window for large codebases
- Multimodal: PDFs, images, sketches to apps
- Conversation checkpointing for multi-day work
- GEMINI.md project context files
- GitHub Action integration for automated PR reviews
- MCP extensibility with Imagen, Veo, Lyria

**Limitations**:
- Gemini models only
- Search grounding can be overzealous for internal codebases
- No subagent/multi-agent capabilities
- No scheduled automations

**Supported Models**: Gemini 3 Flash/Pro, Gemini 2.5 (Google models only)

---

### Goose
**Best for**: Teams wanting fully open-source agents with MCP extensibility

**Key Strengths**:
- Fully open source (Apache 2.0) with no vendor lock-in
- MCP-UI rendering: interactive widgets, forms, progress bars (desktop)
- Recipes: reusable, pre-defined workflows
- Custom distributions: build branded Goose distros
- Multi-model configuration: different LLMs for different tasks
- Planning-first approach with clarifying questions
- Battle-tested: Block deployed to 12,000 employees
- Desktop app + CLI flexibility

**Limitations**:
- Planning-first can feel slow for simple edits
- Steeper learning curve due to recipe system
- No native git auto-commit (requires configuration)
- Smaller ecosystem than Claude Code

**Supported Models**: Any LLM with API (Claude, GPT, Gemini, local models)

---

### Cline
**Best for**: VS Code users wanting human-in-the-loop control with browser automation

**Key Strengths**:
- Human-in-the-loop: approve every file change and terminal command
- Browser automation: launch browsers, click elements, capture screenshots
- Workspace checkpoints for safe experimentation
- MCP support for custom tools
- Multiple API providers via OpenRouter
- Code review with request changes / approve
- Plan/act mode toggle

**Limitations**:
- VS Code only (no standalone CLI)
- Approval-required model can slow workflow
- No subagent capabilities
- Limited to IDE context window

**Supported Models**: Claude, GPT, Gemini, AWS Bedrock, Azure, GCP Vertex, local Ollama (via OpenRouter)

---

### Roo Code
**Best for**: VS Code users wanting multi-agent capabilities and specialized modes

**Key Strengths**:
- Multi-agent orchestration within VS Code
- Specialized modes: Ask, Architect, Code, Debug, Orchestrator
- Auto-approve options for trusted operations
- Custom mode creation
- Full MCP support
- Multiple provider support
- Built on Cline foundation with enhanced features

**Limitations**:
- VS Code only
- Can be resource-intensive
- Learning curve for mode system
- Limited context compared to CLI tools

**Supported Models**: Claude, GPT, Gemini, local models (via various providers)

---

## Fixed-Price vs Pay-Per-Token Analysis

### Fixed-Price Subscriptions (All-you-can-use)
| Service | Price Range | Notes |
|---------|-------------|-------|
| **Kimi Code** | ¥49-199/month (~$7-28) | Chinese market focus; unlimited usage within tier |
| **GLM Code** | $3-60/month | Via Zhipu AI; OpenCode has native `opencode auth login` support |

### Pay-Per-Token / Usage-Based
| Service | Pricing Model | Notes |
|---------|---------------|-------|
| **Claude Code** | $20-200/month subscription OR API key | API usage metered by tokens |
| **Codex CLI** | Included in ChatGPT Plus/Pro ($20-200/month) | No separate billing; usage within subscription limits |
| **Cody** | Freemium + usage-based | Pro features require subscription |
| **Gemini CLI** | Free tier + API pricing | 1000 req/day free, then API rates |

### Bring Your Own Key (Free tools, you pay model costs)
| Service | Model Cost |
|---------|------------|
| **OpenCode** | Pay your chosen provider (OpenAI, Anthropic, etc.) |
| **Aider** | Pay your chosen provider |
| **Continue.dev** | Pay your chosen provider |
| **Cline** | Pay your chosen provider (often via OpenRouter) |
| **Roo Code** | Pay your chosen provider |
| **Goose** | Pay your chosen provider |

### Important Clarification: Open-Source Agents with Fixed-Price Models

**Open-source agents (Cline, Roo Code, Continue.dev, Aider, Goose) can use fixed-price subscriptions** by configuring them with Kimi Code or GLM Code API keys:

```bash
# Example: Using Kimi Code with Aider
export KIMI_API_KEY=your_kimi_key
aider --model kimi --api-key kimi=$KIMI_API_KEY

# Example: Using GLM Code with OpenCode
opencode auth login  # Select Zhipu AI Coding Plan
```

This "BYOK to fixed-price service" model gives you:
- Fixed monthly cost (predictable budgeting)
- No per-token anxiety
- Full open-source agent flexibility
- Access to capable models (GLM-4.7, Moonshot Kimi)

---

## Quick Decision Guide

### Choose **OpenCode** if you want:
- Maximum provider flexibility (75+ options)
- Privacy-first design
- Multi-session parallel work
- Session sharing for collaboration
- Native LSP integration

### Choose **Aider** if you want:
- Bulletproof Git integration with auto-commits
- Voice-to-code capabilities
- Repo map for large codebases
- Automatic linting/testing with auto-fix
- Most mature open-source option

### Choose **Claude Code** if you want:
- Deepest reasoning and subagent orchestration
- Rich plugin ecosystem
- Remote mobile control
- Extensive hook system for automation
- Best for complex, multi-step tasks

### Choose **Codex CLI** if you want:
- Parallel agent delegation at scale
- Scheduled automations
- GitHub-native PR review integration
- Cloud sandbox execution
- Already using ChatGPT subscription

### Choose **Gemini CLI** if you want:
- Zero-cost entry (generous free tier)
- Built-in web search grounding
- 1M token context window
- Multimodal input (images, PDFs)
- No credit card required to start

### Choose **Goose** if you want:
- Fully open source with Apache 2.0 license
- MCP-first extensibility
- Planning-first methodology
- Custom distribution building
- Enterprise-friendly licensing

### Choose **Cline** if you want:
- Human-in-the-loop approval for all changes
- Browser automation built-in
- VS Code native integration
- Maximum control over agent actions
- Checkpoint-based experimentation

### Choose **Roo Code** if you want:
- Multi-agent within VS Code
- Specialized modes for different tasks
- Auto-approve for trusted operations
- Enhanced Cline foundation
- Custom mode creation

---

## Glossary

- **TUI**: Terminal User Interface - interactive command-line interface
- **CLI**: Command Line Interface
- **BYOK**: Bring Your Own Key - use your own API keys
- **MCP**: Model Context Protocol - standard for connecting AI to external tools
- **LSP**: Language Server Protocol - provides IDE features like autocomplete
- **Subagent**: An AI agent spawned by another agent for specific tasks
- **Worktree**: Git feature for multiple working directories from one repo
- **YOLO Mode**: Auto-approve all agent actions (use with caution)
- **Repo Map**: Structural understanding of codebase for better navigation

---

## See Also

- [MODELS.md](MODELS.md) - Detailed AI model pricing and specifications
- [AI_AGENT_TRICKS.md](AI_AGENT_TRICKS.md) - Tips and tricks for working with AI coding agents
- [MODELS_OPEN_SOURCE.md](MODELS_OPEN_SOURCE.md) - Open-source model guide
- [MODELS_WITHIN_128_GiB_RAM.md](MODELS_WITHIN_128_GiB_RAM.md) - Models that fit in 128 GiB RAM
- [FEATURE_MATRIX.md](FEATURE_MATRIX.md) - Condensed feature comparison matrix

---

*Last updated: March 18, 2026*
