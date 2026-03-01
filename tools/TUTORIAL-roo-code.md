# Roo Code Setup Tutorial

*Reference guide for VS Code extension (fork of Cline)*

---

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Basic Usage](#basic-usage)
4. [Modes](#modes)
5. [Custom Modes](#custom-modes)

---

## Installation

### Prerequisites

- VS Code 1.80+
- API key for chosen provider

### Installation

```
1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search: "Roo Code"
4. Click Install
```

Or: https://marketplace.visualstudio.com/items?itemName=RooVeterinaryInc.roo-cline

---

## Configuration

### VS Code Settings

```json
{
  "roo.model": "claude-3-5-sonnet-20241022",
  "roo.anthropicApiKey": "sk-ant-api-..."
}
```

---

## Basic Usage

### Start Roo Code

1. Open Command Palette (Ctrl+Shift+P)
2. Type: "Roo Code: Open"
3. Select mode
4. Enter prompt

---

## Modes

### Built-in Modes

| Mode | Purpose |
|------|---------|
| Ask | Questions and explanations |
| Architect | System design and planning |
| Code | Implementation |
| Debug | Troubleshooting |
| Orchestrator | Coordinate multiple tasks |

### Switching Modes

Select mode from dropdown in Roo Code panel.

---

## Custom Modes

### Creating Custom Modes

Define in settings:

```json
{
  "roo.customModes": [
    {
      "name": "security-review",
      "description": "Security-focused code review",
      "systemPrompt": "You are a security reviewer..."
    }
  ]
}
```

---

## Resources

### Official

| Resource | URL |
|----------|-----|
| GitHub | https://github.com/RooVetGit/Roo-Code |
| Marketplace | https://marketplace.visualstudio.com/items?itemName=RooVeterinaryInc.roo-cline |

---

*Based on Roo Code documentation as of March 2026*
