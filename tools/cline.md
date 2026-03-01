# Cline

**Type**: Open Source VS Code Extension  
**License**: Open Source  
**Primary Developer**: Cline Bot Inc.  
**Repository**: https://github.com/clinebot/cline  
**VS Code Marketplace**: https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev

## Overview

Cline is an autonomous coding agent that lives inside VS Code. It follows a human-in-the-loop approach where every change requires explicit approval.

Source: [Cline GitHub Repository](https://github.com/clinebot/cline)

## Key Features

### Human-in-the-Loop Control

Cline requires approval for all actions:

> "Cline's philosophy is 'approve everything.' Every file change and terminal command requires explicit approval, giving developers maximum control over what the agent does."

Source: [Cline Comparison](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Browser Automation

Built-in browser capabilities:

> "Includes browser automation (launching browsers, clicking elements, capturing screenshots for testing)"

Features:
- Launch browsers
- Click elements
- Capture screenshots
- Use for testing verification

Source: [Cline Browser](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Workspace Checkpoints

Safe experimentation through checkpoints:

> "Workspace checkpoints for safe experimentation"

Allows:
- Try changes safely
- Revert if unsuccessful
- Branch different approaches

Source: [Cline Checkpoints](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### MCP Support

Full Model Context Protocol integration:

> "MCP support for creating custom tools"

Source: [Cline MCP](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Installation

Install from VS Code marketplace:

```
Search: "Cline" in VS Code Extensions
Or: https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev
```

Source: [Cline Installation](https://github.com/clinebot/cline)

## Configuration

### Settings

Configure via VS Code settings:

```json
{
  "cline.model": "claude-3-5-sonnet-20241022",
  "cline.apiKey": "...",
  "cline.autoApprove": false
}
```

### Modes

Cline supports plan/act mode toggle:

- **Plan Mode**: Read-only analysis and planning
- **Act Mode**: Execute changes with approval

Source: [Cline Modes](https://github.com/clinebot/cline)

## API and Customization

### Code Review

Review workflow with request changes/approve:

> "Code review with request changes / approve"

Source: [Cline Review](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Custom Tools via MCP

Create custom tools through MCP:

```json
{
  "mcpServers": {
    "my-tool": {
      "command": "node",
      "args": ["/path/to/server.js"]
    }
  }
}
```

### Auto-Approve Options

Configure which operations can be auto-approved:

```json
{
  "cline.autoApprove": {
    "readFiles": true,
    "editFiles": false,
    "runCommands": false
  }
}
```

## Supported Models

Cline supports multiple providers via OpenRouter and direct APIs:

- Anthropic (Claude)
- OpenAI (GPT)
- Google (Gemini)
- AWS Bedrock
- Azure
- GCP Vertex
- Local models via Ollama

Source: [Cline Models](https://github.com/clinebot/cline)

## Pricing

- **Base Cost**: Free extension
- **Model Cost**: BYOK - pay your chosen API provider
- **Enterprise**: Self-hosted option available

Source: [Cline Pricing](https://github.com/clinebot/cline)

## Limitations

According to reviews:

- VS Code only (no standalone CLI)
- Approval-required model can slow workflow
- No subagent capabilities
- Limited to IDE context window

Source: [Cline Limitations](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Sources and References

1. [Cline GitHub Repository](https://github.com/clinebot/cline)
2. [Cline VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev)

---

*Last Updated: March 1, 2026*
