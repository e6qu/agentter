# OpenCode

**Type**: Open Source CLI/TUI Tool  
**License**: MIT  
**Primary Developer**: anomalyco (SST/terminal.shop team)  
**Repository**: https://github.com/anomalyco/opencode  

## Overview

OpenCode is a Go-based CLI application that brings AI assistance to the terminal. It provides a TUI (Terminal User Interface) for interactive use and a CLI mode for scripting and automation.

Source: [OpenCode GitHub Repository](https://github.com/anomalyco/opencode): "OpenCode is a Go-based CLI application that brings AI assistance to your terminal."

## Key Features

### Multi-Provider Support

OpenCode supports 75+ LLM providers through Models.dev integration, including:
- Anthropic (Claude)
- OpenAI (GPT)
- Google (Gemini)
- Groq
- AWS Bedrock
- Azure OpenAI
- OpenRouter
- Local models via Ollama

Source: [OpenCode Documentation](https://opencode.ai/docs/): "It supports 75+ providers via Models.dev"

### Native LSP Integration

OpenCode includes 30+ pre-configured language servers that auto-install when opening matching file types:
- TypeScript/JavaScript
- Python
- Go
- Rust
- Ruby
- C/C++
- C#
- Java
- Kotlin
- Elixir
- Vue
- Svelte
- Astro
- PHP
- Lua
- Zig
- Nix
- Gleam
- Haskell
- OCaml
- Clojure

Source: [OpenCode LSP Documentation](https://opencode.ai/docs/): "OpenCode automatically detects and loads the correct Language Server for the LLM"

### Multi-Session Support

Run multiple agents in parallel on the same project without conflicts.

Source: [OpenCode Features](https://opencode.ai/docs/): "Multi-session: Run multiple agents in parallel on the same project without conflicts"

### Client/Server Architecture

The TUI is a client that connects to a server exposing an OpenAPI 3.1 spec endpoint. This enables:
- Multiple clients (TUI, web, IDE extensions)
- HTTP API access for integrations
- Remote access via `opencode serve`

Source: [OpenCode Server Documentation](https://opencode.ai/docs/server/): "The opencode serve command runs a headless HTTP server that exposes an OpenAPI endpoint"

## Installation

```bash
# Quick install
curl -fsSL https://opencode.ai/install | bash

# Homebrew (macOS/Linux)
brew install anomalyco/tap/opencode

# npm
npm i -g opencode-ai@latest

# Windows (Scoop)
scoop install opencode
```

Source: [OpenCode Installation](https://opencode.ai/docs/)

## Configuration

### Config File Locations

Configuration files are merged in this precedence order (later overrides earlier):

1. Remote config (from `.well-known/opencode`)
2. Global config (`~/.config/opencode/opencode.json`)
3. Custom config (`OPENCODE_CONFIG` env var)
4. Project config (`opencode.json` in project)
5. `.opencode` directories
6. Inline config (`OPENCODE_CONFIG_CONTENT` env var)

Source: [OpenCode Config Documentation](https://opencode.ai/docs/config/)

### Example Configuration

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "anthropic/claude-sonnet-4-5",
  "autoupdate": true,
  "server": {
    "port": 4096
  },
  "mcp": {
    "context7": {
      "type": "local",
      "command": ["npx", "-y", "@upstash/context7-mcp"]
    }
  }
}
```

## API and Server

### HTTP Server

Start a headless server:

```bash
opencode serve [--port <number>] [--hostname <string>] [--cors <origin>]
```

Default port: 4096  
Default hostname: 127.0.0.1

Source: [OpenCode Server Documentation](https://opencode.ai/docs/server/)

### API Endpoints

The server exposes these main API categories:

| Category | Endpoints |
|----------|-----------|
| Global | `/global/health`, `/global/event` |
| Project | `/project`, `/project/current` |
| Sessions | `/session`, `/session/:id`, `/session/:id/message` |
| Files | `/file`, `/find`, `/find/file`, `/find/symbol` |
| Agents | `/agent` |
| LSP/MCP | `/lsp`, `/mcp` |
| TUI | `/tui/append-prompt`, `/tui/submit-prompt` |

Source: [OpenCode Server API](https://opencode.ai/docs/server/)

### Authentication

Set `OPENCODE_SERVER_PASSWORD` for HTTP basic auth:

```bash
OPENCODE_SERVER_PASSWORD=your-password opencode serve
```

Default username: `opencode`  
Override: `OPENCODE_SERVER_USERNAME`

## Customization

### Custom Agents

Define agents in `.opencode/agents/` or `~/.config/opencode/agents/`:

```markdown
---
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
tools:
  write: false
  edit: false
  bash: false
  read: true
---
You are in code review mode. Focus on:
- Code quality and best practices
- Potential bugs and edge cases
- Performance implications
```

Source: [OpenCode Modes Documentation](https://opencode.ai/docs/modes/)

### Custom Commands

Configure commands in `opencode.json`:

```json
{
  "command": {
    "test": {
      "template": "Run the full test suite with coverage report",
      "description": "Run tests with coverage",
      "agent": "build"
    }
  }
}
```

### MCP Servers

Add MCP servers via CLI:

```bash
# Add HTTP server
opencode mcp add --transport http context7 https://mcp.context7.com/mcp

# Add stdio server
opencode mcp add --transport stdio chrome-devtools -- npx chrome-devtools-mcp@latest

# List servers
opencode mcp list

# Remove server
opencode mcp remove chrome-devtools
```

Source: [OpenCode MCP Documentation](https://opencode.ai/docs/)

## Built-in Modes

### Build Mode

Default mode with all tools enabled for active development.

### Plan Mode

Restricted mode for analysis and planning:
- `write` - Disabled
- `edit` - Disabled (except `.opencode/plans/*.md`)
- `patch` - Disabled
- `bash` - Disabled

Switch modes with Tab key.

Source: [OpenCode Modes](https://opencode.ai/docs/modes/)

## Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENCODE_CONFIG` | Path to custom config file |
| `OPENCODE_SERVER_PASSWORD` | Enable basic auth |
| `OPENCODE_MODELS_URL` | Custom URL for models config |
| `OPENCODE_DISABLE_AUTOCOMPACT` | Disable context compaction |
| `OPENCODE_ENABLE_EXA` | Enable Exa web search |

Full list: [OpenCode CLI Documentation](https://opencode.ai/docs/cli/)

## Pricing

- **Base Cost**: Free and open source
- **Model Cost**: BYOK (Bring Your Own Key) - pay your chosen provider
- **Free Tier**: Unlimited usage (you pay only for model API calls)

## Sources and References

1. [OpenCode Official Website](https://opencode.ai/)
2. [OpenCode Documentation](https://opencode.ai/docs/)
3. [OpenCode GitHub Repository](https://github.com/anomalyco/opencode)
4. [OpenCode CLI Reference](https://opencode.ai/docs/cli/)
5. [OpenCode Server API](https://opencode.ai/docs/server/)
6. [OpenCode Configuration](https://opencode.ai/docs/config/)

---

*Last Updated: March 1, 2026*
