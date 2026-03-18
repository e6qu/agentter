# Feature Explanations: AI Coding Agents

*Research Date: March 1, 2026*

This document provides detailed, sourced explanations of features, technical concepts, and architectural patterns found in AI coding agents.

---

## Table of Contents

1. [Core Interface Concepts](#core-interface-concepts)
2. [Code Understanding Technologies](#code-understanding-technologies)
3. [AI Capabilities](#ai-capabilities)
4. [Session Management](#session-management)
5. [Integration Protocols](#integration-protocols)
6. [Security & Execution Models](#security--execution-models)
7. [Emerging Concepts](#emerging-concepts)

---

## Core Interface Concepts

### Terminal UI (TUI)

A Terminal User Interface provides interactive graphical elements within a terminal environment. Unlike traditional CLI tools that accept commands and return output, TUIs use libraries (such as Ratatui for Rust, Bubble Tea for Go, or Textual for Python) to render interactive elements including:

- Scrollable text areas with syntax highlighting
- Interactive menus and command palettes
- Real-time streaming output with formatting
- Split-pane layouts showing code and conversation
- Status bars showing context usage, model information, and tool states

Source: [OpenCode Documentation](https://opencode.ai/docs/) describes their TUI as providing "a terminal user interface" with "scroll speed" and "diff style" configuration options.

### CLI Non-Interactive Mode

Non-interactive mode allows the tool to execute a single prompt or command and return results without launching the full interactive interface. This enables:

- Scripting and automation workflows
- Integration with CI/CD pipelines
- Batch processing of multiple tasks
- Use as a subprocess by other applications

Example from OpenCode documentation: `opencode run "Explain how closures work in JavaScript"` executes the prompt and returns the response without entering interactive mode.

Source: [OpenCode CLI Documentation](https://opencode.ai/docs/cli/)

### Shell Command Mode

A distinct operating mode where the interface functions as a traditional shell (bash/zsh) rather than an AI assistant interface. The user can toggle between modes using keyboard shortcuts (Ctrl-X in Kimi Code) to:

- Execute shell commands directly without natural language processing overhead
- Maintain terminal workflow while having AI assistance available
- Reduce latency for simple command execution

Source: [Kimi Code Documentation](https://github.com/MoonshotAI/kimi-cli): "You can switch the shell command mode by pressing `Ctrl-X`. In this mode, you can directly run shell commands without leaving Kimi Code CLI."

---

## Code Understanding Technologies

### Repository Map (Repo Map)

A repository map is a condensed, structured representation of a codebase that helps AI agents understand project structure without reading every file. According to Aider's documentation:

> "Aider uses a concise map of your whole git repository that includes the most important classes and functions along with their types and call signatures."

#### Technical Implementation

The repo map is constructed through several stages:

1. **Symbol Extraction**: Using Tree-sitter parsers to extract class definitions, function signatures, variable declarations, and their relationships from source files.

2. **Dependency Graph Construction**: Building a graph where:
   - Nodes represent source files
   - Edges connect files that have dependencies (imports, function calls)

3. **Importance Ranking**: Applying graph algorithms (similar to PageRank) to identify the most referenced symbols across the codebase.

4. **Token Budget Optimization**: Selecting the most relevant portions of the map to fit within the LLM's context window (default 1k tokens in Aider, adjustable via `--map-tokens`).

Source: [Aider Repo Map Documentation](https://aider.chat/docs/repomap.html)

#### Example Output

```
aider/coders/base_coder.py:
⋮...
│class Coder:
│    abs_fnames = None
⋮...
│    @classmethod
│    def create(
│        self,
│        main_model,
│        edit_format,
│        io,
│        skip_model_availabily_check=False,
│        **kwargs,
⋮...
│    def abs_root_path(self, path):
⋮...
│    def run(self, with_message=None):
⋮...
```

### Language Server Protocol (LSP)

LSP is a JSON-RPC based protocol that standardizes communication between development tools (clients) and language-specific analysis servers. Created by Microsoft in 2016, it reduces the implementation burden from M×N (languages × editors) to M+N.

#### Core Operations

According to the LSP specification and documentation:

| Method | Purpose |
|--------|---------|
| `textDocument/definition` | Jump to symbol definition location |
| `textDocument/references` | Find all usages of a symbol |
| `textDocument/hover` | Display type information and documentation |
| `textDocument/documentSymbol` | List all symbols in a file |
| `textDocument/completion` | Provide code completion suggestions |
| `textDocument/publishDiagnostics` | Report errors and warnings |
| `workspace/symbol` | Search symbols across entire project |

Source: [Microsoft LSP Documentation](https://microsoft.github.io/language-server-protocol/)

#### LSP in AI Coding Agents

When AI agents integrate with LSP:

1. The agent queries the language server for semantic information rather than relying on text search
2. Operations like "find all references" return precise locations instead of grep-style text matches
3. Type information helps the agent understand code semantics without reading entire files
4. Diagnostics provide real-time feedback on code correctness

According to Amir Teymoori's analysis: "Finding all call sites of a function takes approximately 50ms with LSP compared to 45 seconds with traditional text search."

Source: [LSP: The Secret Weapon for AI Coding Tools](https://amirteymoori.com/lsp-language-server-protocol-ai-coding-tools/)

### Vector Search and Code Indexing

Vector search enables semantic code search by encoding code snippets into high-dimensional vectors using embedding models. Unlike text search that matches keywords, vector search finds semantically similar code.

#### Implementation Approaches

1. **Code Embeddings**: Using models like CodeBERT, CodeT5, or OpenAI's embedding models to convert code into vectors
2. **Indexing**: Storing vectors in specialized databases (Pinecone, Weaviate, pgvector, FAISS)
3. **Query Processing**: Converting natural language queries into vectors and finding nearest neighbors

#### Tools Using Vector Search

- **Mutable.ai**: Uses "language maps" combining wiki-style documentation with vector search for context retrieval
- **LSP-AI**: Implements "code crawling and a vector search for better context gathering" according to their roadmap
- **Sourcegraph Cody**: Uses embeddings for codebase search (though their specific implementation details are proprietary)

Source: [Mutable.ai Blog](https://news.ycombinator.com/item?id=40998497): "It turns out using a wiki to find context for an LLM overcomes many of the weaknesses of our previous approach"

### Tree-sitter

Tree-sitter is a parser generator tool and incremental parsing library developed by GitHub. It builds concrete syntax trees for source files and efficiently updates them as the file changes.

#### Use in AI Coding Agents

Tree-sitter enables:

1. **Syntax-Aware Code Analysis**: Understanding code structure (functions, classes, imports) rather than treating code as plain text
2. **Symbol Extraction**: Identifying definitions and references for repo maps
3. **Multi-Language Support**: Supporting 40+ programming languages with consistent APIs
4. **Incremental Parsing**: Efficiently updating parse trees as files change

Source: [Tree-sitter Documentation](https://tree-sitter.github.io/tree-sitter/)

---

## AI Capabilities

### Subagents

Subagents (also called "agents" in some tools) are specialized AI instances that run in isolated context windows with specific system prompts and tool configurations.

#### Claude Code Subagent Architecture

According to Claude Code documentation:

> "Subagents are specialized AI assistants that handle specific types of tasks. Each subagent runs in its own context window with a custom system prompt, specific tool access, and independent permissions."

Key characteristics:
- Run in isolated context windows (separate from main conversation)
- Have restricted tool access (e.g., read-only vs full access)
- Can use different models (e.g., Haiku for fast exploration, Opus for complex tasks)
- Return summaries to the parent agent rather than full conversation history

Source: [Claude Code Subagents Documentation](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

#### Types of Subagents

| Subagent | Model | Tools | Purpose |
|----------|-------|-------|---------|
| Explore | Haiku | Read-only | Codebase search and analysis |
| Plan | Inherits | Read-only | Planning mode research |
| General-purpose | Inherits | All | Complex multi-step tasks |
| Bash | Inherits | Shell | Terminal command execution |

Source: [Claude Code Built-in Subagents](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

### Agent Coordination and Orchestration

Agent coordination refers to patterns for managing multiple AI agents working together on complex tasks.

#### Coordination Patterns

1. **Hierarchical Delegation**: Parent agent delegates subtasks to specialized child agents
2. **Parallel Execution**: Multiple agents working on independent subtasks simultaneously
3. **Pipeline/Chain**: Output from one agent feeds into the next agent
4. **Competition**: Multiple agents attempt the same task, best result selected

#### Implementation in Tools

**Claude Code Agent Teams**: According to documentation, "For tasks that need sustained parallelism or exceed your context window, agent teams give each worker its own independent context."

**OpenCode Multi-Session**: OpenCode supports "run multiple agents in parallel on the same project without conflicts — one refactoring while another writes tests."

Source: [Claude Code Agent Teams](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents), [OpenCode Multi-Session](https://opencode.ai/docs/)

### Ephemeral Agents

Ephemeral agents are temporary agent instances created for a specific task and destroyed afterward. Key characteristics:

- Short lifecycle (single task or conversation)
- No persistent memory between invocations
- Clean state for each task (no contamination from previous work)
- Used for exploration, testing, or isolated operations

Source: [Claude Code Subagent Documentation](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents): "Each subagent invocation creates a new instance with fresh context."

### Persistent Memory

Persistent memory allows agents to retain information across conversations and sessions. Claude Code implements this through:

| Scope | Location | Use Case |
|-------|----------|----------|
| `user` | `~/.claude/agent-memory/<agent-name>/` | Cross-project knowledge |
| `project` | `.claude/agent-memory/<agent-name>/` | Project-specific, version controlled |
| `local` | `.claude/agent-memory-local/<agent-name>/` | Project-specific, not version controlled |

Source: [Claude Code Persistent Memory](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

### Context Compaction

Context compaction (also called "summarization" or "pruning") is the process of reducing conversation history to fit within context window limits while preserving essential information.

#### Implementation

According to OpenCode documentation:

```json
{
  "compaction": {
    "auto": true,
    "prune": true,
    "reserved": 10000
  }
}
```

- **Auto**: Automatically compact when context is full
- **Prune**: Remove old tool outputs to save tokens
- **Reserved**: Token buffer to avoid overflow during compaction

Source: [OpenCode Compaction Configuration](https://opencode.ai/docs/config/)

### Image Input

Several AI coding agents support image input, allowing users to provide visual context alongside text prompts:

- **Aider**: Supports adding images and web pages to chat for visual context
- **Claude Code**: Supports reading image files (PNG, JPG, etc.) via its Read tool, which presents image contents visually to the multimodal LLM
- **Gemini CLI**: Full multimodal input including PDFs, images, and hand-drawn sketches
- **Cline / Roo Code**: Support image input via their VS Code extension interfaces

Source: [Aider Documentation](https://aider.chat/docs/), [Claude Code Read Tool Documentation](https://docs.anthropic.com/en/docs/claude-code/)

---

## Session Management

### Session Persistence

Session persistence refers to the ability to save and resume conversation state, including:

- Conversation history
- File modifications
- Tool configurations
- Environment state

Source: [OpenCode Session Management](https://opencode.ai/docs/cli/): Sessions can be listed, exported as JSON, and imported from files or share URLs.

### Git Worktrees

Git worktrees allow multiple working directories connected to a single repository. This enables:

- Parallel development on different branches
- Isolated agent workspaces without cloning the repository multiple times
- Automatic cleanup after agent tasks complete

According to Claude Code documentation: "Set `isolation: worktree` to run the subagent in a temporary git worktree, giving it an isolated copy of the repository."

Source: [Claude Code Worktree Isolation](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

### Conversation Checkpoints

Checkpoints are snapshots of conversation state that can be reverted to. They enable:

- Safe experimentation (try changes, revert if unsuccessful)
- Branching conversations (explore different approaches)
- Recovery from errors or hallucinations

Source: [OpenCode Checkpoint API](https://opencode.ai/docs/server/): `/session/:id/revert` endpoint for reverting to specific messages.

---

## Integration Protocols

### Model Context Protocol (MCP)

MCP is an open protocol developed by Anthropic for connecting AI assistants to external tools and data sources. It standardizes how agents discover and use tools.

#### MCP Server Types

| Transport | Description |
|-----------|-------------|
| stdio | Standard input/output communication |
| HTTP | Web-based communication with OAuth support |
| Streamable HTTP | HTTP with streaming capabilities |

#### MCP Capabilities

According to the MCP specification, servers can expose:

- **Tools**: Functions that perform actions (read files, query databases)
- **Resources**: Data sources (file contents, database records)
- **Prompts**: Pre-defined templates for common tasks

Source: [MCP Specification](https://modelcontextprotocol.io/)

### Agent Client Protocol (ACP)

ACP is a protocol specific to Kimi Code for IDE integration. According to their documentation:

> "Kimi Code CLI supports Agent Client Protocol out of the box. You can use it together with any ACP-compatible editor or IDE."

ACP enables communication between the CLI tool and IDE plugins via stdin/stdout using nd-JSON (newline-delimited JSON).

Source: [Kimi Code ACP Documentation](https://github.com/MoonshotAI/kimi-cli)

### Agent Communication Protocol (ACP) - Broader Concept

Beyond Kimi Code's specific ACP, the broader concept of Agent Communication Protocol refers to emerging standards for inter-agent communication. These protocols aim to standardize how autonomous AI agents discover, authenticate, and exchange structured messages with each other -- enabling multi-agent systems where agents from different vendors can collaborate on tasks. This is distinct from MCP (which connects agents to tools/data sources) in that ACP focuses on agent-to-agent communication.

### Language Server Agent Protocol (LSAP)

LSAP is an emerging protocol that transforms low-level LSP capabilities into high-level agent-native cognitive tools. According to the specification:

> "LSAP (Language Server Agent Protocol) is an open protocol that defines how AI coding agents interact with Language Servers. It transforms low-level LSP capabilities into high-level, Agent-Native cognitive tools."

Key difference: While LSP provides atomic operations (go to definition, find references), LSAP composes these into semantic operations like "analyze impact of changing this function."

Source: [LSAP GitHub Repository](https://github.com/lsp-client/LSAP)

---

## Security & Execution Models

### Sandbox Models

#### Cloud Sandbox (Codex CLI)

According to OpenAI's Codex documentation:

> "Codex CLI uses a native, open-source and configurable system-level sandbox. By default, Codex agents are limited to editing files in their working folder or branch."

Characteristics:
- Isolated containerized environment
- Network access restrictions
- File system boundaries
- Cached web search results

Source: [OpenAI Codex Documentation](https://openai.com/index/introducing-the-codex-app/)

#### Local Sandbox (Claude Code Seatbelt)

Claude Code uses macOS Seatbelt for local sandboxing. Seatbelt is a macOS kernel-level sandboxing framework (also known as `sandbox_init` / `sandbox-exec`) that enforces mandatory access controls on processes. Claude Code applies Seatbelt profiles to restrict Bash tool execution, limiting file system access, network connectivity, and process spawning.

Characteristics:
- System-level permission controls via macOS kernel sandbox
- File access restrictions (scoped to project directory)
- Network access controls
- No cloud dependency

Source: [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code/)

### Permission Modes

Permission modes control how agents handle operations requiring user approval:

| Mode | Behavior |
|------|----------|
| `default` | Standard permission checking with prompts |
| `acceptEdits` | Auto-accept file edits |
| `dontAsk` | Auto-deny permission prompts |
| `bypassPermissions` | Skip all permission checks |
| `plan` | Read-only exploration mode |

Source: [Claude Code Permission Modes](https://docs.anthropic.com/en/docs/claude-code/en/sub-agents)

### YOLO Mode

YOLO (You Only Live Once) mode refers to configurations where all safety checks are disabled:

- All file edits auto-approved
- All shell commands auto-approved
- No confirmation prompts
- Useful for trusted environments, CI/CD, or when the user wants maximum speed

Warning: All tools caution against using YOLO mode in production or with sensitive codebases.

Source: [Claude Code CLI Reference](https://docs.anthropic.com/en/docs/claude-code/)

---

## Emerging Concepts

### Prompt Caching

Prompt caching is an optimization technique where the provider caches the prefix of a prompt (system prompt, tool definitions, conversation history) so that subsequent requests sharing the same prefix avoid reprocessing those tokens. This reduces latency and cost for long conversations.

Anthropic's implementation caches prompt prefixes automatically when the cached portion exceeds a minimum length. Cached input tokens are billed at a reduced rate (typically 90% discount). This is particularly impactful for coding agents with large system prompts and tool definitions that remain constant across turns.

### Deferred Tool Loading

Deferred tool loading is a pattern where an agent's full set of available tools is not loaded into context at startup. Instead, only tool names are listed initially, and the full schema (parameters, descriptions) is fetched on demand when a tool is likely to be needed. This reduces the baseline token cost of tool definitions in the system prompt, which can be significant when dozens of tools are available (e.g., MCP servers exposing many tools).

Claude Code implements this pattern: tools appear in `<available-deferred-tools>` messages and are fetched via a `ToolSearch` mechanism before first use.

### Agent Communication Protocol (ACP) - Emerging Standard

The Agent Communication Protocol concept extends beyond Kimi Code's specific implementation to a general class of protocols enabling structured communication between autonomous AI agents. Key goals include:

- **Discovery**: Agents can find and identify other agents and their capabilities
- **Authentication**: Secure identity verification between agents
- **Message Exchange**: Structured, typed messages with defined semantics
- **Task Delegation**: Protocols for requesting, accepting, and reporting on delegated work

This is an active area of development as multi-agent systems become more prevalent.

---

## Glossary

| Term | Definition |
|------|------------|
| **AST** | Abstract Syntax Tree - tree representation of code structure |
| **BYOK** | Bring Your Own Key - using personal API keys instead of bundled credits |
| **Context Window** | Maximum tokens an LLM can process in a single request |
| **Embedding** | Vector representation of text/code for semantic search |
| **Hook** | Event-triggered automation script |
| **LSP** | Language Server Protocol - standard for editor-language integration |
| **MCP** | Model Context Protocol - standard for AI tool integration |
| **Prompt Caching** | Provider-side caching of prompt prefixes to reduce latency and cost |
| **Repo Map** | Condensed structural representation of a codebase |
| **Skill** | Reusable prompt/workflow definition |
| **Subagent** | Specialized AI instance with isolated context |
| **TUI** | Terminal User Interface - graphical interface in terminal |
| **Worktree** | Git feature for multiple working directories |
| **YOLO Mode** | Configuration with all safety checks disabled |

---

## See Also

- [MODELS.md](MODELS.md) - Detailed AI model pricing and specifications
- [AI_AGENT_TRICKS.md](AI_AGENT_TRICKS.md) - Tips and tricks for working with AI coding agents
- [AGENT_COMPARISON.md](AGENT_COMPARISON.md) - Side-by-side tool comparison
- [FEATURE_MATRIX.md](FEATURE_MATRIX.md) - Condensed feature comparison matrix
- [TOOLS_RESEARCH.md](TOOLS_RESEARCH.md) - Comprehensive research with sourced footnotes

---

*Last Updated: March 18, 2026*
