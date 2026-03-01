# Codex CLI

**Type**: Proprietary CLI Tool  
**License**: Proprietary (OpenAI)  
**Primary Developer**: OpenAI  
**Website**: https://openai.com/codex

## Overview

Codex CLI is OpenAI's terminal-based AI coding agent. It runs locally and authenticates through ChatGPT subscriptions, offering features like cloud sandboxes, parallel agents, and scheduled automations.

Source: [OpenAI Codex Announcement](https://openai.com/index/introducing-the-codex-app/)

## Key Features

### Cloud Sandbox

Codex CLI executes tasks in isolated cloud sandboxes:

> "Codex app uses a native, open-source and configurable system-level sandbox. By default, Codex agents are limited to editing files in their working folder or branch."

Sandbox features:
- Filesystem restrictions (working folder only)
- Network access controls
- Cached web search results
- Permission escalation requests

Source: [OpenAI Codex Documentation](https://openai.com/index/introducing-the-codex-app/)

### Parallel Agent Execution

Codex supports running multiple agents simultaneously:

> "Assign 5 tasks to 5 agents at once, all working simultaneously on your codebase"

Each agent runs in its own isolated environment with Git worktree isolation.

Source: [OpenAI Codex Features](https://openai.com/index/introducing-the-codex-app/)

### Scheduled Automations

Set up recurring tasks that run automatically:

> "Set Codex to run recurring tasks on a schedule — no prompting needed"

Use cases:
- Daily issue triage
- CI failure analysis after failed builds
- Release notes generation
- Weekly test coverage scans

Results land in a review queue for human approval.

Source: [OpenAI Codex Automations](https://openai.com/index/introducing-the-codex-app/)

### Skills System

Skills extend Codex capabilities:

> "Skills extend Codex beyond code. They're bundles of instructions + scripts that teach Codex new capabilities."

Built-in skills include:
- `$skill-creator` - Create new skills
- `$skill-installer` - Install community skills
- Figma skill - Convert designs to UI code
- Linear skill - Triage bugs and track releases
- Deployment skills - Push to Cloudflare, Netlify, Vercel, Render

Source: [OpenAI Codex Skills](https://openai.com/index/introducing-the-codex-app/)

## Installation

```bash
# Via npm
npm i -g @openai/codex

# Via Homebrew (macOS)
brew install --cask codex

# Or run without installing
npx @google/gemini-cli
```

Source: [OpenAI Codex Installation](https://openai.com/index/introducing-the-codex-app/)

## Configuration

### AGENTS.md

Project configuration file:

```markdown
# MyApp

## Project Overview
Next.js 14 app with TypeScript and Tailwind CSS.

## Commands
- Run tests: `npm test`
- Lint: `npm run lint`
- Build: `npm run build`

## Conventions
- Use functional components with hooks
- All API routes go in /app/api/
- Write tests for every new function
```

Source: [OpenAI Codex Configuration](https://openai.com/index/introducing-the-codex-app/)

## API and Customization

### CLI Commands

```bash
# Start interactive session
codex

# Run specific prompt
codex "Implement user authentication"

# Sign in with ChatGPT
codex --login
```

### Web and App Access

Codex is available through multiple interfaces:
- CLI (terminal)
- macOS app (desktop)
- IDE extensions (VS Code, Cursor, Windsurf)
- Web interface (chatgpt.com/codex)

All interfaces sync through your ChatGPT account.

Source: [OpenAI Codex Interfaces](https://openai.com/index/introducing-the-codex-app/)

### GitHub Integration

Tag @Codex in pull requests for automatic code review:

> "Tag @Codex in a pull request, and it reviews the code, catches bugs, flags security issues, and suggests fixes"

Source: [OpenAI Codex GitHub Integration](https://openai.com/index/introducing-the-codex-app/)

### Custom Skills

Create custom skills by defining:
- Instructions for when to use the skill
- Scripts for execution
- Required resources

Skills are shareable across your organization.

Source: [OpenAI Codex Skills Creation](https://openai.com/index/introducing-the-codex-app/)

## Supported Models

Codex CLI only supports OpenAI models:
- GPT-5.3-Codex
- GPT-5.2-Codex
- GPT-5.1-Codex-Mini

Source: [OpenAI Codex Models](https://openai.com/index/introducing-the-codex-app/)

## Pricing

| Plan | Price | Codex Access |
|------|-------|--------------|
| Free/Go | $0 | Limited (for a limited time) |
| Plus | $20/month | Included |
| Pro | $200/month | Heavy usage |
| Business/Enterprise | Custom | Team features |

Additional token packs available for purchase.

Source: [OpenAI Codex Pricing](https://openai.com/index/introducing-the-codex-app/)

## Cloud Execution Model

### Sandboxing

Codex runs in isolated containers with:
- File system boundaries
- Network access restrictions
- No root/sudo access
- Automatic cleanup after completion

### Worktree Isolation

Each parallel agent works in its own Git worktree:

> "Each agent works on its own git worktree — so there's zero risk of changes colliding"

Source: [OpenAI Codex Worktrees](https://openai.com/index/introducing-the-codex-app/)

### Security

- Code sent to OpenAI servers for processing
- Sandboxed execution environment
- Permission escalation requires user approval
- No local data stored in cloud after session ends

## Sources and References

1. [OpenAI Codex Announcement](https://openai.com/index/introducing-the-codex-app/)
2. [OpenAI Codex CLI Guide](https://openai.com/index/introducing-the-codex-app/)
3. [OpenAI Documentation](https://platform.openai.com/docs/)

---

*Last Updated: March 1, 2026*
