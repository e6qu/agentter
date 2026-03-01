# Codex CLI Setup Tutorial

*Reference guide based on OpenAI documentation*

---

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Basic Usage](#basic-usage)
4. [Skills](#skills)
5. [Parallel Agents](#parallel-agents)
6. [Scheduled Automations](#scheduled-automations)

---

## Installation

### Prerequisites

- Node.js 18+
- ChatGPT account (Plus, Pro, or Business)
- macOS (primary support), Linux, Windows

### Installation

```bash
# Via npm
npm i -g @openai/codex

# Via Homebrew (macOS)
brew install --cask codex

# Run without installing
npx @openai/codex
```

### Authentication

```bash
# Sign in with ChatGPT account
codex --login
```

---

## Configuration

### AGENTS.md

Create project configuration file:

```markdown
# MyApp

## Project Overview
Next.js 14 app with TypeScript.

## Commands
- Run tests: `npm test`
- Lint: `npm run lint`
- Build: `npm run build`

## Conventions
- Use functional components
- All API routes in /app/api/
```

---

## Basic Usage

### Interactive Mode

```bash
# Start interactive session
codex

# Run with prompt
codex "Implement user authentication"
```

### Cloud Sandbox

Codex runs in isolated cloud containers:
- Filesystem restricted to working folder
- No root/sudo access
- Network access controlled
- Automatic cleanup after session

---

## Skills

### Built-in Skills

| Skill | Description |
|-------|-------------|
| `$skill-creator` | Create new skills |
| `$skill-installer` | Install community skills |
| `figma` | Convert designs to code |
| `linear` | Triage bugs, track releases |
| `deployment` | Push to hosting platforms |

### Creating Skills

Skills define:
- Instructions for when to use
- Execution scripts
- Required resources

---

## Parallel Agents

Run multiple agents simultaneously:

```
Assign 5 tasks to 5 agents at once
```

Each agent runs in isolated Git worktree.

---

## Scheduled Automations

Set up recurring tasks:

- Daily issue triage
- CI failure analysis
- Release notes generation
- Weekly test coverage scans

Results go to review queue for approval.

---

## Resources

### Official Documentation

| Resource | URL |
|----------|-----|
| OpenAI Codex | https://openai.com/codex |
| Platform Docs | https://platform.openai.com/docs |

### Pricing

| Plan | Price | Access |
|------|-------|--------|
| Free | $0 | Limited |
| Plus | $20/mo | Included |
| Pro | $200/mo | Heavy usage |

---

*Based on OpenAI documentation as of March 2026*
