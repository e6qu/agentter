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

## Optimal Team Sizes and When to Scale Down

Not every project needs a full team. The coordination overhead of multi-agent setups is real: file locking, task claiming, merge resolution, and communication channels all add friction.

### Team Size Guidelines

| Project Scope | Recommended Team Size | Roles |
|---------------|----------------------|-------|
| Small feature (1-2 hours) | 1 agent | Single worker (use Ralph Loops for persistence) |
| Medium feature (4-8 hours) | 2-3 agents | Planner + 1-2 workers |
| Large feature (multi-day) | 3-5 agents | Planner + 2-3 workers + reviewer |
| System-wide refactor | 4-5 agents | Planner + 3 workers + reviewer |

### When to Scale Down

- **Overhead exceeds benefit**: If agents spend more time coordinating (reading claims, writing progress files) than coding, reduce the team.
- **Too many merge conflicts**: More than 2-3 conflicts per session means tasks are not sufficiently file-disjoint. Reduce workers or re-partition tasks.
- **Diminishing returns**: Beyond 5 agents, coordination cost grows faster than throughput. If you need more parallelism, split into independent sub-projects instead.
- **Context-heavy work**: Tasks that require deep understanding of the full codebase (e.g., architectural decisions) are better handled by a single agent with good context management.

### When to Scale Up

- Multiple independent subsystems can be worked on simultaneously
- Clear file-disjoint boundaries exist between tasks
- A review bottleneck is slowing down a single-agent workflow
- The project has both frontend and backend work that can proceed in parallel

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
Safe: Workers edit different files
   Worker 1: src/components/Button.tsx
   Worker 2: src/components/Input.tsx

Unsafe: Workers edit same file
   Worker 1: src/app.tsx (lines 1-50)
   Worker 2: src/app.tsx (lines 51-100)
   -> Will cause merge conflicts
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

## Merge Conflict Resolution Strategies

Merge conflicts are inevitable when multiple agents work on the same codebase, even with file-disjoint task assignments. Shared files like `package.json`, route registries, index files, and configuration files are common conflict sources.

### Prevention

1. **Strict file ownership**: Assign each shared file to exactly one agent. Other agents request changes through the communication channel.
2. **Append-only shared files**: For registries and index files, use an append-only pattern. Each agent adds to the end, reducing conflict surface.
3. **Deferred integration**: Have workers create their changes in isolation (e.g., separate route files) and assign a single integration agent to combine them.

### Detection

```bash
#!/bin/bash
# detect_conflicts.sh - run periodically or after each agent commits

git fetch origin
CONFLICTS=$(git merge-tree $(git merge-base HEAD origin/main) HEAD origin/main | grep -c "^<<<<<<<")

if [ "$CONFLICTS" -gt 0 ]; then
  echo "CONFLICT WARNING: $CONFLICTS conflict(s) detected"
  echo "Pause agents and resolve before continuing."
fi
```

### Resolution Strategies

| Strategy | When to Use | How |
|----------|-------------|-----|
| **Reviewer resolves** | Small conflicts in shared files | Reviewer agent reads both versions, picks correct merge |
| **Last writer wins** | Append-only files (logs, registries) | Concatenate both additions |
| **Planner re-partitions** | Recurring conflicts between same agents | Planner re-assigns tasks to eliminate overlap |
| **Human intervenes** | Semantic conflicts the agents cannot resolve | Flag for human review |

### Automated Resolution Script

```bash
#!/bin/bash
# resolve_simple_conflicts.sh
# Handles simple cases: both sides added lines to the same file

for file in $(git diff --name-only --diff-filter=U); do
  # Check if conflict is additive (both sides added, neither deleted)
  OURS=$(git show :2:"$file" 2>/dev/null)
  THEIRS=$(git show :3:"$file" 2>/dev/null)
  BASE=$(git show :1:"$file" 2>/dev/null)

  if [ -n "$OURS" ] && [ -n "$THEIRS" ] && [ -n "$BASE" ]; then
    # Try automatic merge
    if git merge-file -p "$file" "$file" "$file" > /dev/null 2>&1; then
      git add "$file"
      echo "Auto-resolved: $file"
    else
      echo "MANUAL RESOLUTION NEEDED: $file"
    fi
  fi
done
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
Research Agent -> Analysis Agent -> Implementation Agent -> Review Agent
     |                |                  |                   |
  research.md    analysis.md       implementation/      review.md
```

### Expert Consultant Pattern

Specialist agents consulted on specific problems. Unlike workers who own a task end-to-end, consultants provide targeted advice and return control to the caller.

**When to use**:
- A worker encounters a domain-specific problem outside its expertise (SQL optimization, security hardening, accessibility)
- The problem is well-scoped and can be answered without full project context
- You want specialist knowledge without giving a full agent permanent team membership

**Implementation**:

```bash
# 1. Worker writes a consultation request
cat > team_chat/questions/consult-db-001.md << 'EOF'
## Consultation Request: Database Query Optimization

**From**: worker-1
**Domain**: Database / SQL
**Priority**: Blocking

### Context
Working on the search endpoint (src/routes/search.ts). The full-text search
query against the posts table is taking 800ms on 100k rows. Need it under 200ms.

### Current Query
```sql
SELECT * FROM posts WHERE to_tsvector('english', title || ' ' || body) @@ plainto_tsquery('english', $1);
```

### What I Need
- Should I add a GIN index or a GiST index?
- Is the to_tsvector call in the WHERE clause preventing index usage?
- Any other optimization suggestions?

### Constraints
- PostgreSQL 16
- Cannot change schema significantly (migration budget is tight)
EOF

# 2. Expert consultant agent picks up the request
# Terminal: Database Expert
opencode attach http://localhost:4096 --session db-expert

# Prompt:
"Read team_chat/questions/consult-db-001.md. Provide a detailed answer
with specific SQL examples. Write your response to
team_chat/questions/consult-db-001-response.md. Do NOT modify any
source files -- advisory only."

# 3. Worker reads the response and applies the advice
# Worker-1 reads consult-db-001-response.md and implements the changes
```

**Key rules for consultants**:
- Consultants are read-only with respect to project source code
- Consultants write only to the communication channel (team_chat/)
- Workers are responsible for applying consultant advice
- Consultants should be spun up on demand and terminated after responding

---

## Best Practices

### DO

- **Keep tasks file-disjoint**: No overlapping file edits
- **Use clear task descriptions**: Agents need to understand scope
- **Implement task claiming**: Prevents race conditions
- **Have a single source of truth**: One task list, one progress tracker
- **Set timeouts**: Agents shouldn't run forever
- **Log everything**: Keep audit trail of decisions
- **Start small**: Begin with 2 agents and scale up only if needed

### DON'T

- **Don't have too many agents**: 3-5 is usually optimal; see [Optimal Team Sizes](#optimal-team-sizes-and-when-to-scale-down)
- **Don't create circular dependencies**: Task A depends on B, B on A
- **Don't skip the planner**: Unplanned parallel work leads to chaos
- **Don't ignore merge conflicts**: They will happen; see [Merge Conflict Resolution](#merge-conflict-resolution-strategies)

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

## Cross-References

- [01 - Ralph Loops](01-ralph-loops.md): Each worker in a team can use a Ralph Loop for persistence within its assigned task.
- [02 - Spec-Driven Development](02-spec-driven-development.md): The planner should use SDD to create task breakdowns from a spec.
- [04 - Context Management](04-context-management.md): Each agent in a team has its own context window; use the Memory Keeper pattern and context pruning to keep agents effective.
- [05 - Session Teleportation](05-session-teleportation.md): Monitor team progress from other devices via session sharing.
- [METHODOLOGIES.md](../METHODOLOGIES.md): Overview of all methodologies.

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
- [Claude Code Agent Teams](https://docs.anthropic.com/en/docs/claude-code/en/agent-teams)
- [Substack - AI Agents & Orchestration](https://brentjohnson.substack.com/p/ai-agents-and-orchestration-from)

---

*Last Updated: March 18, 2026*
