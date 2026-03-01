# Claude Code Advanced Agent Patterns

*Ephemeral agents, heartbeat monitoring, and specialized agent configurations*

---

## Overview

Claude Code supports sophisticated agent patterns beyond the default agent:

| Pattern | Use Case | Implementation |
|---------|----------|----------------|
| **Ephemeral Agents** | Safe experimentation | Git worktrees + @subagent |
| **Heartbeat Agents** | Periodic monitoring | Hooks + scheduled execution |
| **Agent Teams** | Parallel collaboration | File-disjoint worktrees |
| **Custom Subagents** | Specialized tasks | `@agent-name` invocation |

---

## Ephemeral Agents

### What are Ephemeral Agents?

Ephemeral agents in Claude Code are temporary agent instances that:
- Execute in isolated git worktrees
- Cannot affect the main working directory
- Are automatically cleaned up
- Perfect for testing and experimentation

### Implementation Methods

#### Method 1: Worktree-Based Ephemeral Agents

```bash
# Create isolated worktree
git worktree add -b ephemeral-test ../test-worktree

# Run Claude Code in worktree
claude ../test-worktree

# Experiment safely
# ... make changes, test approaches ...

# Cleanup when done
git worktree remove ../test-worktree
git branch -D ephemeral-test
```

#### Method 2: @Explore Subagent (Read-Only Ephemeral)

```
@explore analyze the database schema and report findings
```

The `@explore` agent:
- Is read-only (cannot modify files)
- Runs in isolated context
- Reports back to main agent
- Perfect for safe investigation

#### Method 3: @Plan Subagent (Planning Ephemeral)

```
@plan create a detailed implementation plan for the auth system
```

The `@plan` agent:
- Cannot modify files
- Focuses on analysis and planning
- Provides structured output
- Safe for sensitive code review

#### Method 4: Background Agents (Ephemeral Execution)

```
Run a background agent to analyze test coverage while I work on implementation
```

Background agents:
- Run in parallel
- Use isolated worktrees
- Report back when complete
- Don't block main workflow

### Ephemeral Agent Configuration

Create `.claude/agents/ephemeral.json`:

```json
{
  "name": "ephemeral-test",
  "description": "Temporary agent for safe experimentation",
  "system": "You are an ephemeral testing agent.\n\nGuidelines:\n1. Experiment boldly - your changes are isolated\n2. Try multiple approaches\n3. Document what works and what doesn't\n4. Report findings concisely\n\nYour work will be discarded after reporting.",
  "allowed_tools": ["Read", "Grep", "Glob", "Bash"],
  "context": "fork"
}
```

Use with:
```
@ephemeral-test try implementing this feature using approach A
```

---

## Heartbeat Agents

### What are Heartbeat Agents?

Heartbeat agents perform periodic checks and monitoring:
- Run on a schedule (e.g., every 30 minutes)
- Monitor system health
- Report status or take action
- Continue until stopped

### Implementation via Hooks

#### SessionStart + SessionEnd Hooks

```json
// .claude/settings.json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/start-heartbeat.sh"
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/stop-heartbeat.sh"
          }
        ]
      }
    ]
  }
}
```

```bash
#!/bin/bash
# .claude/hooks/start-heartbeat.sh

# Start heartbeat in background
(
  while true; do
    sleep 1800  # 30 minutes
    echo "[$(date)] Heartbeat check" >> ~/.claude/heartbeat.log
    
    # Run health checks
    if ! npm test --silent; then
      echo "[$(date)] Tests failing!" >> ~/.claude/heartbeat.log
    fi
  done
) &

echo $! > ~/.claude/heartbeat.pid
```

#### Periodic Tool Execution

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/periodic-check.sh"
          }
        ]
      }
    ]
  }
}
```

```bash
#!/bin/bash
# .claude/hooks/periodic-check.sh

# Check if 30 minutes passed since last check
LAST_CHECK=$(cat ~/.claude/last-check.timestamp 2>/dev/null || echo 0)
NOW=$(date +%s)
DELTA=$((NOW - LAST_CHECK))

if [ $DELTA -gt 1800 ]; then
  # Run checks
  echo "Running periodic checks..."
  
  # Check for security updates
  npm audit --audit-level moderate
  
  # Update timestamp
  echo $NOW > ~/.claude/last-check.timestamp
fi
```

### Heartbeat via /batch Command

```
/batch every 30 minutes check for dependency updates and create PR if found
```

The `/batch` command can:
- Run on a schedule
- Create background agents
- Open PRs automatically
- Report status

### Heartbeat Monitoring Agent

Create `.claude/agents/monitor.json`:

```json
{
  "name": "monitor",
  "description": "Monitoring agent for periodic health checks",
  "system": "You are a monitoring agent. Run checks and report only issues.\n\nChecks to perform:\n1. Test status\n2. Security vulnerabilities\n3. Outdated dependencies\n4. Documentation drift\n\nReport format:\n- [Check]: [Status] - [Details if failed]\n\nBe concise. Only report failures.",
  "allowed_tools": ["Read", "Bash", "Grep"],
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Run all monitoring checks and report any issues found."
          }
        ]
      }
    ]
  }
}
```

---

## Agent Teams (Parallel Ephemeral Agents)

### What are Agent Teams?

Agent teams allow multiple agents to work in parallel on different aspects of a task:

```
Coordinator Agent
    ├── Agent 1 (worktree 1) ── Task A
    ├── Agent 2 (worktree 2) ── Task B
    └── Agent 3 (worktree 3) ── Task C
```

### Using /batch for Agent Teams

```
/batch implement user authentication system
```

This will:
1. Analyze the codebase
2. Create 5-30 independent tasks
3. Spawn agents in isolated worktrees
4. Each agent implements their task
5. Results aggregated
6. PRs created (optional)

### Manual Agent Teams

```
Implement the full-stack feature:

@backend create the API endpoints and database schema
@frontend implement the React components
@qa write comprehensive tests for the feature

Work in parallel and coordinate through the shared specification.
```

### File-Disjoint Parallel Execution

Rules for agent teams:
- Each agent edits different files
- No overlapping file access
- Task claiming via `.claude/current_tasks/`
- Automatic coordination

```
.claude/current_tasks/
├── agent-1.txt  → "Working on: src/backend/auth.ts"
├── agent-2.txt  → "Working on: src/frontend/Login.tsx"
└── agent-3.txt  → "Working on: tests/auth.test.ts"
```

---

## Custom Subagent Patterns

### Pattern 1: Domain Specialist

`.claude/agents/database.json`:

```json
{
  "name": "database",
  "description": "Database schema design and optimization specialist",
  "system": "You are a database specialist.\n\nExpertise:\n- PostgreSQL schema design\n- Query optimization\n- Index selection\n- Migration planning\n\nApproach:\n1. Analyze existing schema\n2. Identify bottlenecks\n3. Propose optimizations\n4. Provide migration scripts",
  "allowed_tools": ["Read", "Grep", "Glob"],
  "model": "claude-3-5-sonnet-20241022"
}
```

Usage:
```
@database optimize the user queries - they're slow
```

### Pattern 2: Review Specialist

`.claude/agents/security-reviewer.json`:

```json
{
  "name": "security-reviewer",
  "description": "Security-focused code reviewer",
  "system": "You review code for security vulnerabilities.\n\nFocus areas:\n- Input validation\n- Authentication/authorization\n- SQL injection\n- XSS vulnerabilities\n- Secret exposure\n\nOutput format:\n1. Severity: [Critical/High/Medium/Low]\n2. Location: [file:line]\n3. Issue: [description]\n4. Fix: [code suggestion]",
  "allowed_tools": ["Read", "Grep"],
  "temperature": 0.1
}
```

### Pattern 3: Context-Specific Agent

`.claude/agents/onboarding.json`:

```json
{
  "name": "onboarding",
  "description": "Helps new developers understand the codebase",
  "system": "You help onboard new developers.\n\nTasks:\n1. Explain project structure\n2. Identify key files\n3. Document conventions\n4. Answer architecture questions\n\nBe thorough and beginner-friendly.",
  "allowed_tools": ["Read", "Grep", "Glob", "Bash"]
}
```

---

## Advanced Hook Patterns

### Pattern 1: Ephemeral Sandbox Hook

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/sandbox-check.sh"
          }
        ]
      }
    ]
  }
}
```

```bash
#!/bin/bash
# Validate command safety
read -r input
COMMAND=$(echo "$input" | jq -r '.tool_input.command')

# Block dangerous commands in non-ephemeral sessions
if [[ "$COMMAND" =~ rm\ -rf|sudo|mkfs ]]; then
  # Check if in ephemeral worktree
  if ! git worktree list | grep -q "$(pwd)"; then
    jq -n '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "deny",
        permissionDecisionReason: "Destructive command blocked in non-ephemeral session. Use ephemeral worktree for dangerous operations."
      }
    }'
  fi
fi
```

### Pattern 2: Heartbeat Logging Hook

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/log-change.sh"
          }
        ]
      }
    ],
    "SessionIdle": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/session-summary.sh"
          }
        ]
      }
    ]
  }
}
```

### Pattern 3: Auto-Cleanup Hook

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/cleanup-ephemeral.sh"
          }
        ]
      }
    ]
  }
}
```

```bash
#!/bin/bash
# Cleanup ephemeral worktrees on session end

git worktree list | grep ephemeral | while read -r line; do
  WORKTREE=$(echo "$line" | awk '{print $1}')
  echo "Cleaning up: $WORKTREE"
  git worktree remove "$WORKTREE" --force 2>/dev/null || true
done
```

---

## Skill-Based Agent Extensions

### Bundled Skills as Agents

```
/simplify   → Spawns review agents (code reuse, quality, efficiency)
/batch      → Spawns multiple implementation agents
/debug      → Spawns troubleshooting agent
```

### Custom Skills as Agents

`.claude/skills/deployment/SKILL.md`:

```markdown
---
name: deployment
description: Production deployment agent
disable-model-invocation: true
context: fork
---

You are a deployment agent.

Safety checks:
1. All tests passing
2. Security scan clean
3. Database migrations reviewed
4. Rollback plan ready

Deployment steps:
1. Run final tests
2. Deploy to staging
3. Smoke tests
4. Deploy to production
5. Verify health checks

Report status at each step.
```

Usage:
```
/deployment perform production release v1.2.3
```

---

## Agent Lifecycle Management

### Starting Agents

| Command | Agent Type | Duration |
|---------|-----------|----------|
| `claude` | Default agent | Session |
| `claude --worktree <path>` | Ephemeral agent | Until worktree removed |
| `@explore` | Read-only ephemeral | Single query |
| `@custom-agent` | Custom subagent | Task completion |
| `/batch` | Multiple ephemeral | Until all tasks complete |

### Monitoring Agents

```bash
# Check running agents
ls .claude/current_tasks/

# View agent logs
tail -f .claude/logs/agent.log

# Check worktrees
git worktree list
```

### Stopping Agents

```bash
# Stop subagent (from parent)
"Stop working on that task"

# Remove worktree
git worktree remove <path>

# Force cleanup
rm -rf .claude/worktrees/*
git worktree prune
```

---

## Best Practices

### Ephemeral Agents
✅ Do:
- Use for experimentation
- Clean up after use
- Report findings back to parent

❌ Don't:
- Store important state in ephemeral agents
- Forget to cleanup worktrees
- Run long-term tasks in ephemeral mode

### Heartbeat Agents
✅ Do:
- Keep checks lightweight
- Log failures clearly
- Use appropriate intervals

❌ Don't:
- Block on long operations
- Spam notifications
- Run expensive checks too frequently

### Agent Teams
✅ Do:
- Ensure file-disjoint tasks
- Clear task boundaries
- Use worktree isolation

❌ Don't:
- Have agents edit same files
- Create circular dependencies
- Forget to aggregate results

---

*Last Updated: March 1, 2026*
