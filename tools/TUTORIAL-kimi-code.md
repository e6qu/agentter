# Kimi Code Setup Tutorial

*Reference guide based on Moonshot AI documentation*

---

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Basic Usage](#basic-usage)
4. [Shell Mode](#shell-mode)
5. [ACP Integration](#acp-integration)
6. [MCP Configuration](#mcp-configuration)

---

## Installation

### Prerequisites

- Python 3.13+ or Node.js
- Kimi Code subscription

### Installation

```bash
# Quick install
curl -LsSf https://code.kimi.com/install.sh | bash

# Via uv
uv tool install --python 3.13 kimi-cli

# Windows PowerShell
Invoke-RestMethod https://code.kimi.com/install.ps1 | Invoke-Expression
```

---

## Configuration

### Authentication

```bash
# Start Kimi Code
kimi

# Then type: /login
```

### Environment Variables

```bash
export KIMI_API_KEY="your-key"
```

---

## Basic Usage

### Interactive Mode

```bash
kimi
```

### With Prompt

```bash
kimi "Create a Python script to parse JSON"
```

---

## Shell Mode

### Toggle Shell Mode

Press `Ctrl-X` to toggle between AI and shell modes.

### Zsh Integration

```bash
# Install plugin
git clone https://github.com/MoonshotAI/zsh-kimi-cli.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/kimi-cli

# Add to .zshrc
plugins=(... kimi-cli)
```

After installation, press `Ctrl-X` in Zsh to switch modes.

---

## ACP Integration

### ACP Server Mode

Run as ACP server for IDE integration:

```bash
kimi acp
```

### Zed Configuration

```json
{
  "agent_servers": {
    "Kimi Code": {
      "command": "kimi",
      "args": ["acp"]
    }
  }
}
```

### JetBrains Configuration

Configure via IDE settings with same command structure.

---

## MCP Configuration

### Add MCP Servers

```bash
# HTTP transport
kimi mcp add --transport http context7 https://mcp.context7.com/mcp \
  --header "CONTEXT7_API_KEY: your-key"

# Stdio transport
kimi mcp add --transport stdio chrome-devtools -- npx chrome-devtools-mcp@latest

# List servers
kimi mcp list

# Remove server
kimi mcp remove chrome-devtools
```

### MCP Config File

```json
{
  "mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "YOUR_KEY"
      }
    }
  }
}
```

Run with:
```bash
kimi --mcp-config-file /path/to/mcp.json
```

---

## Resources

### Official

| Resource | URL |
|----------|-----|
| GitHub | https://github.com/MoonshotAI/kimi-cli |
| Website | https://www.moonshot.cn/kimi-code |
| Docs | https://moonshotai.github.io/kimi-cli |

### Pricing

| Tier | Price |
|------|-------|
| Basic | ¥49/month (~$7) |
| Pro | ¥99/month (~$14) |
| Max | ¥199/month (~$28) |

---

*Based on Moonshot AI documentation as of March 2026*
