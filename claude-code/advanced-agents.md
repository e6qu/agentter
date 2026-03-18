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
Do:
- Use for experimentation
- Clean up after use
- Report findings back to parent

Don't:
- Store important state in ephemeral agents
- Forget to cleanup worktrees
- Run long-term tasks in ephemeral mode

### Heartbeat Agents
Do:
- Keep checks lightweight
- Log failures clearly
- Use appropriate intervals

Don't:
- Block on long operations
- Spam notifications
- Run expensive checks too frequently

### Agent Teams
Do:
- Ensure file-disjoint tasks
- Clear task boundaries
- Use worktree isolation

Don't:
- Have agents edit same files
- Create circular dependencies
- Forget to aggregate results

---

## Triggering Claude Code CLI from Hooks

### Overview

Claude Code can be triggered programmatically from hook scripts to create autonomous workflows, scheduled tasks, and CI/CD integrations. Combined with **deterministic checks**, you can create reliable, repeatable automation.

### Basic CLI Invocation

```bash
# Single prompt, non-interactive
claude -p "Refactor the auth module" --allowedTools "Read,Grep,Edit"

# With specific subagent
claude -p "@security-reviewer audit src/auth.ts"

# Ephemeral worktree execution
cd /tmp/ephemeral-check && claude -p "Run tests and report"
```

### CLI Flags Reference

| Flag | Description | Example |
|------|-------------|---------|
| `-p, --print` | Execute prompt non-interactively | `-p "Fix bug"` |
| `--allowedTools` | Restrict tools | `--allowedTools "Read,Bash"` |
| `--permission-mode` | Set permission level | `--permission-mode plan` |
| `--continue, --resume` | Resume last conversation | `--continue` |
| `--add-dir` | Add directory to session | `--add-dir ../lib` |

### Pattern 1: Pre-Commit Hook with Deterministic Checks

```bash
#!/bin/bash
# .claude/hooks/pre-commit-claude.sh

# Deterministic: Check if this exact check has been run
CHECKSUM=$(git diff --cached --name-only | sort | xargs cat 2>/dev/null | sha256sum | cut -d' ' -f1)
STATE_FILE=".claude/.pre-commit-checks/$CHECKSUM"

if [ -f "$STATE_FILE" ]; then
  echo "Pre-commit checks already passed for this state"
  exit 0
fi

mkdir -p ".claude/.pre-commit-checks"

# Run Claude Code for review
echo "Running Claude Code pre-commit review..."

claude -p "
Review the staged changes for:
1. Security issues (SQL injection, XSS, secret exposure)
2. Code quality (unused imports, complex functions)
3. Test coverage (are tests included?)

STAGED_FILES:\n$(git diff --cached --name-only)

If any issues found, output 'BLOCK: [reason]' on its own line.
If clean, output 'PASS'.
" --allowedTools "Read,Grep" > /tmp/claude-review.txt

# Deterministic check of results
if grep -q "BLOCK:" /tmp/claude-review.txt; then
  echo "Pre-commit checks failed:"
  grep "BLOCK:" /tmp/claude-review.txt
  exit 1
fi

# Mark as passed for this state
touch "$STATE_FILE"
echo "Pre-commit checks passed"
exit 0
```

Hook configuration:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/pre-commit-claude.sh"
          }
        ]
      }
    ]
  }
}
```

### Pattern 2: Scheduled Heartbeat with Claude

```bash
#!/bin/bash
# .claude/hooks/scheduled-check.sh

# Deterministic: Only run if timestamp check passes
LAST_RUN_FILE=".claude/.heartbeat/last-claude-check"
MIN_INTERVAL=3600  # 1 hour

mkdir -p ".claude/.heartbeat"

if [ -f "$LAST_RUN_FILE" ]; then
  LAST_RUN=$(cat "$LAST_RUN_FILE")
  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_RUN))

  if [ $ELAPSED -lt $MIN_INTERVAL ]; then
    echo "Skipping: ${ELAPSED}s since last check (min: ${MIN_INTERVAL}s)"
    exit 0
  fi
fi

# Run comprehensive analysis with Claude Code
echo "[$(date)] Running scheduled Claude Code analysis..."

claude -p "
You are a monitoring agent. Check the codebase for:
1. Security vulnerabilities (check package.json, requirements.txt, etc.)
2. Outdated dependencies (run npm outdated, pip list --outdated)
3. Documentation drift (check if README matches code)
4. Test failures (run test suite)

For each check:
- Status: PASS/FAIL/WARN
- Details: Brief description
- Action: What to do (if FAIL)

Output as markdown report.
" --allowedTools "Read,Bash,Grep" > ".claude/.heartbeat/report-$(date +%Y%m%d-%H%M%S).md"

# Deterministic: Update timestamp on successful completion
date +%s > "$LAST_RUN_FILE"
echo "[$(date)] Analysis complete"
```

### Pattern 3: Ephemeral CI Check

```bash
#!/bin/bash
# .claude/hooks/ci-check.sh

# Create deterministic state ID from commit
COMMIT=$(git rev-parse HEAD)
STATE_FILE=".claude/.ci-checks/$COMMIT"

if [ -f "$STATE_FILE.pass" ]; then
  echo "CI checks passed for commit $COMMIT"
  exit 0
fi

if [ -f "$STATE_FILE.fail" ]; then
  echo "CI checks failed for commit $COMMIT"
  cat "$STATE_FILE.fail"
  exit 1
fi

mkdir -p ".claude/.ci-checks"

# Create ephemeral worktree for isolation
WORKTREE=".claude/.ci-checks/worktrees/$COMMIT"
git worktree add "$WORKTREE" "$COMMIT" 2>/dev/null || true

# Run Claude Code in ephemeral worktree
cd "$WORKTREE" && claude -p "
Run the full CI pipeline:
1. Install dependencies
2. Run linting
3. Run type checking
4. Run tests
5. Check build

Report: PASS or FAIL with details.
" > "/tmp/ci-result-$COMMIT.txt"

# Return to original directory
cd -

# Cleanup worktree
git worktree remove "$WORKTREE" 2>/dev/null || true

# Check result deterministically
if grep -q "^PASS" "/tmp/ci-result-$COMMIT.txt"; then
  touch "$STATE_FILE.pass"
  echo "CI checks passed"
  exit 0
else
  cp "/tmp/ci-result-$COMMIT.txt" "$STATE_FILE.fail"
  echo "CI checks failed"
  cat "$STATE_FILE.fail"
  exit 1
fi
```

### Pattern 4: Issue Triage Agent

```bash
#!/bin/bash
# .claude/hooks/triage-issues.sh

# Deterministic: Check if issues were triaged today
TRIAGE_MARKER=".claude/.triage/$(date +%Y-%m-%d)"

if [ -f "$TRIAGE_MARKER" ]; then
  echo "Issues already triaged today"
  exit 0
fi

mkdir -p ".claude/.triage"

# Fetch open issues (using gh CLI or API)
gh issue list --state open --limit 50 --json number,title,body,labels > /tmp/open-issues.json

# Triage with Claude Code
claude -p "
Triage these GitHub issues:

$(cat /tmp/open-issues.json | jq -r '.[] | "## Issue #\(.number): \(.title)\nLabels: \(.labels | map(.name) | join(\", \"))\n\(.body[0:500])\n---"')

For each issue, classify:
- Priority: P0 (critical), P1 (important), P2 (nice-to-have)
- Type: bug, feature, docs, question
- Assignment: frontend, backend, devops, or needs-triage

Output JSON format:
[{\"number\": 123, \"priority\": \"P1\", \"type\": \"bug\", \"assignment\": \"backend\"}]
" > /tmp/triage-result.json

# Apply labels deterministically
jq -r '.[] | "\(.number) \(.priority) \(.type)"' /tmp/triage-result.json | while read -r num priority type; do
  gh issue edit "$num" --add-label "$priority,$type"
done

# Mark as triaged
touch "$TRIAGE_MARKER"
echo "Triage complete for $(date +%Y-%m-%d)"
```

### Pattern 5: Code Review Automation

```bash
#!/bin/bash
# .claude/hooks/auto-review.sh

# Trigger on PR webhook or cron
PR_NUMBER="$1"

# Deterministic: Check if already reviewed this PR at this commit
PR_COMMIT=$(gh pr view "$PR_NUMBER" --json headRefOid -q '.headRefOid')
REVIEW_STATE=".claude/.reviews/pr-$PR_NUMBER-$PR_COMMIT"

if [ -f "$REVIEW_STATE" ]; then
  echo "Already reviewed PR #$PR_NUMBER at $PR_COMMIT"
  exit 0
fi

mkdir -p ".claude/.reviews"

# Get PR diff
gh pr diff "$PR_NUMBER" > /tmp/pr-$PR_NUMBER.diff

# Run Claude Code review
claude -p "
Review this PR diff:

$(cat /tmp/pr-$PR_NUMBER.diff)

Provide structured review:
1. Summary (2-3 sentences)
2. Issues found (severity, location, suggestion)
3. Questions for author
4. Approval recommendation: APPROVE / REQUEST_CHANGES / COMMENT

Be thorough but constructive.
" --allowedTools "Read,Grep" > /tmp/pr-review-$PR_NUMBER.md

# Post review comment
gh pr comment "$PR_NUMBER" --body-file /tmp/pr-review-$PR_NUMBER.md

# Mark as reviewed
touch "$REVIEW_STATE"
echo "Review posted for PR #$PR_NUMBER"
```

### Deterministic Check Strategies

| Strategy | Use Case | Implementation |
|----------|----------|----------------|
| **Checksum-based** | File content checks | `sha256sum` of staged files |
| **Timestamp-based** | Time-based throttling | Compare against stored timestamp |
| **Commit-based** | Git state tracking | Use `git rev-parse HEAD` |
| **Marker files** | Daily/periodic tasks | Date-based filenames |
| **Content hash** | Configuration changes | Hash of relevant config files |

### Combining with Hooks

```json
{
  "hooks": {
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
    ],
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/scheduled-check.sh"
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/ci-check.sh"
          }
        ]
      }
    ]
  }
}
```

### Best Practices

Do:
- Use deterministic checks to avoid redundant processing
- Store state in `.claude/` directory (already gitignored)
- Use `--allowedTools` to restrict Claude's capabilities for safety
- Clean up ephemeral worktrees after use
- Log all automation actions for auditability

Don't:
- Run expensive checks on every invocation without throttling
- Store sensitive state outside project directory
- Allow Claude unlimited tool access in automated contexts
- Forget to handle API rate limits

---

*Last Updated: March 18, 2026*
