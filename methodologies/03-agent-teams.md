# Agent Teams / Multi-Agent Orchestration

*Coordinating multiple specialized agents for parallel task execution*

---

## Overview

Agent Teams enable multiple AI agents to work in parallel on different aspects of a project. This is the evolution from single-agent workflows to distributed, specialized AI labor.

**Key Insight**: Different tasks benefit from different "personalities":
- Planning needs broad reasoning
- Implementation needs detailed focus
- Review needs critical analysis

---

## Architecture

### Hierarchical Team Structure

```
                    ┌──────────────┐
                    │   Planner    │
                    │  (Reasoning) │
                    └──────┬───────┘
                           │
           ┌───────────────┼───────────────┐
           ▼               ▼               ▼
    ┌────────────┐  ┌────────────┐  ┌────────────┐
    │  Worker 1  │  │  Worker 2  │  │  Worker 3  │
    │(Frontend)  │  │ (Backend)  │  │ (Testing)  │
    └─────┬──────┘  └─────┬──────┘  └─────┬──────┘
          │               │               │
          └───────────────┼───────────────┘
                          ▼
                   ┌────────────┐
                   │  Reviewer  │
                   │  (Quality) │
                   └────────────┘
```

### Role Definitions

| Role | Model Type | Responsibilities | Example Models |
|------|-----------|------------------|----------------|
| **Planner** | Reasoning | Task decomposition, dependency mapping, assignment | Claude Opus, o1 |
| **Worker** | Balanced | Implementation, coding, file editing | Claude Sonnet, GPT-4o |
| **Reviewer** | Conservative | Code review, bug finding, quality assurance | Claude Haiku, 4o-mini |
| **Memory Keeper** | Lightweight | Context management, note-taking, session state | Any fast model |

---

## Coordination Mechanisms

### 1. Task Claiming (File Locking)

Prevent race conditions when multiple agents edit files:

```
current_tasks/
├── agent-1.txt   → "Working on: src/components/Button.tsx"
├── agent-2.txt   → "Working on: src/components/Input.tsx"
└── agent-3.txt   → "Working on: tests/Button.test.tsx"
```

**Implementation**:

```bash
# check_claim.sh
TASK_FILE="$1"
AGENT_ID="$2"

# Check if file is claimed
if [ -f "current_tasks/$AGENT_ID.txt" ]; then
  CURRENT=$(cat "current_tasks/$AGENT_ID.txt")
  echo "Already working on: $CURRENT"
  exit 1
fi

# Claim the file
echo "Working on: $TASK_FILE" > "current_tasks/$AGENT_ID.txt"
echo "Claimed: $TASK_FILE"
```

### 2. Task Dependencies

```yaml
# tasks.yaml
tasks:
  - id: 1
    name: "Database Schema"
    files: ["migrations/001.sql", "src/models/"]
    dependencies: []
    
  - id: 2
    name: "API Endpoints"
    files: ["src/routes/api.ts"]
    dependencies: [1]
    
  - id: 3
    name: "Frontend Components"
    files: ["src/components/"]
    dependencies: []
    
  - id: 4
    name: "Integration Tests"
    files: ["tests/integration/"]
    dependencies: [2, 3]
```

### 3. Communication Channels

**Via Files**:
```
team_chat/
├── instructions/     # Tasks to pick up
├── progress/         # Work completed
├── questions/        # Blockers and clarifications
└── reviews/          # Code review requests
```

**Via API**:
```javascript
// Server-based coordination
const coordinationServer = {
  registerAgent: (id, role) => {},
  claimTask: (agentId, taskId) => {},
  submitWork: (agentId, taskId, result) => {},
  getStatus: () => {},
};
```

---

## OpenCode Implementation

### Setup: Start Server

```bash
# Terminal 1: Start OpenCode server
opencode serve --port 4096

# Server provides:
# - Session management
# - File coordination
# - State persistence
```

### Agent 1: Planner

```bash
# Terminal 2: Planner Agent
opencode attach http://localhost:4096 --session planner

# In OpenCode:
"Create task breakdown for feature X. Write to team_chat/instructions/tasks.json"
```

### Agent 2-4: Workers

```bash
# Terminal 3: Worker 1 (Backend)
opencode attach http://localhost:4096 --session worker-1

# In OpenCode:
"Read team_chat/instructions/tasks.json. Claim Task 1 by writing to team_chat/claims/worker-1.txt. Implement the backend API per the task spec."

# Terminal 4: Worker 2 (Frontend)
opencode attach http://localhost:4096 --session worker-2

# In OpenCode:
"Read team_chat/instructions/tasks.json. Claim Task 2 by writing to team_chat/claims/worker-2.txt. Implement the frontend components."
```

### Agent 5: Reviewer

```bash
# Terminal 5: Reviewer
opencode attach http://localhost:4096 --session reviewer

# In OpenCode:
"Monitor team_chat/progress/. When workers submit code, review and provide feedback in team_chat/reviews/"
```

---

## Practical Example: Feature Implementation

### Step 1: Initialize Team

```bash
# Create coordination directory
mkdir -p team_chat/{instructions,claims,progress,reviews}

# Start server
opencode serve &

# Launch agents
for agent in planner worker-1 worker-2 worker-3 reviewer; do
  opencode attach http://localhost:4096 --session "$agent" &
done
```

### Step 2: Planner Creates Tasks

In the planner session:

```
"Analyze SPEC.md and create task breakdown. Each task should:
- Have a unique ID
- List files to modify
- List dependencies
- Have acceptance criteria

Write to team_chat/instructions/tasks.json"
```

### Step 3: Workers Claim Tasks

In each worker session:

```
"Read team_chat/instructions/tasks.json. 
Find unclaimed tasks (not in team_chat/claims/). 
Claim a task by writing to team_chat/claims/<agent-id>.txt.
Implement the task.
Write progress to team_chat/progress/<task-id>.json"
```

### Step 4: Reviewer Validates

In the reviewer session:

```
"Watch team_chat/progress/. 
When a task is marked complete, review the work against acceptance criteria.
Write review to team_chat/reviews/<task-id>.md
Mark as approved or request changes."
```

---

## Concurrency Rules

### File-Disjoint Work

```
✅ Safe: Workers edit different files
   Worker 1: src/components/Button.tsx
   Worker 2: src/components/Input.tsx

❌ Unsafe: Workers edit same file
   Worker 1: src/app.tsx (lines 1-50)
   Worker 2: src/app.tsx (lines 51-100)
   → Will cause merge conflicts
```

### Shared Resource Safety

```
Safe patterns:
- Read-only access to shared files
- Append-only to shared logs
- Lock-based file editing
- Database transactions

Unsafe patterns:
- Concurrent file modifications
- Unlocked shared state
- Non-transactional database writes
```

---

## Advanced Patterns

### Competition Pattern

Multiple agents solve same problem, best result selected:

```bash
# Terminal 2-4: Competition
for i in 1 2 3; do
  opencode attach http://localhost:4096 --session solver-$i
  # Each implements the same task differently
done

# Terminal 5: Judge
echo "Review all solutions, select best based on criteria"
```

### Pipeline Pattern

Output from one agent feeds into next:

```
Research Agent → Analysis Agent → Implementation Agent → Review Agent
     ↓                ↓                  ↓                   ↓
  research.md    analysis.md       implementation/      review.md
```

### Expert Consultant Pattern

Specialist agents consulted on specific problems:

```
Main Worker: "Need help with SQL optimization"
    ↓
Database Expert Agent consulted
    ↓
Main Worker continues with solution
```

---

## Best Practices

### DO

- **Keep tasks file-disjoint**: No overlapping file edits
- **Use clear task descriptions**: Agents need to understand scope
- **Implement task claiming**: Prevents race conditions
- **Have a single source of truth**: One task list, one progress tracker
- **Set timeouts**: Agents shouldn't run forever
- **Log everything**: Keep audit trail of decisions

### DON'T

- **Don't have too many agents**: 3-5 is usually optimal
- **Don't create circular dependencies**: Task A depends on B, B on A
- **Don't skip the planner**: Unplanned parallel work leads to chaos
- **Don't ignore merge conflicts**: They will happen, have a plan

---

## Troubleshooting

### Problem: Agents Stepping on Each Other

**Solution**: Strict file locking
```bash
# Before editing
touch ".locks/$FILE.lock"

# Edit file

# After editing
rm ".locks/$FILE.lock"
```

### Problem: Task Stuck/Unclaimed

**Solution**: Timeout and reassignment
```bash
# Check task age
find team_chat/claims/ -mtime +1 -exec rm {} \;
# Stale claims deleted, tasks become available again
```

### Problem: Context Overflow

**Solution**: Memory Keeper pattern
```
Memory Keeper maintains:
- Current task state
- Key decisions
- Blockers
- Next steps

Workers query Memory Keeper instead of reading full history
```

---

## Integration with Other Methodologies

### Agent Teams + Ralph Loops

```
┌─────────────┐     ┌──────────────────┐
│   Planner   │────▶│   Task Queue     │
└─────────────┘     └────────┬─────────┘
                             │
         ┌───────────────────┼───────────────────┐
         ▼                   ▼                   ▼
  ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
  │ Worker 1    │     │ Worker 2    │     │ Worker 3    │
  │ + Ralph Loop│     │ + Ralph Loop│     │ + Ralph Loop│
  │ (persistent)│     │ (persistent)│     │ (persistent)│
  └─────────────┘     └─────────────┘     └─────────────┘
```

### Agent Teams + Spec-Driven

```
SPEC.md ──▶ Planner creates tasks ──▶ Workers implement
              (per SDD workflow)        (per SDD workflow)
```

---

## References

- [Hacker News - Claude Code Orchestration](https://news.ycombinator.com/item?id=46902368)
- [Claude Code Agent Teams](https://code.claude.com/docs/en/agent-teams)
- [Substack - AI Agents & Orchestration](https://brentjohnson.substack.com/p/ai-agents-and-orchestration-from)

---

*Last Updated: March 1, 2026*
