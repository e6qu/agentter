# Kimi Code

**Type**: Open Source CLI Tool  
**License**: Open Source (GitHub repository available)  
**Primary Developer**: Moonshot AI  
**Repository**: https://github.com/MoonshotAI/kimi-cli  
**Website**: https://www.moonshot.cn/kimi-code

## Overview

Kimi Code is Moonshot AI's terminal-based AI coding assistant. It features a unique shell command mode toggle, ACP protocol for IDE integration, and fixed-price subscription tiers.

Source: [Kimi Code GitHub Repository](https://github.com/MoonshotAI/kimi-cli)

## Key Features

### Shell Command Mode

Kimi Code provides a unique toggle between AI and shell modes:

> "You can switch the shell command mode by pressing `Ctrl-X`. In this mode, you can directly run shell commands without leaving Kimi Code CLI."

This enables:
- Direct shell command execution without natural language processing
- Reduced latency for simple commands
- Seamless workflow between AI assistance and traditional shell usage

Source: [Kimi Code Shell Mode](https://github.com/MoonshotAI/kimi-cli)

### Agent Client Protocol (ACP)

Native ACP support for IDE integration:

> "Kimi Code CLI supports Agent Client Protocol out of the box. You can use it together with any ACP-compatible editor or IDE."

Supported editors:
- Zed
- JetBrains (IntelliJ, PyCharm, etc.)

Source: [Kimi Code ACP](https://github.com/MoonshotAI/kimi-cli)

### Zsh Integration

Native Zsh plugin for AI-powered shell:

```bash
# Install plugin
git clone https://github.com/MoonshotAI/zsh-kimi-cli.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/kimi-cli

# Add to .zshrc
plugins=(... kimi-cli)
```

After installation, press `Ctrl-X` in Zsh to switch to agent mode.

Source: [Kimi Code Zsh Plugin](https://github.com/MoonshotAI/kimi-cli)

### VS Code Extension

Kimi Code provides a VS Code extension:

> "Kimi Code CLI can be integrated with Visual Studio Code via the Kimi Code VS Code Extension."

Source: [Kimi Code VS Code](https://github.com/MoonshotAI/kimi-cli)

## Installation

```bash
# Quick install
curl -LsSf https://code.kimi.com/install.sh | bash

# Via uv
uv tool install --python 3.13 kimi-cli

# Windows PowerShell
Invoke-RestMethod https://code.kimi.com/install.ps1 | Invoke-Expression
```

Source: [Kimi Code Installation](https://github.com/MoonshotAI/kimi-cli)

## Configuration

### Authentication

Login to configure API access:

```bash
kimi
# Then type: /login
```

Or configure via environment variables.

### MCP Configuration

Add MCP servers:

```bash
# Add HTTP MCP server
kimi mcp add --transport http context7 https://mcp.context7.com/mcp \
  --header "CONTEXT7_API_KEY: ctx7sk-your-key"

# Add stdio MCP server
kimi mcp add --transport stdio chrome-devtools -- npx chrome-devtools-mcp@latest

# List servers
kimi mcp list

# Remove server
kimi mcp remove chrome-devtools

# Authenticate MCP server
kimi mcp auth linear
```

Source: [Kimi Code MCP](https://github.com/MoonshotAI/kimi-cli)

### MCP Config File

Use a config file for ad-hoc MCP configuration:

```json
{
  "mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "YOUR_API_KEY"
      }
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
    }
  }
}
```

Run with:
```bash
kimi --mcp-config-file /path/to/mcp.json
```

Source: [Kimi Code MCP Config](https://github.com/MoonshotAI/kimi-cli)

## API and Customization

### ACP Server Mode

Run Kimi Code as an ACP server for IDE integration:

```bash
kimi acp
```

Configure in Zed or JetBrains:

```json
{
  "agent_servers": {
    "Kimi Code CLI": {
      "command": "kimi",
      "args": ["acp"],
      "env": {}
    }
  }
}
```

Source: [Kimi Code ACP Configuration](https://github.com/MoonshotAI/kimi-cli)

### Commands

Kimi Code supports slash commands similar to other CLI tools.

### Web Interface

Built-in web UI accessible via browser when running the server.

## Supported Models

Kimi Code uses Moonshot AI models:
- kimi-k2.5
- kimi-for-coding

Optimized for Chinese and English language tasks.

Source: [Kimi Code Models](https://www.moonshot.cn/kimi-code)

## Pricing

| Tier | Price | Features |
|------|-------|----------|
| Basic | ¥49/month (~$7) | Standard usage |
| Pro | ¥99/month (~$14) | Higher limits |
| Max | ¥199/month (~$28) | Maximum usage |

Fixed-price subscription with unlimited usage within tier limits.

Source: [Kimi Code Pricing](https://www.moonshot.cn/kimi-code)

## Context Window

- 200K+ token context window
- Supports large codebase analysis

## Fixed-Price Model

Kimi Code is notable as the only major tool offering fixed-price subscriptions:

> "Kimi Code pricing: ¥49-199/month (~$7-28) for unlimited usage within tier limits"

This provides:
- Predictable monthly costs
- No per-token anxiety
- No usage-based surprises

Source: [Kimi Code Fixed Pricing](https://www.moonshot.cn/kimi-code)

## Open Source

Kimi Code CLI is open source:

> "Kimi Code CLI is open source and available on GitHub"

Repository: https://github.com/MoonshotAI/kimi-cli

## Limitations

- Kimi models only (no multi-provider support)
- Requires subscription (no free tier)
- Primarily optimized for Chinese market
- No local model support

## Sources and References

1. [Kimi Code GitHub Repository](https://github.com/MoonshotAI/kimi-cli)
2. [Kimi Code Official Website](https://www.moonshot.cn/kimi-code)
3. [Kimi Code Documentation](https://moonshotai.github.io/kimi-cli/)

---

*Last Updated: March 1, 2026*
