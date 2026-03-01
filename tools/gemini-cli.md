# Gemini CLI

**Type**: Open Source CLI Tool  
**License**: Apache 2.0  
**Primary Developer**: Google  
**Repository**: https://github.com/google-gemini/gemini-cli  

## Overview

Gemini CLI is Google's open-source terminal agent. It provides a generous free tier and features like Google Search grounding, multimodal input, and conversation checkpointing.

Source: [Gemini CLI Repository](https://github.com/google-gemini/gemini-cli)

## Key Features

### Generous Free Tier

Gemini CLI offers a genuinely accessible free tier:

> "The free tier is the most accessible entry point of any tool on this list: 60 requests per minute and 1,000 requests per day with just a Google account login."

Limits:
- 60 requests per minute
- 1,000 requests per day
- No credit card required
- Powered by Gemini 3 models

Source: [Gemini CLI Comparison](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Google Search Grounding

Built-in web search for real-time information:

> "Gemini CLI also ships with built-in Google Search grounding (the agent can search the web to verify its answers)"

This allows the agent to:
- Access current documentation
- Verify library compatibility
- Debug obscure errors with latest information

Source: [Gemini CLI Features](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Multimodal Input

Support for various input types:

> "Generate apps from PDFs, images, or hand-drawn sketches"

Supported inputs:
- Text prompts
- Images
- PDF documents
- Hand-drawn sketches

Source: [Gemini CLI Multimodal](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Conversation Checkpointing

Save and resume complex sessions:

> "Conversation checkpointing: Save and resume complex sessions — essential for multi-day refactoring work"

Source: [Gemini CLI Checkpoints](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Installation

```bash
# Run instantly without installing
npx @google/gemini-cli

# Global install via npm
npm install -g @google/gemini-cli

# Homebrew (macOS/Linux)
brew install gemini-cli
```

Source: [Gemini CLI Installation](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Configuration

### GEMINI.md

Project configuration file similar to CLAUDE.md:

> "GEMINI.md files: Project-level custom context files that tailor the agent's behavior, similar to `.cursorrules` or `CLAUDE.md`"

Source: [Gemini CLI Configuration](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Authentication

Authenticate with:
- Personal Google account (OAuth)
- Gemini API key
- Vertex AI credentials

Source: [Gemini CLI Authentication](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## API and Customization

### GitHub Action Integration

Official GitHub Action for CI/CD:

> "The official GitHub Action enables automated PR reviews, issue triage, and on-demand help by mentioning `@gemini-cli` in comments"

Source: [Gemini CLI GitHub Action](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### MCP Support

Gemini CLI supports Model Context Protocol:

> "MCP extensibility: Connect to external tools including media generation with Imagen, Veo, and Lyria"

Source: [Gemini CLI MCP](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

### Non-Interactive Mode

Run commands in scripts for automation:

> "Non-interactive mode: Run commands in scripts for CI/CD automation"

Source: [Gemini CLI Automation](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Supported Models

Gemini CLI only supports Google models:
- Gemini 3 Flash
- Gemini 3 Pro
- Gemini 2.5 Pro

Model selection depends on authentication method.

## Context Window

- 1 million token context window
- Supports very large codebases

Source: [Gemini CLI Context](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Pricing

| Tier | Access |
|------|--------|
| Free (Google Account) | 60 req/min, 1000 req/day |
| API Key | Usage-based billing |
| Vertex AI | Enterprise pricing |

Source: [Gemini CLI Pricing](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Limitations

According to comparative reviews:

> "The search grounding is a double-edged sword. For highly specialized internal codebases, it sometimes reaches for the web when local repository context would be more appropriate."

Also lacks:
- Subagent/multi-agent capabilities
- Scheduled automations
- Local model support

Source: [Gemini CLI Limitations](https://sanj.dev/post/comparing-ai-cli-coding-assistants)

## Sources and References

1. [Gemini CLI GitHub Repository](https://github.com/google-gemini/gemini-cli)
2. [Gemini CLI Comparison Review](https://sanj.dev/post/comparing-ai-cli-coding-assistants)
3. [Google AI Documentation](https://ai.google.dev/docs)

---

*Last Updated: March 1, 2026*
