# Context Management for Long-Running Sessions

*Strategies to extend agent session length and maintain coherence*

---

## Overview

The context window is like working memory - expensive and limited. For long-running sessions, effective context management is the difference between success and failure. In practice, sessions exceeding a few hours typically require active context management techniques; multi-hour sessions are common, though the upper bound depends heavily on task complexity, model, and tooling.

**The Context Rot Problem**:
- Performance degrades sharply beyond 10k-32k tokens
- Agents lose track of earlier decisions
- Task success rate drops significantly with context bloat

---

## Understanding Context Budget

### Token Allocation

```
┌──────────────────────────────────────────────────────────────┐
│                     CONTEXT WINDOW                           │
├──────────────────────────────────────────────────────────────┤
│ System Prompt        │ ~500 tokens                           │
├──────────────────────────────────────────────────────────────┤
│ Tool Descriptions    │ ~1000 tokens                          │
├──────────────────────────────────────────────────────────────┤
│ Active Codebase      │ ~2000 tokens                          │
├──────────────────────────────────────────────────────────────┤
│ Working Buffer       │ ~2000 tokens                          │
├──────────────────────────────────────────────────────────────┤
│ Conversation History │ Variable (managed)                    │
├──────────────────────────────────────────────────────────────┤
│ Reserve/Headroom     │ ~2000 tokens                          │
└──────────────────────────────────────────────────────────────┘
                         Total: Context limit (e.g., 200k)
```

### The 60% Rule

Keep context usage under 60% of window:
- Leaves room for new information
- Prevents emergency compaction
- Maintains performance

---

## Context Management Strategies

### 1. Context Editing (Auto-Pruning)

**Technique**: Automatically remove oldest tool outputs

**Implementation in OpenCode**:
```json
{
  "compaction": {
    "auto": true,
    "prune": true,
    "maxContext": 100000
  }
}
```

**Benefits**: 29% performance boost

**When to use**:
- Repetitive tool calls (file reads, searches)
- Stable project state (not actively changing)
- Long-running single task

### 2. Memory Tool Pattern

**Technique**: Read/write to persistent files instead of relying on context

**Implementation**:
```markdown
# memory.md

## Current Task
Implementing user authentication per SPEC.md

## Progress
- Done: Database schema created
- Done: Registration endpoint complete
- In progress: Login endpoint

## Decisions Made
- Using bcrypt with cost factor 12
- JWT tokens with 24h expiry
- Rate limiting: 5 attempts per minute

## Next Steps
1. Complete login endpoint
2. Add JWT validation middleware
3. Write tests

## Blockers
None currently
```

**Benefits**: 39% performance boost

**When to use**:
- Multi-session work
- Complex projects with many decisions
- Need to resume after interruption

### 3. Combined Approach

**Technique**: Use both context editing and memory tool together

**Benefits**: 84% token reduction

**Implementation**:
```bash
# 1. Configure auto-pruning
# 2. Use memory.md for persistent state
# 3. Regular checkpoints to files

# Session start
opencode run "Read memory.md and continue where we left off"

# During work
opencode run "Update memory.md with progress, then implement next step"

# Session end
opencode run "Update memory.md with final state and next steps for tomorrow"
```

### 4. Progressive Disclosure

**Technique**: Load information only when needed

**Standard Approach** (inefficient):
```
Load all skills at startup (~5000 tokens)
-> Most never used
-> Context bloat
```

**Progressive Disclosure** (efficient):
```
Load skill name/description only (~50 tokens)
-> Triggered by need
-> Full content loaded just-in-time
-> Context efficient
```

**OpenCode Implementation**:
```json
// In agent/skill definition
{
  "skills": [
    {
      "name": "database",
      "description": "Database schema and queries",
      "lazy": true,
      "content": "Full content here..."  // Loaded only when triggered
    }
  ]
}
```

### 5. Summarization-on-the-Fly

**Technique**: Compress conversation history periodically

**Implementation**:
```
Every 20 turns:
1. Pause execution
2. Summarize conversation so far
3. Replace history with summary
4. Continue
```

**Example**:
```
Before summarization: 15000 tokens
  [Full conversation history]

After summarization: 500 tokens
  "Summary: We've implemented the database schema and
   registration endpoint. Current task is implementing
   login with JWT tokens. Using bcrypt for hashing,
   planning 24h token expiry."
```

### 6. Vector Search for Context Retrieval

**Technique**: Store context in vector DB, retrieve relevant parts

**Architecture**:
```
┌─────────────┐      ┌──────────────┐      ┌─────────────┐
│   Query     │─────▶│ Vector Store │─────▶│  Relevant   │
│  (current   │      │  (context    │      │  Context    │
│   task)     │      │   chunks)    │      │  Retrieved  │
└─────────────┘      └──────────────┘      └─────────────┘
```

**Use case**:
- Large codebases
- Complex documentation
- Multi-project work

---

## Session Management Patterns

### Pattern 1: Checkpoint-Based Sessions

```
┌────────────────────────────────────────────────────────────┐
│                    SESSION WORKFLOW                        │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  Start ──▶ Work ──▶ Checkpoint ──▶ Work ──▶ Checkpoint   │
│           (1-2h)    (git commit)   (1-2h)    (git commit) │
│                                                            │
│  ──▶ Complete ──▶ Summary ──▶ End                         │
│       (final      (memory.md)                             │
│        commit)                                            │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

**Implementation**:
```bash
#!/bin/bash
# checkpoint.sh

# Regular checkpoint every 30 minutes
while true; do
  sleep 1800

  # Auto-commit changes
  git add -A
  git commit -m "Checkpoint: $(date '+%Y-%m-%d %H:%M')"

  # Update memory
  echo "Checkpoint at $(date)" >> memory.md
done
```

### Pattern 2: Topic-Based Sessions

**Principle**: Don't mix topics in one session

**Bad**:
```
Session: "Implement auth AND refactor database AND fix CSS"
-> 39% performance drop
-> Context pollution
```

**Good**:
```
Session 1: "Implement auth"
Session 2: "Refactor database"
Session 3: "Fix CSS"
-> Each has focused context
-> Better results
```

### Pattern 3: Cross-Session Notes

Agents leave notes for future sessions:

```markdown
# session-notes.md

## Session 2026-03-01
**Worked on**: User authentication
**Completed**: Database schema, registration endpoint
**Blockers**: None
**Next Session**: Start with login endpoint
**Key Files**: src/auth/, src/models/user.ts
**Decisions**: Using bcrypt cost 12, JWT 24h expiry
```

---

## Context Rot Indicators

Watch for these signals that context is degrading:

| Indicator | Meaning | Action |
|-----------|---------|--------|
| Repetitive questions | Forgetting earlier decisions | Update memory.md |
| Contradictory actions | Losing track of approach | Summarize and compact |
| Hallucinated file contents | Context overflow | Re-read files |
| Wrong assumptions | Missing key context | Start new session |
| Slow responses | Processing overhead | Prune context |

---

## Recovering from Context Rot

When context rot has already set in, the agent is producing unreliable output. Continuing without intervention will make things worse. Follow these steps:

### Step 1: Stop and Assess

Do not let the agent continue making changes. Check for:
- Incorrect file modifications (review `git diff`)
- Contradictory commits (review `git log` for conflicting changes)
- Hallucinated content (files referenced that do not exist)

### Step 2: Revert Damaged Work

```bash
# See what changed since last known-good state
git log --oneline -10
git diff <last-good-commit> HEAD

# Revert to last known-good checkpoint
git revert HEAD~N..HEAD   # or git reset if appropriate
```

### Step 3: Capture Current State

Before starting a new session, write down what the rotted session actually accomplished:

```bash
# Create a handoff document from the damaged session
cat > recovery-notes.md << 'EOF'
## Recovery Notes

### What was completed successfully (verified)
- Database migration created and tested
- Registration endpoint working (tests pass)

### What needs to be redone
- Login endpoint (agent started contradicting its own approach)
- JWT middleware (hallucinated a library that doesn't exist)

### Key decisions to preserve
- bcrypt cost factor 12
- JWT 24h expiry
- Rate limit: 5 attempts/min

### Files to review before continuing
- src/routes/auth.ts (partially complete, may have issues)
- src/middleware/jwt.ts (created but uses wrong library)
EOF
```

### Step 4: Start a Fresh Session

```bash
# Start new session with clean context
opencode

# First prompt: load recovery state
"Read recovery-notes.md and memory.md. Resume work on the login endpoint.
Do NOT re-implement anything listed as completed. Focus on the items
listed under 'What needs to be redone'."
```

### Step 5: Prevent Recurrence

- Set up more frequent checkpoints (every 15-20 minutes instead of 30)
- Lower the compaction threshold (e.g., 50% instead of 60%)
- Use the memory file more aggressively -- update it after every completed subtask
- Consider splitting the remaining work across multiple shorter sessions

---

## OpenCode Configuration

### Recommended Settings

```json
// opencode.json
{
  "model": "anthropic/claude-sonnet-4",

  "compaction": {
    "auto": true,
    "prune": true,
    "strategy": "oldest-first",
    "threshold": 0.6,
    "reserved": 10000
  },

  "context": {
    "includeHistory": true,
    "summarizeThreshold": 15000,
    "maxTurns": 50
  },

  "memory": {
    "enabled": true,
    "file": "memory.md"
  }
}
```

### Manual Compaction

```bash
# Compact conversation history
opencode compact

# Or in session
> /compact
```

---

## Best Practices

### DO

- **Monitor context usage**: Check regularly, compact proactively
- **Use memory files**: Persistent storage beats context
- **Checkpoint frequently**: Git commits are cheap
- **Summarize at breakpoints**: Natural stopping points
- **Keep sessions focused**: One topic per session
- **Start fresh when stuck**: Sometimes new session > continuing

### DON'T

- **Don't let context grow unbounded**: Performance degrades
- **Don't mix unrelated topics**: Context pollution
- **Don't ignore context rot indicators**: Act when you see them
- **Don't rely on context for persistence**: Files are more reliable

---

## Measuring Effectiveness

Track these metrics:

| Metric | Target | Measurement |
|--------|--------|-------------|
| Context efficiency | < 60% usage | opencode status |
| Task completion rate | > 90% | Tasks finished / started |
| Context switches | < 3 per session | New sessions needed |
| Recovery time | < 5 min | Time to resume after break |

---

## Cross-References

- [01 - Ralph Loops](01-ralph-loops.md): Ralph Loops accumulate context quickly; pair with aggressive compaction.
- [02 - Spec-Driven Development](02-spec-driven-development.md): Specs serve as external memory, reducing what the agent must hold in context.
- [03 - Agent Teams](03-agent-teams.md): Each agent in a team has its own context; use the Memory Keeper role to coordinate shared state.
- [05 - Session Teleportation](05-session-teleportation.md): Teleporting sessions preserves context state; compact before teleporting to minimize transfer size.
- [METHODOLOGIES.md](../METHODOLOGIES.md): Overview of all methodologies.

---

## Research Backing

Sources:
- [Anthropic - Effective Harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Reddit - Claude Code V4 Guide](https://www.reddit.com/r/ClaudeAI/comments/1qquxle/the_complete_guide_to_claude_code_v4_the/)
- [Medium - Context Management](https://bytebridge.medium.com/ai-agents-context-management-breakthroughs-and-long-running-task-execution-d5cee32aeaa4)

---

*Last Updated: March 18, 2026*
