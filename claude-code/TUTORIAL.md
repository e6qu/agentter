# Claude Code Setup Tutorial

*Reference guide based on official documentation and observed behavior*

---

## Table of Contents

1. [Installation](#installation)
2. [Project Structure](#project-structure)
3. [Credential Management](#credential-management)
4. [Proxy Configuration](#proxy-configuration)
5. [Skills](#skills)
6. [Custom Agents](#custom-agents)
7. [Heartbeat Agents](#heartbeat-agents)
8. [Hooks](#hooks)
9. [Sandboxing](#sandboxing)
10. [Deterministic Checks](#deterministic-checks)

---

## Installation

### Prerequisites

- Node.js 18+ (check with `node --version`)
- Git 2.20+ (check with `git --version`)
- Anthropic API access

### Installation Methods

```bash
# Via npm (recommended)
npm install -g @anthropic-ai/claude-code

# Via npx (no installation)
npx @anthropic-ai/claude-code
```

### Authentication

```bash
# Run claude and follow the interactive OAuth login flow on first run
claude

# Or set API key via environment variable
export ANTHROPIC_API_KEY="sk-ant-api-..."
```

### Project Initialization

To initialize Claude Code in a project, start an interactive session and use the `/init` slash command:

```bash
cd /path/to/project
claude
# Then inside the session, type:
# /init
#
# This creates the directory structure:
# .claude/
# ├── settings.json
# ├── agents/
# ├── skills/
# └── commands/
```

---

## Project Structure

### Directory Layout

```
project/
├── .claude/
│   ├── settings.json          # Configuration
│   ├── settings.local.json    # Local overrides (should be gitignored)
│   ├── CLAUDE.md             # Project instructions
│   ├── agents/               # Custom agent definitions
│   ├── skills/               # SKILL.md files
│   ├── hooks/                # Hook scripts
│   └── commands/             # Slash commands
└── .gitignore
```

### Gitignore Configuration

```gitignore
# Claude Code local settings
.claude/settings.local.json
.claude/.logs/

# Generated state files
.claude/.heartbeat/
.claude/.deterministic/
.claude/.code-reviews/
```

---

## Credential Management

### Method 1: Environment Variables

Based on standard Unix conventions and Claude Code's environment handling:

```bash
# Shell configuration (~/.bashrc, ~/.zshrc)
export ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}"
export GITHUB_TOKEN="${GITHUB_TOKEN}"
```

### Method 2: Interactive Login

Run `claude` with no arguments and follow the interactive OAuth login flow. Credentials are stored automatically.

> **Note**: The `env` field in `settings.local.json` is a speculative feature and may not be supported. Use environment variables or interactive login for authentication.

### Method 3: Credential Detection Hook

```bash
#!/bin/bash
# .claude/hooks/credential-guard.sh

read -r input

# Known credential patterns (based on common formats)
PATTERNS=(
  "sk-[a-zA-Z0-9]{48}"           # Anthropic/OpenAI format
  "AKIA[0-9A-Z]{16}"             # AWS Access Key format
  "gh[pousr]_[A-Za-z0-9_]{36}"   # GitHub token format
)

if echo "$input" | jq -e '.tool == "Write" or .tool == "Edit"' >/dev/null 2>&1; then
  content=$(echo "$input" | jq -r '.tool_input.content // ""')

  for pattern in "${PATTERNS[@]}"; do
    if echo "$content" | grep -qE "$pattern"; then
      jq -n '{
        hookSpecificOutput: {
          hookEventName: "PreToolUse",
          permissionDecision: "deny",
          permissionDecisionReason: "Potential credential pattern detected"
        }
      }'
      exit 0
    fi
  done
fi

echo "$input"
```

---

## Proxy Configuration

### Environment Variables (Standard)

```bash
export HTTP_PROXY="http://proxy.example.com:8080"
export HTTPS_PROXY="http://proxy.example.com:8080"
export NO_PROXY="localhost,127.0.0.1"
```

> **Note**: Proxy configuration via a `proxy` field in `settings.json` is a speculative feature and may not be supported. Use standard environment variables (`HTTP_PROXY`, `HTTPS_PROXY`, `NO_PROXY`) which Claude Code inherits from your shell environment.

---

## Skills

### Skill Structure

Based on SKILL.md format documentation:

```markdown
---
name: example-skill
description: Description of what this skill does
metadata:
  category: development
---

## Purpose

What this skill does.

## When to Use

Conditions for using this skill.

## Steps

1. Step one
2. Step two
```

### Example: Onboarding Skill

```markdown
---
name: onboarding
description: Project onboarding guide
metadata:
  category: documentation
---

## Quick Start

1. Install: `npm install`
2. Configure: Copy `.env.example` to `.env`
3. Run: `npm run dev`

## Architecture

- Backend: Node.js + Express
- Frontend: React
- Database: PostgreSQL
```

### Example: Deployment Skill

```markdown
---
name: deployment
description: Deployment workflow
disable-model-invocation: true
context: fork
---

## Checklist

- [ ] Tests pass
- [ ] Security scan clean
- [ ] Migrations reviewed

## Steps

1. Run tests: `npm test`
2. Deploy staging: `npm run deploy:staging`
3. Deploy production: `npm run deploy:production`
```

---

## Custom Agents

### Agent Configuration Format

```json
{
  "name": "agent-name",
  "description": "What this agent does",
  "system": "System prompt defining behavior",
  "allowed_tools": ["Read", "Grep", "Edit"],
  "temperature": 0.1,
  "model": "claude-3-5-sonnet-20241022"
}
```

### Example: Code Reviewer

```json
{
  "name": "code-reviewer",
  "description": "Code quality reviewer",
  "system": "You review code for quality issues.\n\nCheck for:\n1. Correctness\n2. Readability\n3. Test coverage\n\nOutput structured feedback.",
  "allowed_tools": ["Read", "Grep", "Glob"],
  "temperature": 0.1
}
```

### Example: Unstuck Monitor

```json
{
  "name": "unstuck-monitor",
  "description": "Detects stuck implementation states",
  "system": "You detect when an agent is stuck.\n\nIndicators:\n- Repeated errors\n- Same file edited multiple times\n- No progress markers\n\nSuggest alternative approaches.",
  "allowed_tools": ["Read", "Bash", "Grep"]
}
```

---

## Heartbeat Agents

### Unstuck Detection Script

```bash
#!/bin/bash
# .claude/hooks/unstuck-detector.sh

STATE_DIR=".claude/.heartbeat"
mkdir -p "$STATE_DIR"

EDIT_LOG="$STATE_DIR/edits.log"
LAST_CHECK="$STATE_DIR/last_check"

# Check for repetitive error patterns
check_errors() {
  if [ -f ".claude/logs/session.log" ]; then
    error_count=$(grep -c "Error:" .claude/logs/session.log 2>/dev/null || echo "0")
    unique_errors=$(grep "Error:" .claude/logs/session.log 2>/dev/null | sort -u | wc -l)

    if [ "$error_count" -gt 10 ] && [ "$unique_errors" -lt 3 ]; then
      echo "Repetitive errors detected: $error_count total, $unique_errors unique"
      return 1
    fi
  fi
  return 0
}

# Check for edit loops
check_edits() {
  if [ -f "$EDIT_LOG" ]; then
    most_edited=$(tail -50 "$EDIT_LOG" | sort | uniq -c | sort -rn | head -1)
    edit_count=$(echo "$most_edited" | awk '{print $1}')

    if [ "$edit_count" -gt 10 ]; then
      echo "High edit frequency detected"
      return 1
    fi
  fi
  return 0
}

# Run checks
if ! check_errors || ! check_edits; then
  echo "Potential stuck state detected"

  # Trigger review using non-interactive mode
  claude -p "Review recent activity and suggest alternatives" \
         --allowedTools "Read,Grep" 2>/dev/null || true
fi

touch "$LAST_CHECK"
```

### Health Check Script

```bash
#!/bin/bash
# .claude/hooks/health-check.sh

STATE_DIR=".claude/.heartbeat"
LAST_RUN="$STATE_DIR/last_health_check"
INTERVAL=1800  # 30 minutes

# Time-based check
if [ -f "$LAST_RUN" ]; then
  elapsed=$(($(date +%s) - $(cat "$LAST_RUN")))
  if [ $elapsed -lt $INTERVAL ]; then
    exit 0
  fi
fi

# Run checks
npm test --silent 2>/dev/null && echo "Tests: PASS" || echo "Tests: FAIL"
npm audit --audit-level moderate 2>/dev/null | grep -q "0 vulnerabilities" && echo "Security: PASS" || echo "Security: CHECK"

date +%s > "$LAST_RUN"
```

---

## Hooks

### Available Hook Events

Based on observed behavior in Claude Code documentation:

| Event | Timing |
|-------|--------|
| `SessionStart` | Session initialization |
| `SessionEnd` | Session termination |
| `PreToolUse` | Before tool execution |
| `PostToolUse` | After tool success |
| `SubagentStart` | Subagent creation |
| `SubagentStop` | Subagent completion |

### Pre-Tool Safety Hook

```bash
#!/bin/bash
# .claude/hooks/safety-check.sh

read -r input

tool=$(echo "$input" | jq -r '.tool')
command=$(echo "$input" | jq -r '.tool_input.command // empty')

if [ "$tool" = "Bash" ]; then
  # Block known destructive patterns
  if echo "$command" | grep -qE "rm\s+-rf\s+/|sudo|mkfs|dd\s+if="; then
    jq -n '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "deny",
        permissionDecisionReason: "Destructive command pattern detected"
      }
    }'
    exit 0
  fi
fi

echo "$input"
```

### Session Start Hook

```bash
#!/bin/bash
# .claude/hooks/session-start.sh

if [ -f ".claude/CLAUDE.md" ]; then
  echo "Project guidelines: .claude/CLAUDE.md"
fi

# List available agents
if [ -d ".claude/agents" ]; then
  echo "Available agents:"
  ls -1 .claude/agents/*.json 2>/dev/null | while read -r f; do
    name=$(basename "$f" .json)
    echo "  @${name}"
  done
fi
```

### Hook Configuration

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/session-start.sh"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/safety-check.sh"
          }
        ]
      }
    ]
  }
}
```

---

## Sandboxing

### Claude Code Built-in Sandbox Mode

Claude Code has a built-in sandbox mode that restricts tool permissions for safer operation. Key aspects:

- **Permission modes**: Use `--permission-mode` to control tool access levels. For example, `--permission-mode plan` restricts Claude to read-only operations with no file modifications or command execution.
- **Tool allowlists**: Use `--allowedTools` to restrict which tools Claude can use in a session.
- **Automatic permission prompts**: By default, Claude Code prompts for confirmation before running potentially destructive commands (e.g., `rm`, `sudo`). Permissions can be pre-configured in `settings.json`.
- **Network restrictions**: Commands that attempt network access can be gated via PreToolUse hooks.

Example of running Claude Code in a restricted mode:

```bash
# Read-only planning mode
claude --permission-mode plan

# Restrict to specific tools
claude --allowedTools "Read,Grep,Glob"
```

### Git Worktree Isolation

```bash
#!/bin/bash
# scripts/create-ephemeral.sh

set -e

project=$(basename "$(pwd)")
timestamp=$(date +%Y%m%d-%H%M%S)
worktree_name="ephemeral-${project}-${timestamp}"
worktree_path="${HOME}/.claude-worktrees/${worktree_name}"

mkdir -p "${HOME}/.claude-worktrees"
git worktree add -b "ephemeral/${worktree_name}" "$worktree_path"

# Copy config
cp -r .claude "$worktree_path/"

echo "Worktree created: $worktree_path"
echo "Start: claude $worktree_path"
echo "Cleanup: git worktree remove $worktree_path"
```

### Docker Sandbox

```yaml
# .claude/sandbox/docker-compose.yml
version: '3.8'

services:
  sandbox:
    image: node:20-alpine
    working_dir: /workspace
    volumes:
      - type: bind
        source: ../..
        target: /workspace
        read_only: true
    security_opt:
      - no-new-privileges:true
    cap_drop:
      - ALL
    read_only: true
    network_mode: none
```

---

## Deterministic Checks

### Checksum-Based Check

```bash
#!/bin/bash
# .claude/hooks/lib/deterministic.sh

DETERMINISTIC_DIR=".claude/.deterministic"
mkdir -p "$DETERMINISTIC_DIR"

deterministic_checksum() {
  local content="$1"
  local namespace="${2:-default}"
  local hash=$(echo -n "$content" | sha256sum | cut -d' ' -f1)
  local marker="$DETERMINISTIC_DIR/${namespace}/${hash}.checked"

  if [ -f "$marker" ]; then
    echo "false"
  else
    echo "$marker"
  fi
}

deterministic_mark() {
  local marker="$1"
  if [ "$marker" != "false" ]; then
    mkdir -p "$(dirname "$marker")"
    date -Iseconds > "$marker"
  fi
}
```

### Time-Based Check

```bash
deterministic_time() {
  local interval="$1"
  local namespace="${2:-default}"
  local marker="$DETERMINISTIC_DIR/timestamps/${namespace}.last"

  if [ -f "$marker" ]; then
    local last=$(cat "$marker")
    local now=$(date +%s)
    if [ $((now - last)) -lt $interval ]; then
      echo "false"
      return
    fi
  fi
  echo "$marker"
}
```

### Usage Example

```bash
source .claude/hooks/lib/deterministic.sh

marker=$(deterministic_checksum "$file_content" "lint-check")

if [ "$marker" = "false" ]; then
  exit 0  # Already processed
fi

# Run check...

deterministic_mark "$marker"
```

---

## Configuration Reference

### settings.json Structure

```json
{
  "name": "project-name",
  "agents": {
    "agent-name": {
      "description": "...",
      "system": "...",
      "allowed_tools": ["..."]
    }
  },
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolName",
        "hooks": [
          {
            "type": "command",
            "command": "path/to/script.sh"
          }
        ]
      }
    ]
  },
  "permissions": {
    "allow": [
      "Bash(npm test)",
      "Bash(npm run build)"
    ],
    "deny": [
      "Bash(rm -rf /)",
      "Bash(sudo *)"
    ]
  }
}
```

### CLI Flags

| Flag | Description |
|------|-------------|
| `-p, --print` | Execute prompt non-interactively and print response |
| `--continue, --resume` | Continue the most recent conversation |
| `--allowedTools` | Restrict available tools |
| `--permission-mode` | Set permission mode (e.g., `plan`, `auto-edit`) |
| `--add-dir` | Add additional directories to the session |
| `--model` | Override the model to use |
| `--verbose` | Enable verbose logging |


---

## Resources

### Official Documentation

| Resource | URL | Description |
|----------|-----|-------------|
| Official Docs | https://docs.anthropic.com/en/docs/claude-code | Primary documentation |
| Anthropic Blog | https://www.anthropic.com/blog | Product announcements |

### Community Resources

| Resource | Author | Description |
|----------|--------|-------------|
| awesome-claude-code | hesreallyhim | Curated resource list |
| awesome-claude-skills | ComposioHQ | Community skills collection |
| claude-code-commands | shakacode | Commands, skills, agents |
| claude-code-hooks | disler | Hooks examples |

### Skills Repositories

| Repository | License | Description |
|------------|---------|-------------|
| awesome-agent-skills | VoltAgent | 380+ agent skills (various licenses) |
| claude-code-commands-skills | shakacode | MIT - Commands and skills |

### Configuration Examples

| Repository | Description |
|------------|-------------|
| claude-config | waylandzhang | Best practices configuration |

### Exclusions

The following are excluded due to proprietary backends:
- Context7 (proprietary backend)
- Tools requiring non-open infrastructure

---

*Last Updated: March 18, 2026*
