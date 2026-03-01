# Cline Setup Tutorial

*Reference guide for VS Code extension*

---

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Basic Usage](#basic-usage)
4. [Features](#features)
5. [MCP Tools](#mcp-tools)

---

## Installation

### Prerequisites

- VS Code 1.80+
- API key for chosen provider

### Installation

```
1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search: "Cline"
4. Click Install
```

Or visit: https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev

---

## Configuration

### VS Code Settings

```json
{
  "cline.model": "claude-3-5-sonnet-20241022",
  "cline.anthropicApiKey": "sk-ant-api-...",
  "cline.autoApprove": false
}
```

### Auto-Approve Options

```json
{
  "cline.autoApprove": {
    "readFiles": true,
    "editFiles": false,
    "runCommands": false,
    "useBrowser": false
  }
}
```

---

## Basic Usage

### Start Cline

1. Open Command Palette (Ctrl+Shift+P)
2. Type: "Cline: Open"
3. Enter prompt in chat panel

### Plan vs Act Mode

| Mode | Behavior |
|------|----------|
| Plan | Read-only analysis |
| Act | Execute with approval |

Toggle between modes in the UI.

---

## Features

### Human-in-the-Loop

Every action requires explicit approval (configurable).

### Browser Automation

Launch browsers, click elements, capture screenshots.

### Workspace Checkpoints

Save and restore workspace state for safe experimentation.

---

## MCP Tools

### Configuration

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
| GitHub | https://github.com/clinebot/cline |
| Marketplace | https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev |

---

*Based on Cline documentation as of March 2026*
