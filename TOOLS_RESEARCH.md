# AI Coding Agents - Comprehensive Research Document

*Research Date: March 1, 2026*

## Extended Feature Matrix

### Legend
- ✅ = Fully Supported / Native Implementation
- ⚠️ = Partial Support / Limited / Via Extension or Plugin
- ❌ = Not Supported / Not Available
- [Source] = Links to official documentation or verified implementation details

---

## Part 1: Complete Feature Matrix

### Interface & Access

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Terminal UI (TUI) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ |
| CLI Non-Interactive | ✅ | ✅ | ⚠️ [^1] | ✅ | ✅ | ✅ | ❌ | ❌ | ⚠️ |
| VS Code Extension | ✅ | ⚠️ [^2] | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ |
| JetBrains/Other IDE | ⚠️ [^3] | ⚠️ | ❌ | ⚠️ | ❌ | ⚠️ | ❌ | ❌ | ✅ [^4] |
| Desktop Application | ✅ | ❌ | ❌ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| Web Interface | ⚠️ [^5] | ❌ | ⚠️ [^6] | ✅ | ❌ | ❌ | ❌ | ❌ | ✅ |

[^1]: Claude Code supports programmatic access via Agent SDK and `-p` flag for non-interactive use
[^2]: Aider has "watch mode" for IDE integration, not a native extension
[^3]: OpenCode supports ACP protocol for Zed and JetBrains via `opencode kiml acp`
[^4]: Kimi Code supports ACP protocol for IDE integration
[^5]: OpenCode supports `opencode web` command for browser access
[^6]: Claude Code has a web-based remote control feature in preview

---

### Model Support & Pricing

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Multi-Provider (75+) | ✅ [^7] | ✅ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ |
| Claude Models | ✅ | ✅ | ✅ [^8] | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ |
| OpenAI/GPT Models | ✅ | ✅ | ❌ | ✅ [^9] | ❌ | ✅ | ✅ | ✅ | ❌ |
| Gemini Models | ✅ | ✅ | ❌ | ❌ | ✅ [^10] | ✅ | ✅ | ✅ | ❌ |
| Kimi Models | ⚠️ | ⚠️ | ❌ | ❌ | ❌ | ⚠️ | ⚠️ | ⚠️ | ✅ [^11] |
| Local Models (Ollama) | ✅ | ✅ [^12] | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ |
| BYOK Support | ✅ | ✅ | ⚠️ [^13] | ❌ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Free Tier Available | ✅ | ✅ | ❌ | ❌ | ✅ [^14] | ✅ | ✅ | ✅ | ❌ |
| Fixed-Price Subscription | ⚠️* | ⚠️* | ❌ | ❌ | ❌ | ⚠️* | ⚠️* | ⚠️* | ✅ [^15] |
| Open Source License | ✅ MIT | ✅ Apache 2 | ❌ | ✅ Apache 2 | ✅ Apache 2 | ✅ Apache 2 | ✅ | ✅ | ✅ |

*Via BYOK to Kimi Code or GLM Code

[^7]: OpenCode uses Models.dev for 75+ provider support
[^8]: Claude Code only supports Anthropic models (Sonnet, Opus, Haiku)
[^9]: Codex CLI supports o4-mini (default), o3, and GPT-4.1
[^10]: Gemini CLI only supports Gemini models (Flash, Pro)
[^11]: Kimi Code uses kimi-k2.5 and kimi-for-coding models
[^12]: Aider supports local models via Ollama integration
[^13]: Claude Code supports API key access but primarily uses subscription
[^14]: Gemini CLI offers 60 req/min, 1000 req/day free tier
[^15]: Kimi Code pricing: ¥49-199/month (~$7-28)

---

### File Operations

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Read Files | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Write Files | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Edit/Modify Files | ✅ | ✅ | ✅ [^16] | ✅ [^17] | ✅ | ✅ | ✅ | ✅ | ✅ |
| Search/Grep | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Glob Patterns | ✅ | ✅ | ✅ | ✅ | ⚠️ | ✅ | ✅ | ✅ | ✅ |
| LSP Integration | ✅ [^18] | ❌ | ⚠️ [^19] | ⚠️ [^20] | ❌ | ❌ | ⚠️ [^21] | ⚠️ | ❌ |
| Repo Map | ⚠️ | ✅ [^22] | ⚠️ | ⚠️ | ❌ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

[^16]: Claude Code uses unified diff patches for edits
[^17]: Codex CLI uses `apply_patch` tool for file modifications
[^18]: OpenCode has native LSP with 30+ auto-configured servers
[^19]: Claude Code added native LSP support in December 2025 (v2.0.74)
[^20]: Codex CLI supports LSP via MCP servers
[^21]: Cline accesses LSP through VS Code's built-in language services
[^22]: Aider pioneered repo map technology for codebase understanding

---

### Code Execution & Environment

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Bash/Shell Execution | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Shell Command Mode | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ [^23] |
| Cloud Sandbox | ❌ | ❌ | ⚠️ [^24] | ✅ [^25] | ❌ | ❌ | ❌ | ❌ | ❌ |
| Local Sandbox (Seatbelt) | ❌ | ❌ | ✅ [^26] | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Auto Lint on Change | ✅ [^27] | ✅ | ✅ [^28] | ✅ | ❌ | ⚠️ | ✅ | ✅ | ⚠️ |
| Auto Test on Change | ✅ | ✅ | ✅ | ✅ | ❌ | ⚠️ | ✅ | ✅ | ⚠️ |
| Test Failure Auto-Fix | ⚠️ | ✅ [^29] | ⚠️ | ✅ [^30] | ❌ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

[^23]: Kimi Code: "Press `Ctrl-X` to toggle between AI and shell mode"
[^24]: Claude Code cloud features are optional; local-first by default
[^25]: Codex CLI uses cloud sandboxes for agent execution
[^26]: Claude Code uses Seatbelt sandbox on macOS
[^27]: OpenCode supports formatters via configuration
[^28]: Claude Code supports auto-lint via PostToolUse hooks
[^29]: Aider automatically runs tests and fixes failures
[^30]: Codex CLI auto-fixes in cloud sandbox environment

---

### Git Integration

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Automatic Git Commits | ⚠️ [^31] | ✅ [^32] | ⚠️ | ✅ | ❌ | ✅ | ⚠️ | ⚠️ | ⚠️ |
| Auto Commit Messages | ⚠️ | ✅ [^33] | ⚠️ | ✅ | ❌ | ✅ | ⚠️ | ⚠️ | ⚠️ |
| Git Worktrees Support | ❌ | ✅ [^34] | ✅ [^35] | ✅ [^36] | ❌ | ❌ | ❌ | ❌ | ❌ |
| Branch Management | ⚠️ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| PR Creation | ⚠️ [^37] | ⚠️ | ✅ [^38] | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| GitHub Integration | ⚠️ [^39] | ⚠️ | ✅ [^40] | ✅ [^41] | ✅ [^42] | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

[^31]: OpenCode: via commands or GitHub MCP server
[^32]: Aider: "Aider automatically commits changes with sensible commit messages"
[^33]: Aider generates commit messages automatically
[^34]: Aider supports git worktrees for isolated branches
[^35]: Claude Code: worktree isolation for subagents
[^36]: Codex CLI: "Each agent works on its own git worktree"
[^37]: OpenCode: via GitHub agent or MCP
[^38]: Claude Code: via plugins
[^39]: OpenCode: `opencode github install` for GitHub Actions
[^40]: Claude Code: GitHub integration via plugins
[^41]: Codex CLI: "Tag @Codex in a pull request, and it reviews the code"
[^42]: Gemini CLI: GitHub Action for automated PR reviews

---

### AI Capabilities

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Multi-Agent/Subagents | ✅ [^43] | ❌ | ✅ [^44] | ✅ [^45] | ❌ | ⚠️ [^46] | ❌ | ✅ [^47] | ✅ [^48] |
| Parallel Execution | ✅ | ❌ | ✅ [^49] | ✅ [^50] | ❌ | ❌ | ❌ | ⚠️ | ⚠️ |
| Background Agents | ⚠️ | ❌ | ✅ [^51] | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Planning Mode | ✅ [^52] | ✅ [^53] | ✅ [^54] | ✅ [^55] | ❌ | ✅ | ❌ | ✅ [^56] | ✅ |
| Context Compaction | ⚠️ [^57] | ⚠️ | ✅ [^58] | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Reasoning Control | ⚠️ | ✅ [^59] | ⚠️ | ✅ [^60] | ❌ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

[^43]: OpenCode: `@general` subagent for complex tasks
[^44]: Claude Code: Built-in subagents (Explore, Plan, General-purpose)
[^45]: Codex CLI: Parallel agent execution
[^46]: Goose: Recipes for reusable workflows
[^47]: Roo Code: Multi-agent with specialized modes
[^48]: Kimi Code: Subagent support
[^49]: Claude Code: Background agents run concurrently
[^50]: Codex CLI: "Assign 5 tasks to 5 agents at once"
[^51]: Claude Code: "Background agents run concurrently while you continue working"
[^52]: OpenCode: `plan` mode (Tab to switch)
[^53]: Aider: Structured mode for planning
[^54]: Claude Code: Planning mode with dedicated subagent
[^55]: Codex CLI: Plan mode with reasoning levels
[^56]: Roo Code: Architect mode for planning
[^57]: OpenCode: `compaction.auto` configuration
[^58]: Claude Code: `/compact` command with auto-compaction at 95%
[^59]: Aider: `/thinking-tokens` and `/reasoning-effort` commands
[^60]: Codex CLI: Customizable reasoning levels per task

---

### Input Methods

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Text Prompts | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Voice Input | ❌ | ✅ [^61] | ❌ | ⚠️ [^62] | ❌ | ❌ | ❌ | ❌ | ❌ |
| Image Input | ❌ | ✅ [^63] | ✅ [^63a] | ❌ | ✅ [^64] | ❌ | ✅ | ✅ | ⚠️ |
| PDF/Documents | ❌ | ⚠️ | ❌ | ❌ | ✅ [^65] | ❌ | ⚠️ | ⚠️ | ⚠️ |
| Web Page Context | ✅ [^66] | ✅ [^67] | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ✅ |

[^61]: Aider: "Speak with aider about your code! Request new features, test cases or bug fixes using your voice"
[^62]: Codex CLI: Voice transcription marked as experimental
[^63]: Aider: "Add images and web pages to the chat to provide visual context"
[^63a]: Claude Code: Read tool supports image files (PNG, JPG, etc.) and presents them visually to the multimodal LLM
[^64]: Gemini CLI: Multimodal input including PDFs and images
[^65]: Gemini CLI: "Generate apps from PDFs, images, or hand-drawn sketches"
[^66]: OpenCode: `webfetch` tool
[^67]: Aider: Can add web pages as context

---

### Browser & External Tools

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Browser Automation | ❌ | ❌ | ⚠️ [^68] | ⚠️ [^69] | ❌ | ⚠️ [^70] | ✅ [^71] | ⚠️ | ⚠️ |
| Web Search | ⚠️ [^72] | ⚠️ | ⚠️ [^73] | ⚠️ [^74] | ✅ [^75] | ⚠️ | ⚠️ | ⚠️ | ✅ |
| Screenshot Capture | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ⚠️ | ❌ |
| MCP Support | ✅ [^76] | ❌ | ✅ [^77] | ✅ [^78] | ✅ | ✅ [^79] | ✅ | ✅ | ✅ [^80] |
| ACP Support | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ [^81] |

[^68]: Claude Code: Browser automation via plugins
[^69]: Codex CLI: "Skills extend Codex beyond code"
[^70]: Goose: Via MCP servers
[^71]: Cline: "Includes browser automation (launching browsers, clicking elements, capturing screenshots)"
[^72]: OpenCode: Via Exa MCP or webfetch
[^73]: Claude Code: Via web fetch MCP
[^74]: Codex CLI: "Cached web search"
[^75]: Gemini CLI: "Built-in Google Search grounding"
[^76]: OpenCode: `kimi mcp` subcommand group
[^77]: Claude Code: Full MCP support via `mcpServers` configuration
[^78]: Codex CLI: MCP support added February 2026
[^79]: Goose: Native MCP integration
[^80]: Kimi Code: `kimi mcp` commands for server management
[^81]: Kimi Code: Agent Client Protocol for IDE integration

---

### Session Management

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Session Persistence | ✅ [^82] | ✅ | ✅ [^83] | ✅ | ✅ [^84] | ✅ | ✅ | ✅ | ✅ |
| Session Resume | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Session Sharing (Links) | ✅ [^85] | ❌ | ❌ | ⚠️ [^86] | ❌ | ❌ | ❌ | ❌ | ⚠️ |
| Multi-Session Parallel | ✅ [^87] | ❌ | ✅ [^88] | ✅ [^89] | ❌ | ❌ | ❌ | ⚠️ | ⚠️ |
| Conversation Checkpoints | ✅ | ✅ | ✅ [^90] | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Checkpoint Rollback | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | ⚠️ | ✅ | ✅ | ⚠️ |

[^82]: OpenCode: Sessions stored with `session` command group
[^83]: Claude Code: Checkpoints for rollback
[^84]: Gemini CLI: "Conversation checkpointing"
[^85]: OpenCode: Share links via `/share` command
[^86]: Codex CLI: Share via GitHub integration
[^87]: OpenCode: "Multi-session: Run multiple agents in parallel"
[^88]: Claude Code: Agent teams with independent contexts
[^89]: Codex CLI: "Assign 5 tasks to 5 agents at once, all working simultaneously"
[^90]: Claude Code: Automatic checkpoints before changes

---

### Automation & Workflows

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Custom Commands/Skills | ✅ [^91] | ✅ [^92] | ✅ [^93] | ✅ [^94] | ❌ | ✅ [^95] | ✅ [^96] | ✅ | ⚠️ |
| Slash Commands | ✅ [^97] | ✅ [^98] | ✅ [^99] | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ |
| Event Hooks | ✅ [^100] | ❌ | ✅ [^101] | ⚠️ | ❌ | ❌ | ❌ | ⚠️ | ❌ |
| Scheduled Automations | ❌ | ❌ | ❌ | ✅ [^102] | ❌ | ❌ | ❌ | ❌ | ❌ |
| Recipe/Workflow System | ⚠️ | ❌ | ⚠️ | ✅ [^103] | ❌ | ✅ [^104] | ❌ | ❌ | ❌ |
| Plugin Marketplace | ⚠️ [^105] | ❌ | ✅ [^106] | ⚠️ | ❌ | ❌ | ❌ | ❌ | ❌ |

[^91]: OpenCode: `opencode.json` command configuration
[^92]: Aider: Slash commands like `/add`, `/drop`, `/commit`
[^93]: Claude Code: Skills system with SKILL.md files
[^94]: Codex CLI: Skills system with `$skill-name` invocation
[^95]: Goose: Recipes for reusable workflows
[^96]: Cline: Custom modes with specific tool configurations
[^97]: OpenCode: Commands defined in config or markdown files
[^98]: Aider: "/command" format for built-in operations
[^99]: Claude Code: "/command" format (e.g., `/agents`, `/compact`)
[^100]: OpenCode: Plugin hook system
[^101]: Claude Code: 8 hook types (PreToolUse, PostToolUse, SessionStart, etc.)
[^102]: Codex CLI: "Set Codex to run recurring tasks on a schedule"
[^103]: Codex CLI: Skills bundle instructions, resources, and scripts
[^104]: Goose: Recipes as composable automation playbooks
[^105]: OpenCode: Plugin system via npm
[^106]: Claude Code: Official plugin marketplace

---

### Security & Permissions

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Granular Permissions | ✅ [^107] | ⚠️ | ✅ [^108] | ✅ [^109] | ⚠️ | ✅ | ✅ | ✅ | ✅ |
| Per-Action Approval | ✅ | ⚠️ | ✅ | ✅ | ⚠️ | ✅ | ✅ [^110] | ✅ | ✅ |
| Auto-Approve Options | ⚠️ | ❌ | ⚠️ | ⚠️ | ❌ | ❌ | ❌ | ⚠️ | ⚠️ |
| YOLO Mode (Dangerous) | ⚠️ [^111] | ❌ | ⚠️ [^112] | ⚠️ | ❌ | ❌ | ❌ | ⚠️ | ❌ |
| Secret Detection | ✅ [^113] | ❌ | ✅ [^114] | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Sandbox Restrictions | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |

[^107]: OpenCode: `permission` configuration with ask/allow/deny
[^108]: Claude Code: `permissionMode` with 5 modes including `bypassPermissions`
[^109]: Codex CLI: Sandbox with configurable permissions
[^110]: Cline: "Approve everything" - every change requires explicit approval
[^111]: OpenCode: `permission: {"*": "allow"}`
[^112]: Claude Code: `--dangerously-skip-permissions` flag
[^113]: OpenCode: Hook-based secret detection
[^114]: Claude Code: Hook-based with pattern matching for sk-, ghp_, AKIA

---

### Context & Project Understanding

| Feature | OpenCode | Aider | Claude Code | Codex CLI | Gemini CLI | Goose | Cline | Roo Code | Kimi Code |
|---------|:--------:|:-----:|:-----------:|:---------:|:----------:|:-----:|:-----:|:--------:|:---------:|
| Project Config File | ✅ [^115] | ⚠️ [^116] | ✅ [^117] | ✅ [^118] | ✅ [^119] | ✅ | ✅ | ✅ | ✅ [^120] |
| Context Window | 200K | 200K | 200K-1M [^121] | 192K | 1M [^122] | Varies | Varies | Varies | 200K+ |
| Repo Structure Analysis | ✅ | ✅ [^123] | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ✅ |
| Cross-File Dependencies | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Documentation Awareness | ⚠️ | ⚠️ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |

[^115]: OpenCode: `opencode.json` with $schema validation
[^116]: Aider: `.aider.conf.yml` for configuration
[^117]: Claude Code: `CLAUDE.md` and `.claude/settings.json`
[^118]: Codex CLI: `AGENTS.md` configuration file
[^119]: Gemini CLI: `GEMINI.md` files
[^120]: Kimi Code: Configuration via `kimi` command and files
[^121]: Claude Code: 200K default, up to 1M via API
[^122]: Gemini CLI: "1M token context window"
[^123]: Aider: "Aider makes a map of your entire codebase"

---

## Part 2: Summary Statistics

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

## Part 3: Quick Decision Guide

| Use Case | Tool | Why |
|----------|------|-----|
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

## See Also

- [AGENT_COMPARISON.md](AGENT_COMPARISON.md) - Side-by-side comparison with analysis and decision guide
- [FEATURE_MATRIX.md](FEATURE_MATRIX.md) - Condensed feature comparison matrix
- [FEATURES.md](FEATURES.md) - In-depth feature explanations and technical concepts
- [MODELS.md](MODELS.md) - AI model pricing and specifications
- [AI_AGENT_TRICKS.md](AI_AGENT_TRICKS.md) - Tips and tricks for working with AI coding agents
- [MODELS_OPEN_SOURCE.md](MODELS_OPEN_SOURCE.md) - Open-source model guide
- [MODELS_WITHIN_128_GiB_RAM.md](MODELS_WITHIN_128_GiB_RAM.md) - Models that fit in 128 GiB RAM

---

*Last Updated: March 18, 2026*
