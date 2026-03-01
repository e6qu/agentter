# Goose

**Type**: Open Source CLI/Desktop Tool  
**License**: Apache 2.0  
**Primary Developer**: Block (formerly Square)  
**Repository**: https://github.com/block/goose  

## Overview

Goose is Block's fully open-source AI agent, designed for complex system-level automation. It runs as both a desktop app and CLI with native MCP integration.

Source: [Goose Documentation](https://block.github.io/goose/)

## Key Features

### Fully Open Source

Goose is released under Apache 2.0:

> "Goose is Block's (formerly Square) fully open-source agent, licensed under Apache 2.0"

This provides:
- No vendor lock-in
- Community contributions
- Auditable code
- Enterprise-friendly licensing

Source: [Goose License](https://github.com/block/goose)

### MCP-First Architecture

Goose is built around Model Context Protocol:

> "Goose goes beyond code suggestions to execute full development workflows — building projects from scratch, running code, debugging failures, and orchestrating complex multi-step tasks. It is genuinely model-agnostic and supports multiple model configurations simultaneously."

Source: [Goose MCP](https://block.github.io/goose/docs/getting-started/installation)

### Recipes

Reusable, pre-defined workflows:

> "Recipes: Reusable, pre-defined workflows that can run as sub-agents. Think of them as composable automation playbooks."

Recipes enable:
- Standardized workflows
- Team sharing
- Automated processes

Source: [Goose Recipes](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### MCP-UI Rendering

Desktop app renders interactive widgets:

> "MCP-UI rendering: The desktop GUI renders interactive MCP-UI widgets — visual dashboards, forms, progress bars — not just text."

Source: [Goose UI](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Custom Distributions

Build branded Goose distributions:

> "Custom Distributions: Build your own branded Goose distro with preconfigured providers, extensions, and branding."

Source: [Goose Distributions](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Installation

```bash
# macOS via Homebrew
brew install block-goose-cli

# Or download from releases
# https://github.com/block/goose/releases
```

Source: [Goose Installation](https://block.github.io/goose/docs/getting-started/installation)

## Configuration

### Model Configuration

Goose supports multiple LLM configurations:

> "Multi-model configuration: Use different LLMs for different tasks within a single session to optimize cost and capability."

Supported providers:
- Anthropic (Claude)
- OpenAI (GPT)
- Google (Gemini)
- Local models (Ollama)

Source: [Goose Models](https://block.github.io/goose/docs/getting-started/installation)

### Environment Setup

Configure providers via environment variables or config files.

## API and Customization

### Desktop App + CLI

Available in two forms:
- Desktop application with GUI
- Command-line interface

Source: [Goose Interfaces](https://block.github.io/goose/)

### Responsible AI Guide

Ships with formal safe coding practices documentation:

> "Responsible AI guide: Ships with a formal HOWTOAI.md covering safe AI-assisted coding practices."

Source: [Goose Responsible AI](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Planning-First Approach

Goose asks clarifying questions before acting:

> "Goose is built for planning and orchestration at scale. It doesn't just edit code — it designs systems. Before touching anything, Goose asks clarifying questions and breaks requests into verifiable steps."

Source: [Goose Planning](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## 2026 Roadmap

According to published roadmap:

| Feature | Description |
|---------|-------------|
| Meta-agent orchestration | Multiple sub-agents running in parallel with task tracking |
| Built-in local inference | Ship open model downloads directly in the app |
| Peer-to-peer compute | Exploring decentralized compute for distributed agent workloads |

Source: [Goose Roadmap](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Deployment at Block

Production usage:

> "Block deployed it to all 12,000 employees by October 2025, with engineers reporting 8–10 hours saved per week."

Source: [Goose Deployment](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Pricing

- **Base Cost**: Free (Apache 2.0)
- **Model Cost**: BYOK - pay your chosen provider
- **Free Tier**: Unlimited

## Limitations

According to reviews:

> "Goose's planning-first approach can feel slow for simple, surgical edits. When I just want to rename a function across three files, I don't need a structured plan — I need Aider."

Also:
- Steeper learning curve due to recipe system
- No native git auto-commit (requires configuration)

Source: [Goose Limitations](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Sources and References

1. [Goose GitHub Repository](https://github.com/block/goose)
2. [Goose Documentation](https://block.github.io/goose/)
3. [Goose Installation Guide](https://block.github.io/goose/docs/getting-started/installation)

---

*Last Updated: March 1, 2026*
