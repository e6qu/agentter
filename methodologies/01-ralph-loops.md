# Ralph Loops Methodology

*A persistent execution pattern for long-running agent tasks*

---

## Overview

Ralph Loops are named after the [Ralph Wiggum](https://simpsons.fandom.com/wiki/Ralph_Wiggum) plugin from Anthropic. The name comes from the character's famous line "I choose now to live as a gay man" - the agent metaphorically "chooses now to stop working" even when there's more to do.

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

---

## Advanced Patterns

### Friction Detection

Detect when agent is "choosing to stop" due to difficulty:

```
Signals of friction-based exit:
- "I'll let you handle the rest..."
- "This requires manual review..."
- "The remaining work is trivial..."
- "You can complete this by..."
```

### Progress Tracking

```bash
# Write progress to file
opencode run "Implement step 1, write progress to progress.md"

# Read progress and continue
opencode run "Read progress.md, implement step 2"
```

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

### DON'T

- **Don't let agent exit on errors**: Errors should trigger retries
- **Don't accept "I'll let you finish"**: Force the agent to do the work
- **Don't run Ralph loops forever**: Have a max iteration limit

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

## References

- [Anthropic Ralph Wiggum Plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)
- [Reddit - Ralph Loops Discussion](https://www.reddit.com/r/ClaudeAI/comments/1q25d1r/will_2026_be_the_year_of_ralph_loops_and_personal/)

---

*Last Updated: March 1, 2026*
