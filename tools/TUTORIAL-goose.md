# Goose Setup Tutorial

*Reference guide based on Block documentation*

---

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Basic Usage](#basic-usage)
4. [Recipes](#recipes)
5. [MCP Integration](#mcp-integration)

---

## Installation

### Prerequisites

- macOS, Linux, or Windows
- API key for chosen provider

### Installation

```bash
# macOS via Homebrew
brew install block-goose-cli

# Or download from releases
# https://github.com/block/goose/releases
```

---

## Configuration

### Provider Setup

```bash
# Set provider
export GOOSE_PROVIDER="anthropic"
export ANTHROPIC_API_KEY="sk-ant-api-..."

# Or OpenAI
export GOOSE_PROVIDER="openai"
export OPENAI_API_KEY="sk-..."
```

### Multi-Model Configuration

Goose supports different models for different tasks.

---

## Basic Usage

### Start Session

```bash
# Interactive mode
goose

# With prompt
goose "Create a REST API for user management"
```

### Desktop App

Download desktop application from releases page for GUI.

---

## Recipes

### What are Recipes

Reusable workflows for common tasks.

### Creating Recipes

```yaml
# recipes/deploy.yml
name: deploy
steps:
  - run_tests
  - build_assets
  - deploy_production
```

### Running Recipes

```bash
goose recipe run deploy
```

---

## MCP Integration

### MCP-First Architecture

Goose is built around Model Context Protocol.

### Adding MCP Servers

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    }
  }
}
```

---

## Resources

### Official

| Resource | URL |
|----------|-----|
| GitHub | https://github.com/block/goose |
| Documentation | https://block.github.io/goose |
| Releases | https://github.com/block/goose/releases |

### License

Apache 2.0

---

*Based on Block documentation as of March 2026*
