# Ralph Loops Methodology

*A persistent execution pattern for long-running agent tasks*

---

## Overview

Ralph Loops are named after the [Ralph Wiggum](https://simpsons.fandom.com/wiki/Ralph_Wiggum) plugin from Anthropic. The name references the Simpsons character's oblivious persistence -- Ralph keeps going regardless of obstacles, misunderstandings, or signals to stop. Similarly, the Ralph Loop pattern forces an agent to keep working past the point where it would normally give up.

The Ralph Loop pattern forces the agent to continue working until the task is actually complete, not just until the model thinks it's done.

---

## The Problem

Standard agentic behavior:
1. Agent works on task
2. Agent thinks it's done
3. Agent tries to exit/submit
4. Task may be incomplete or have issues

The agent lacks persistence - it gives up when it encounters friction.

---

## The Solution

```
┌─────────────────────────────────────────────────────────────┐
│                       RALPH LOOP                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌─────────┐    ┌──────────┐    ┌──────────────┐          │
│   │  Work   │───▶│  Check   │───▶│   Complete?  │          │
│   └─────────┘    └──────────┘    └───────┬──────┘          │
│        ▲                                  │                 │
│        │              No                 │ Yes             │
│        │         ┌───────────────────────┘                 │
│        │         │                                         │
│   ┌────┴─────────┴──┐                                      │
│   │  Exit Attempt   │ ◀── Hook Intercepts                  │
│   └─────────────────┘    and Re-prompts                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Core Implementation

### 1. Hook System

Hooks intercept agent lifecycle events:

```javascript
// Pseudo-code for hook implementation
const hooks = {
  preExit: (session) => {
    // Check if task is truly complete
    const spec = readFile('SPEC.md');
    const completion = checkCompletion(spec);

    if (!completion.passed) {
      // Force agent to continue
      return {
        continue: true,
        message: `Task incomplete: ${completion.reason}. Continue working.`
      };
    }
    return { continue: false };
  }
};
```

### 2. Persistent Prompt

The prompt that keeps reminding the agent:

```
You are working on a task. Do not stop until:
1. All SPEC.md requirements are implemented
2. All tests pass
3. Code follows project conventions
4. Documentation is updated

If you try to exit before completion, you will be reprompted.
```

### 3. Completion Checklist

```markdown
## Completion Checklist

- [ ] Feature implemented
- [ ] Unit tests written
- [ ] Integration tests pass
- [ ] Documentation updated
- [ ] Code reviewed (if required)
- [ ] No TODOs left in code

Run this command to verify: `npm test && npm run lint`
```

---

## OpenCode Implementation

### Method 1: Session Persistence

```bash
# Start a session that persists
opencode run --continue "Implement feature X per SPEC.md"

# The --continue flag tells OpenCode to keep going
# even if the model attempts to exit
```

### Method 2: Custom Agent Configuration

```json
// ~/.opencode/agents/ralph.json
{
  "name": "Ralph",
  "description": "Persistent agent that doesn't stop until complete",
  "system": "You are a persistent agent. You MUST NOT exit until:\n1. The task is fully complete\n2. All tests pass\n3. Code follows project style\n4. Documentation is updated\n\nIf you attempt to exit before completing these, you will be reprompted to continue.",
  "hooks": {
    "onComplete": "check_completion.sh"
  }
}
```

### Method 3: Script-Based Loop

```bash
#!/bin/bash
# ralph-loop.sh

TASK="$1"
SPEC="$2"

while true; do
  # Run agent
  opencode run "$TASK"

  # Check if task is complete
  if ./check_completion.sh "$SPEC"; then
    echo "Task complete!"
    break
  fi

  echo "Task incomplete, continuing..."
  TASK="Continue working on: $TASK"
done
```

### Method 4: Claude Code Native Hooks

Claude Code supports hooks natively via `.claude/settings.json`. You can use a `PostToolUse` hook to detect premature exit attempts and redirect the agent:

```jsonc
// .claude/settings.json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Attempt Completion",
        "command": "bash .claude/hooks/check_completion.sh"
      }
    ]
  }
}
```

```bash
#!/bin/bash
# .claude/hooks/check_completion.sh
# Runs after the agent signals it wants to stop.
# Exit code 1 forces the agent to continue with the hook's stdout as context.

SPEC="SPEC.md"
if [ ! -f "$SPEC" ]; then
  exit 0  # No spec to check against; allow exit
fi

FAILURES=""

# Check tests pass
if ! npm test --silent 2>/dev/null; then
  FAILURES="$FAILURES\n- Tests are failing"
fi

# Check for remaining TODOs
TODO_COUNT=$(grep -r "TODO" src/ --include="*.ts" --include="*.js" -c 2>/dev/null | awk -F: '{s+=$2} END {print s+0}')
if [ "$TODO_COUNT" -gt 0 ]; then
  FAILURES="$FAILURES\n- $TODO_COUNT TODO comments remain in source"
fi

if [ -n "$FAILURES" ]; then
  echo "Task is NOT complete. Issues found:$FAILURES"
  echo "Continue working until all issues are resolved."
  exit 1
fi

exit 0
```

---

## Max Iteration Safety Valve

Ralph Loops are powerful but dangerous without a hard upper limit. An unbounded loop can burn tokens and time indefinitely, especially if the completion check has a bug or the task is genuinely impossible.

### Setting a Maximum Iteration Count

```bash
#!/bin/bash
# ralph-loop-safe.sh

TASK="$1"
SPEC="$2"
MAX_ITERATIONS="${3:-10}"  # Default: 10 iterations max
ITERATION=0

while [ "$ITERATION" -lt "$MAX_ITERATIONS" ]; do
  ITERATION=$((ITERATION + 1))
  echo "=== Iteration $ITERATION / $MAX_ITERATIONS ==="

  opencode run "$TASK"

  if ./check_completion.sh "$SPEC"; then
    echo "Task complete after $ITERATION iteration(s)!"
    exit 0
  fi

  echo "Task incomplete, continuing..."
  TASK="Continue working on: $1 (iteration $ITERATION)"
done

echo "WARNING: Reached max iterations ($MAX_ITERATIONS) without completing."
echo "Review progress manually and decide whether to continue."
exit 1
```

### Guidelines for Choosing Max Iterations

| Task Type | Suggested Max | Rationale |
|-----------|---------------|-----------|
| Bug fix | 3-5 | Should converge quickly or needs human eyes |
| Feature implementation | 5-10 | More steps, but should not loop indefinitely |
| Large refactor | 10-20 | Many files, but diminishing returns past 20 |
| Exploratory / research | 3-5 | Open-ended tasks need human checkpoints |

### Cost Monitoring

Track token spend per iteration. If a single iteration consumes an unusually high number of tokens, that is a signal the agent may be thrashing. Log iteration costs and abort if cumulative spend exceeds a budget.

---

## When NOT to Use Ralph Loops

Ralph Loops add overhead and are not always the right tool. Avoid them when:

- **The task is trivial**: A one-shot prompt that produces correct output does not benefit from a loop. Adding hooks and checks for a 5-line change is pure overhead.
- **There is no verifiable completion criterion**: Ralph Loops depend on automated checks. If you cannot script a check (e.g., "make the UI look better"), the loop has no exit condition and will hit the safety valve every time.
- **The agent needs creative exploration**: Open-ended brainstorming, design exploration, and research tasks are poorly served by a "keep going until done" pattern. Use interactive sessions instead.
- **Context is already near capacity**: Each loop iteration adds to context. If you are already at 60%+ context usage, a Ralph Loop will push into context rot territory. Prefer a fresh session with a checkpoint file.
- **Errors indicate a fundamental misunderstanding**: If the agent fails the completion check three times with the same error, re-prompting will not help. Stop the loop, diagnose the root cause, and provide clearer instructions.

---

## Advanced Patterns

### Friction Detection

Detect when the agent is "choosing to stop" due to difficulty rather than genuine completion. Common friction-exit signals:

```
Signals of friction-based exit:
- "I'll let you handle the rest..."
- "This requires manual review..."
- "The remaining work is trivial..."
- "You can complete this by..."
```

**Automated friction detection**: Scan the agent's final message for these phrases and auto-reprompt with more specific instructions:

```bash
#!/bin/bash
# friction_detect.sh - pipe agent output through this

FRICTION_PHRASES=(
  "I'll let you"
  "you can complete"
  "requires manual"
  "remaining work is trivial"
  "left as an exercise"
  "you should be able to"
)

OUTPUT="$1"

for phrase in "${FRICTION_PHRASES[@]}"; do
  if echo "$OUTPUT" | grep -qi "$phrase"; then
    echo "FRICTION DETECTED: Agent attempted to hand off work."
    echo "Phrase matched: '$phrase'"
    echo "Re-prompting with: 'Do not hand off work. Complete this yourself.'"
    exit 1  # Signal to ralph-loop.sh to continue
  fi
done

exit 0
```

**Escalation strategy**: If friction is detected more than twice in a row, the agent is likely stuck. At that point, log the blocker and pause for human review rather than burning more iterations.

### Progress Tracking

Track progress across iterations using a structured file so the agent (and the human) can see forward momentum:

```bash
# Write progress to file after each iteration
opencode run "Implement step 1, write progress to progress.md"

# Read progress and continue
opencode run "Read progress.md, implement step 2"
```

**Structured progress file format**:

```markdown
# Progress Tracker

## Iteration Log
| # | Timestamp | Action | Result | Files Changed |
|---|-----------|--------|--------|---------------|
| 1 | 2026-03-18 09:00 | Created DB schema | Success | migrations/001.sql |
| 2 | 2026-03-18 09:15 | Registration endpoint | Success | src/routes/auth.ts |
| 3 | 2026-03-18 09:30 | Login endpoint | FAILED - test errors | src/routes/auth.ts |
| 4 | 2026-03-18 09:45 | Fix login tests | Success | src/routes/auth.ts, tests/ |

## Current Status
- Completed: 4/6 tasks
- Blockers: None
- Next: Implement 2FA setup
```

**Stall detection**: If the agent reports the same "Current Status" across two consecutive iterations, it is stuck. Trigger the safety valve.

### Checkpoint Recovery

```bash
# Save checkpoint
git add .
git commit -m "Checkpoint: Step N complete"

# If agent gets stuck, revert and retry
```

---

## Best Practices

### DO

- **Set clear completion criteria**: The agent needs to know when it's actually done
- **Use verification scripts**: Automated checks catch completion
- **Limit scope per loop**: Don't try to do too much in one Ralph loop
- **Save progress**: Write checkpoints to files
- **Always set a max iteration count**: See [Max Iteration Safety Valve](#max-iteration-safety-valve)

### DON'T

- **Don't let agent exit on errors**: Errors should trigger retries
- **Don't accept "I'll let you finish"**: Force the agent to do the work
- **Don't run Ralph loops forever**: Have a max iteration limit
- **Don't use Ralph Loops without a verifiable exit condition**: See [When NOT to use Ralph Loops](#when-not-to-use-ralph-loops)

---

## Examples

### Example 1: Feature Implementation

```bash
# 1. Create spec
opencode run "Create SPEC.md for user authentication feature"

# 2. Start Ralph loop
./ralph-loop.sh "Implement user authentication per SPEC.md" "SPEC.md"

# 3. Loop continues until completion criteria met
```

### Example 2: Refactoring

```bash
# Run Ralph loop for large refactoring
opencode run --continue "Refactor codebase to use new API. Do not stop until all tests pass."
```

### Example 3: Bug Fix

```bash
# Persistent bug hunting
opencode run --continue "Find and fix the memory leak. Continue investigating until the root cause is identified and fixed."
```

---

## Cross-References

- [02 - Spec-Driven Development](02-spec-driven-development.md): Ralph Loops work best when driven by a clear spec with verifiable acceptance criteria.
- [03 - Agent Teams](03-agent-teams.md): Each worker in an agent team can run its own Ralph Loop for persistence.
- [04 - Context Management](04-context-management.md): Long-running Ralph Loops must manage context to avoid rot; use checkpoints and memory files.
- [05 - Session Teleportation](05-session-teleportation.md): Teleport a Ralph Loop session to another device for monitoring.
- [METHODOLOGIES.md](../METHODOLOGIES.md): Overview of all methodologies.

---

## References

- [Anthropic Ralph Wiggum Plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)
- [Reddit - Ralph Loops Discussion](https://www.reddit.com/r/ClaudeAI/comments/1q25d1r/will_2026_be_the_year_of_ralph_loops_and_personal/)

---

*Last Updated: March 18, 2026*
