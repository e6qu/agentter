# Claude Code Complete Setup Tutorial

*Production-ready development environment with skills, agents, security, and automation*

---

## Table of Contents

1. [Initial Setup](#initial-setup)
2. [Project Structure](#project-structure)
3. [Credential Protection](#credential-protection)
4. [Proxy Configuration](#proxy-configuration)
5. [Skills Setup](#skills-setup)
6. [Custom Agents](#custom-agents)
7. [Heartbeat Agents](#heartbeat-agents)
8. [Hooks & Automation](#hooks--automation)
9. [Sandboxing & Security](#sandboxing--security)
10. [Deterministic Checks](#deterministic-checks)
11. [Complete Configuration Example](#complete-configuration-example)

---

## Initial Setup

### Step 1: Install Claude Code

```bash
# macOS
brew install claude-code

# Or via npm
npm install -g @anthropics/claude-code

# Verify installation
claude --version
```

### Step 2: Authentication

```bash
# Interactive login (recommended)
claude auth login

# Or use API key (for CI/automation)
export ANTHROPIC_API_KEY="sk-ant-api-..."

# Verify
claude auth status
```

### Step 3: Initialize Project

```bash
cd /path/to/your-project
claude /init

# This creates:
# .claude/
# ├── settings.json
# ├── agents/
# ├── skills/
# └── hooks/
```

---

## Project Structure

Create this structure in your project:

```
your-project/
├── .claude/
│   ├── settings.json              # Main configuration
│   ├── settings.local.json        # Local overrides (gitignored)
│   ├── CLAUDE.md                  # Project instructions
│   ├── agents/                    # Custom agents
│   │   ├── security-reviewer.json
│   │   ├── performance-expert.json
│   │   └── unstuck-monitor.json   # Heartbeat agent
│   ├── skills/                    # Reusable skills
│   │   ├── onboarding/
│   │   │   └── SKILL.md
│   │   ├── deployment/
│   │   │   └── SKILL.md
│   │   └── code-review/
│   │       └── SKILL.md
│   ├── hooks/                     # Automation scripts
│   │   ├── pre-commit.sh
│   │   ├── safety-check.sh
│   │   ├── unstuck-detector.sh    # Heartbeat script
│   │   └── credential-guard.sh
│   └── sandbox/                   # Sandboxing configs
│       └── docker-compose.yml
├── .claude.md                     # Alternative: Project instructions
└── .gitignore                     # Must exclude .claude/settings.local.json
```

### Gitignore Setup

```bash
# Add to .gitignore
cat >> .gitignore << 'EOF'
# Claude Code local settings
.claude/settings.local.json
.claude/.credentials/
.claude/.logs/
.claude/.sandbox/
.claude/.heartbeat/
.claude/.ci-checks/

# State files
.claude/.deterministic/
.claude/.code-reviews/
EOF
```

---

## Credential Protection

### Strategy 1: Environment Variables

```bash
# ~/.bashrc or ~/.zshrc
export ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}"
export GITHUB_TOKEN="${GITHUB_TOKEN}"
export DATABASE_URL="${DATABASE_URL}"

# Never hardcode in files!
```

### Strategy 2: Local Settings File (Gitignored)

```json
{
  "env": {
    "ANTHROPIC_API_KEY": "${ANTHROPIC_API_KEY}",
    "AWS_ACCESS_KEY_ID": "${AWS_ACCESS_KEY_ID}",
    "AWS_SECRET_ACCESS_KEY": "${AWS_SECRET_ACCESS_KEY}"
  },
  "credentials": {
    "store": "keychain",
    "service": "claude-code-your-project"
  }
}
```

### Strategy 3: Credential Guard Hook

```bash
#!/bin/bash
# .claude/hooks/credential-guard.sh

read -r input

# Patterns that might contain secrets
DANGEROUS_PATTERNS=(
  "api[_-]?key.*="
  "password.*="
  "secret.*="
  "token.*="
  "private[_-]?key"
  "AKIA[0-9A-Z]{16}"
  "gh[pousr]_[A-Za-z0-9_]{36}"
  "sk-[a-zA-Z0-9]{48}"
)

if echo "$input" | jq -e '.tool == "Write" or .tool == "Edit"' > /dev/null 2>&1; then
  content=$(echo "$input" | jq -r '.tool_input.content // .tool_input.old_string // ""')
  file=$(echo "$input" | jq -r '.tool_input.path // ""')
  
  for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    if echo "$content" | grep -iE "$pattern" > /dev/null; then
      echo "POTENTIAL CREDENTIAL LEAK DETECTED in $file"
      
      jq -n '{
        hookSpecificOutput: {
          hookEventName: "PreToolUse",
          permissionDecision: "deny",
          permissionDecisionReason: "Potential credential detected. Use environment variables instead."
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

### HTTP/HTTPS Proxy

```bash
# ~/.bashrc or session export
export HTTP_PROXY="http://proxy.company.com:8080"
export HTTPS_PROXY="http://proxy.company.com:8080"
export NO_PROXY="localhost,127.0.0.1,.local"
export CLAUDE_CODE_PROXY="http://proxy.company.com:8080"
```

### Proxy in Settings

```json
{
  "proxy": {
    "http": "http://proxy.company.com:8080",
    "https": "http://proxy.company.com:8080",
    "noProxy": ["localhost", "127.0.0.1", ".local"],
    "strictSSL": false
  }
}
```

---

## Skills Setup

### Skill 1: Project Onboarding

```markdown
---
name: onboarding
description: Help new developers understand this codebase
license: MIT
metadata:
  category: documentation
  audience: new-developers
---

## What I Do

Help new team members understand:
- Project structure and architecture
- Development workflow
- Testing practices
- Deployment process
- Key conventions

## Quick Start

1. Install dependencies: `npm install`
2. Copy `.env.example` to `.env`
3. Run migrations: `npm run db:migrate`
4. Start dev server: `npm run dev`
```

### Skill 2: Deployment

```markdown
---
name: deployment
description: Production deployment workflow
disable-model-invocation: true
context: fork
metadata:
  category: devops
  risk: high
---

## Safety Checklist

- [ ] All tests passing
- [ ] Security scan clean
- [ ] Database migrations reviewed
- [ ] Rollback plan documented

## Deployment Steps

1. Run tests: `npm test`
2. Deploy to staging: `npm run deploy:staging`
3. Run smoke tests
4. Deploy to production: `npm run deploy:production`
```

---

## Custom Agents

### Agent 1: Security Reviewer

```json
{
  "name": "security-reviewer",
  "description": "Security-focused code reviewer",
  "system": "You are a security expert reviewing code for vulnerabilities.\n\nFOCUS AREAS:\n1. Input validation\n2. SQL injection\n3. XSS vulnerabilities\n4. Authentication flaws\n5. Secret exposure\n\nOUTPUT FORMAT:\n### CRITICAL\n- File:Line: Issue -> Fix\n\n### HIGH\n- File:Line: Issue -> Fix",
  "allowed_tools": ["Read", "Grep", "Glob"],
  "temperature": 0.1
}
```

### Agent 2: Unstuck Monitor

```json
{
  "name": "unstuck-monitor",
  "description": "Monitors main agent and suggests when stuck",
  "system": "You detect when the main agent is stuck.\n\nSTUCK INDICATORS:\n- Same file edited >5 times\n- Error messages repeating\n- No progress for 10+ minutes\n\nWHEN DETECTED:\n1. Analyze current approach\n2. Identify blocking issue\n3. Suggest alternative strategies",
  "allowed_tools": ["Read", "Grep", "Bash"]
}
```

---

## Heartbeat Agents

### Unstuck Detection Heartbeat

```bash
#!/bin/bash
# .claude/hooks/unstuck-detector.sh

STATE_DIR=".claude/.heartbeat"
mkdir -p "$STATE_DIR"

TRACKED_FILES="$STATE_DIR/tracked_files.txt"
LAST_CHECK="$STATE_DIR/last_unstuck_check"

# Check for repetitive patterns
check_repetitive_patterns() {
  if [ -f ".claude/logs/session.log" ]; then
    ERROR_COUNT=$(grep -c "Error:" .claude/logs/session.log 2>/dev/null || echo "0")
    UNIQUE_ERRORS=$(grep "Error:" .claude/logs/session.log 2>/dev/null | sort -u | wc -l)
    
    if [ "$ERROR_COUNT" -gt 10 ] && [ "$UNIQUE_ERRORS" -lt 3 ]; then
      echo "STUCK: Repetitive errors ($ERROR_COUNT errors, $UNIQUE_ERRORS unique)"
      return 1
    fi
  fi
  return 0
}

# Check for edit loops
check_edit_loops() {
  if [ -f "$CHANGE_LOG" ]; then
    MOST_EDITED=$(tail -100 "$CHANGE_LOG" | sort | uniq -c | sort -rn | head -1)
    EDIT_COUNT=$(echo "$MOST_EDITED" | awk '{print $1}')
    
    if [ "$EDIT_COUNT" -gt 10 ]; then
      echo "STUCK: File edited $EDIT_COUNT times"
      return 1
    fi
  fi
  return 0
}

# Run checks
if ! check_repetitive_patterns || ! check_edit_loops; then
  echo "Triggering unstuck intervention..."
  
  claude -p "The main agent appears stuck. Analyze and suggest alternatives." \
         --agent unstuck-monitor \
         --output /tmp/unstuck-suggestion.txt 2>/dev/null || true
  
  echo "UNSTUCK MONITOR ALERT"
  cat /tmp/unstuck-suggestion.txt 2>/dev/null || echo "Check logs for details"
fi

touch "$LAST_CHECK"
```

### Scheduled Health Check

```bash
#!/bin/bash
# .claude/hooks/health-check.sh

STATE_DIR=".claude/.heartbeat"
LAST_RUN_FILE="$STATE_DIR/last_health_check"
INTERVAL=1800  # 30 minutes

# Time-based check
if [ -f "$LAST_RUN_FILE" ]; then
  LAST_RUN=$(cat "$LAST_RUN_FILE")
  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_RUN))
  
  if [ $ELAPSED -lt $INTERVAL ]; then
    exit 0
  fi
fi

# Run checks
echo "[$(date)] Running health checks..."

npm test --silent && echo "Tests: PASS" || echo "Tests: FAIL"
npm audit --audit-level moderate 2>/dev/null | grep -q "0 vulnerabilities" && echo "Security: PASS" || echo "Security: WARN"

date +%s > "$LAST_RUN_FILE"
```

---

## Hooks & Automation

### Pre-Tool Safety Hook

```bash
#!/bin/bash
# .claude/hooks/safety-check.sh

read -r input

tool=$(echo "$input" | jq -r '.tool')
command=$(echo "$input" | jq -r '.tool_input.command // empty')

if [ "$tool" = "Bash" ]; then
  # Block destructive commands
  if echo "$command" | grep -qE "rm\s+-rf\s+/|sudo|mkfs|dd\s+if="; then
    if ! git worktree list | grep -q "$(pwd)"; then
      jq -n '{
        hookSpecificOutput: {
          hookEventName: "PreToolUse",
          permissionDecision: "deny",
          permissionDecisionReason: "Destructive command blocked. Use ephemeral worktree."
        }
      }'
      exit 0
    fi
  fi
fi

echo "$input"
```

### Session Start Hook

```bash
#!/bin/bash
# .claude/hooks/session-start.sh

echo "Claude Code session started"
echo ""

# Show available agents
echo "Available agents:"
ls -1 .claude/agents/*.json 2>/dev/null | while read -r agent; do
  name=$(basename "$agent" .json)
  echo "  @${name}"
done

# Load credentials
if [ -f ".claude/.credentials/local.env" ]; then
  source .claude/.credentials/local.env
  echo "Credentials loaded"
fi
```

---

## Sandboxing & Security

### Docker-based Sandboxing

```yaml
version: '3.8'
services:
  claude-sandbox:
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

### Ephemeral Worktree Script

```bash
#!/bin/bash
# scripts/claude-ephemeral.sh

PROJECT_NAME=$(basename "$(pwd)")
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
WORKTREE_NAME="ephemeral-${PROJECT_NAME}-${TIMESTAMP}"
WORKTREE_PATH="${HOME}/.claude-worktrees/${WORKTREE_NAME}"

mkdir -p "${HOME}/.claude-worktrees"
git worktree add -b "ephemeral/${WORKTREE_NAME}" "$WORKTREE_PATH"

echo "Ephemeral worktree ready: $WORKTREE_PATH"
echo "Start: claude $WORKTREE_PATH"
echo "Cleanup: git worktree remove $WORKTREE_PATH"
```

---

## Deterministic Checks

### Centralized Library

```bash
#!/bin/bash
# .claude/hooks/lib/deterministic.sh

DETERMINISTIC_DIR=".claude/.deterministic"
mkdir -p "$DETERMINISTIC_DIR"

# Checksum-based check
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

# Time-based check
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

# Mark complete
deterministic_mark() {
  local marker="$1"
  if [ "$marker" != "false" ]; then
    mkdir -p "$(dirname "$marker")"
    date -Iseconds > "$marker"
  fi
}
```

### Usage Example

```bash
source .claude/hooks/lib/deterministic.sh

marker=$(deterministic_time 1800 "health-check")

if [ "$marker" = "false" ]; then
  echo "Health check already run recently"
  exit 0
fi

# Run expensive check...

deterministic_mark "$marker"
```

---

## Complete Configuration Example

```json
{
  "name": "your-project",
  "description": "Production-ready Claude Code setup",
  
  "agents": {
    "security-reviewer": {
      "description": "Security-focused code reviewer",
      "system": "You are a security expert...",
      "allowed_tools": ["Read", "Grep"],
      "temperature": 0.1
    },
    "unstuck-monitor": {
      "description": "Detects when main agent is stuck",
      "system": "You detect stuck states...",
      "allowed_tools": ["Read", "Bash"]
    }
  },
  
  "hooks": {
    "SessionStart": [
      { "type": "command", "command": ".claude/hooks/session-start.sh" }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": ".claude/hooks/safety-check.sh" }
        ]
      }
    ]
  },
  
  "permissions": {
    "allow": {
      "Bash": ["npm test", "npm run build", "git status"],
      "Edit": ["src/**/*"]
    },
    "deny": {
      "Bash": ["rm -rf /*", "sudo*"],
      "Edit": [".env*", "*.key"]
    }
  }
}
```

---

*Last Updated: March 1, 2026*
