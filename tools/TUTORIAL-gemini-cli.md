# Gemini CLI Setup Tutorial

*Reference guide based on Google documentation*

---

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Basic Usage](#basic-usage)
4. [Features](#features)
5. [GitHub Action](#github-action)

---

## Installation

### Prerequisites

- Node.js 18+
- Google account or API key

### Installation

```bash
# Run without installing
npx @google/gemini-cli

# Global install
npm install -g @google/gemini-cli

# Homebrew
brew install gemini-cli
```

### Authentication

```bash
# Login with Google account
gemini login

# Or use API key
export GEMINI_API_KEY="your-key"
```

---

## Configuration

### GEMINI.md

Create project configuration:

```markdown
# MyApp

## Overview
TypeScript project with Express backend.

## Commands
- Test: `npm test`
- Build: `npm run build`

## Style Guide
- Use async/await
- Prefer const over let
```

---

## Basic Usage

### Interactive Mode

```bash
# Start session
gemini

# With prompt
gemini "Add authentication middleware"
```

### Non-Interactive Mode

```bash
# For scripts/CI
gemini --no-interactive "Run tests and fix failures"
```

---

## Features

### Free Tier Limits

- 60 requests per minute
- 1,000 requests per day
- No credit card required

### Google Search Grounding

Built-in web search for current information.

### Multimodal Input

Supports text, images, PDFs, sketches.

### Conversation Checkpoints

Save and resume sessions:

```bash
gemini checkpoint save
gemini checkpoint load <id>
```

### MCP Support

Connect to external tools via Model Context Protocol.

---

## GitHub Action

### Workflow Example

```yaml
name: Gemini Review
on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: google-gemini/gemini-cli-action@v1
        with:
          prompt: "Review this PR for issues"
```

---

## Resources

### Official

| Resource | URL |
|----------|-----|
| GitHub | https://github.com/google-gemini/gemini-cli |
| Google AI Docs | https://ai.google.dev/docs |

---

*Based on Google documentation as of March 2026*
