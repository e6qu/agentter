# Long-Running Tasks: Surviving Beyond the Context Window

*The definitive guide to running AI agent tasks that take hours, days, or weeks*

---

## The Problem

Every AI coding agent hits the same wall: the context window is finite. Even the largest available windows (1M tokens on Claude Opus 4.6 and Sonnet 4.6) eventually fill up. When they do, the agent's ability to reason about the task degrades and eventually collapses.

This manifests in several ways:

**Context rot**: Performance degrades as conversation length grows. The "LLMs Get Lost In Multi-Turn Conversation" paper (Laban et al., May 2025) demonstrated a **39% average performance drop** across multi-turn conversations compared to single-turn. The degradation decomposes into two components: a minor loss in aptitude and a significant increase in unreliability. When LLMs take a wrong turn in a conversation, they get lost and do not recover.

> Source: [LLMs Get Lost In Multi-Turn Conversation](https://arxiv.org/abs/2505.06120) -- Microsoft Research, 2025. Evaluated 15 LLMs from eight model families across 200,000+ simulated conversations.

**Lost state**: The agent forgets decisions it made earlier. It re-does work. It contradicts itself. It asks questions it already asked. It proposes approaches it already rejected.

**The goldfish memory problem**: Each compaction or summarization loses information. You cannot losslessly compress a multi-hour reasoning chain into a paragraph. Every compression is a lossy operation, and the losses compound across multiple compactions.

**Premature convergence**: Agents make assumptions in early turns and prematurely attempt solutions, then over-rely on those early (possibly wrong) decisions for the remainder of the conversation.

---

## The Scale of the Problem

### Task Duration vs. Context Pressure

| Task Duration | Approx. Token Usage | Compactions Needed (200K window) | Compactions Needed (1M window) | Risk Level |
|---------------|---------------------|----------------------------------|-------------------------------|------------|
| 30 minutes | 20-50K | 0 | 0 | Low |
| 1-2 hours | 50-150K | 0-1 | 0 | Low |
| 2-4 hours | 150-400K | 1-3 | 0-1 | Medium |
| 4-8 hours | 400K-1M | 3-8 | 0-2 | High |
| 8-24 hours | 1-3M | 8-25 | 2-6 | Very High |
| Multi-day | 3M+ | 25+ | 6+ | Critical |

Each compaction loses some information. By the time you have done 5+ compactions, the agent is working with a heavily lossy summary of the original task. Decisions made in the first hour may be entirely absent from the context.

### Real-World Examples

**Large refactor (1000+ files)**: A codebase migration from one framework to another. Each file read consumes tokens. Each edit consumes tokens. Verification consumes tokens. A 1000-file refactor can easily consume 5M+ tokens across the full task.

**Full-stack feature (multi-day)**: Building a complete feature from database schema to API endpoints to frontend. Requires holding architectural decisions in context while implementing across layers. Typically 3-5 days of agent work.

**Migration project**: Database migrations, API version upgrades, dependency updates across a monorepo. Requires careful sequencing, rollback planning, and verification at each step.

### The Exponential Horizon

METR research (March 2025) found that the length of tasks AI agents can complete autonomously with 50% reliability has been **doubling approximately every 7 months** over the past six years -- and accelerating to every 4 months in 2024-2025.

| Year | Task Duration (50% reliability) | Example |
|------|-------------------------------|---------|
| 2019 | ~1 minute | Answer a question |
| 2021 | ~4 minutes | Write a function |
| 2023 | ~15 minutes | Implement a small feature |
| 2025 | ~1 hour | Implement a complex feature |
| 2027 (projected) | ~4 hours | Refactor a module |
| 2029 (projected) | ~1 day | Build a subsystem |

> Source: [METR - Measuring AI Ability to Complete Long Tasks](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/). Evaluated 11 frontier models across 66+ tasks from SWAA, RE-Bench, and HCAST datasets.

The implication: we are right at the inflection point where tasks are becoming long enough to routinely exceed context windows. The techniques in this document are not theoretical -- they are necessary for the tasks agents are being asked to do right now.

### Anthropic's Harness Research

Anthropic's "Effective Harnesses for Long-Running Agents" (November 2025) quantified the impact of harness design on long-running agent performance:

| Technique | Performance Impact | Token Impact |
|-----------|-------------------|--------------|
| Context editing alone | +29% task success | Moderate reduction |
| Memory tool alone | +39% task success | Moderate reduction |
| Combined (editing + memory) | Best overall | **-84% token consumption** |

The key insight: the harness around the agent matters as much as the model itself. A well-designed harness with external memory and context management can dramatically extend an agent's effective range.

> Source: [Anthropic - Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)

---

## Core Strategies

### 1. External Memory Systems

The most important principle for long-running tasks: **do not rely on the context window as your source of truth**. The context window is working memory. Files on disk are long-term memory. Treat them accordingly.

#### The Memory Hierarchy

```
┌─────────────────────────────────────────────────────┐
│  Level 4: Project Documentation                      │
│  (README, ARCHITECTURE.md, ADRs)                     │
│  Permanence: ████████████  Survives: everything      │
├─────────────────────────────────────────────────────┤
│  Level 3: Git History                                │
│  (commits, branches, tags)                           │
│  Permanence: ███████████   Survives: session restarts│
├─────────────────────────────────────────────────────┤
│  Level 2: Scratchpad Files                           │
│  (progress.md, decisions.md, todo.md)                │
│  Permanence: ████████      Survives: compactions     │
├─────────────────────────────────────────────────────┤
│  Level 1: Manifest Files                             │
│  (CLAUDE.md, AGENTS.md)                              │
│  Permanence: ██████        Survives: session restarts│
├─────────────────────────────────────────────────────┤
│  Level 0: Conversation Context                       │
│  (current session working memory)                    │
│  Permanence: ██            Survives: nothing         │
└─────────────────────────────────────────────────────┘
```

The rule: **anything that matters must exist at Level 2 or above**. If it only exists in the conversation, it will be lost.

#### CLAUDE.md / AGENTS.md as Persistent Memory

These manifest files are read automatically at session start:

- **CLAUDE.md** (Claude Code): Loaded in full at launch. Child directory CLAUDE.md files load on demand. First 200 lines of MEMORY.md are loaded; topic files are not loaded at startup.
- **AGENTS.md** (Codex CLI): Read before doing any work. Hierarchical discovery up to 32 KiB, looking in each folder up to the cwd.
- **OpenHands**: Automatically finds AGENTS.md, CLAUDE.md, GEMINI.md at workspace root.

Use these for information the agent needs in every session: project conventions, architectural decisions, key file locations, current task state.

#### Scratchpad Files

Create purpose-specific files for task state:

**progress.md** -- What has been done, what remains:

```markdown
# Task Progress

## Objective
Migrate authentication system from sessions to JWT tokens.

## Completed
- [x] Database schema updated (migration 042)
- [x] JWT utility library created (src/lib/jwt.ts)
- [x] Registration endpoint converted (src/routes/auth/register.ts)
- [x] Login endpoint converted (src/routes/auth/login.ts)

## In Progress
- [ ] Middleware conversion (src/middleware/auth.ts) -- 60% done, cookie parsing remains

## Remaining
- [ ] Protected route updates (14 routes)
- [ ] Session cleanup migration
- [ ] Integration tests
- [ ] Load testing

## Current Session Focus
Finish middleware conversion, then start protected route updates.
```

**decisions.md** -- Architectural and implementation decisions with rationale:

```markdown
# Decisions Log

## D001: JWT Library Choice
- **Decision**: Use jose library, not jsonwebtoken
- **Rationale**: jsonwebtoken has no ESM support, jose is maintained and typed
- **Date**: 2026-03-15

## D002: Token Expiry Strategy
- **Decision**: 15-minute access tokens, 7-day refresh tokens
- **Rationale**: Short access tokens limit blast radius; refresh tokens avoid constant re-auth
- **Date**: 2026-03-15
- **Implication**: Need refresh token rotation endpoint

## D003: Session Migration Approach
- **Decision**: Dual-mode middleware (accept both sessions and JWT) during transition
- **Rationale**: Allows incremental migration without big-bang cutover
- **Date**: 2026-03-16
```

**blockers.md** -- Issues that need human intervention:

```markdown
# Blockers

## B001: Database credentials for staging
- **Status**: Waiting on DevOps
- **Impact**: Cannot test migration against staging data
- **Workaround**: Using local Docker instance

## B002: OAuth provider callback URL update
- **Status**: Needs admin access to Google Cloud Console
- **Impact**: Blocks OAuth flow testing
- **Workaround**: None -- skip OAuth tests for now, mark as TODO
```

#### The "Write Before You Forget" Pattern

Before any compaction (manual or automatic), checkpoint state to files:

```
Agent is working → Context approaching limit →
  1. Write current state to progress.md
  2. Write any new decisions to decisions.md
  3. Commit changes to git
  4. THEN compact
```

This is the single most important habit for long-running tasks. If you compact without writing state to files first, that state is gone.

### 2. Context Compaction Strategies

#### How Compaction Works

**Claude Code**: The `/compact` command (or auto-compact when context exceeds ~83.5% of the window) summarizes the conversation to free space. You can provide focus instructions: `/compact focus on the authentication migration`. Claude Code reserves a buffer of approximately 33K tokens and triggers auto-compaction at the threshold.

**OpenCode**: Uses a hidden system agent that compacts long context into a smaller summary. Configurable via `opencode.json`:

```json
{
  "compaction": {
    "auto": true,
    "prune": true,
    "strategy": "oldest-first",
    "threshold": 0.6,
    "reserved": 10000
  }
}
```

**Aider**: Does not have automatic compaction in the same sense. Instead, it manages context through its repository map, sending only the most relevant portions of the codebase based on graph ranking. The `--map-tokens` flag controls the token budget for the repo map (default: 1024 tokens).

#### When to Compact

**Proactive compaction** (recommended): Compact at natural breakpoints -- after completing a subtask, after a commit, before starting a new phase of work. This preserves the most useful recent context while discarding completed work.

**Reactive compaction** (risky): Waiting until auto-compact fires. By this point, the agent may already be experiencing degradation. The automatic summary is less targeted than a manual one.

**The "80% rule"**: Compact at 80% context usage, not 100%. This gives you headroom. If you wait until the window is full, the compaction itself consumes tokens and you may lose more than expected.

#### What Gets Lost in Compaction

Compaction is lossy. These are the most common casualties:

| Lost | Impact | Mitigation |
|------|--------|------------|
| Exact code snippets from tool reads | Agent may misremember file contents | Re-read files after compaction |
| Detailed error messages | Agent may not know why something failed | Log errors to a file |
| Reasoning chains | Agent loses the "why" behind decisions | Write decisions to decisions.md |
| Specific file paths | Agent forgets which files it was working on | Track in progress.md |
| Tool output details | Agent loses grep/search results | Save important results to scratchpad |

#### Graduated Compaction

Not all context is equally valuable. A graduated approach:

1. **Drop first**: Old tool outputs (file reads, grep results) -- these can be re-executed
2. **Summarize second**: Earlier conversation turns -- compress to key decisions and outcomes
3. **Preserve last**: Recent context (last 10-15 turns), current task state, active file contents

#### Anti-Pattern: Context Cliff

The worst pattern is letting context fill completely, triggering emergency compaction that aggressively summarizes everything. This typically happens when:
- Auto-compaction is disabled
- The agent is in a tight loop reading many files
- Large tool outputs (e.g., test suite results) fill context rapidly

Prevention: enable auto-compaction, set conservative thresholds, and use `--map-tokens` style controls to limit per-tool output size.

### 3. Task Decomposition

The most reliable strategy for multi-day tasks: **break them into session-sized chunks**.

#### The "Spec → Plan → Implement → Verify" Loop

```
┌──────────────────────────────────────────────────────────┐
│                    MULTI-DAY TASK LOOP                     │
├──────────────────────────────────────────────────────────┤
│                                                            │
│  Day 1, Session 1: SPEC                                    │
│  ├── Define requirements                                  │
│  ├── Write acceptance criteria                            │
│  └── Output: SPEC.md                                      │
│                                                            │
│  Day 1, Session 2: PLAN                                    │
│  ├── Read SPEC.md                                         │
│  ├── Decompose into ordered subtasks                      │
│  ├── Identify dependencies                                │
│  └── Output: PLAN.md with numbered tasks                  │
│                                                            │
│  Day 1-N, Sessions 3+: IMPLEMENT                           │
│  ├── Read PLAN.md and progress.md                         │
│  ├── Pick next uncompleted task                           │
│  ├── Implement it                                         │
│  ├── Verify it (tests, lint, manual check)                │
│  ├── Update progress.md                                   │
│  ├── Commit to git                                        │
│  └── Repeat until PLAN.md is complete                     │
│                                                            │
│  Final Session: VERIFY                                     │
│  ├── Read SPEC.md                                         │
│  ├── Run full test suite                                  │
│  ├── Check all acceptance criteria                        │
│  └── Output: verification report                          │
│                                                            │
└──────────────────────────────────────────────────────────┘
```

#### The TODO File as Coordination Mechanism

A shared TODO file is the simplest and most robust coordination mechanism across sessions:

```markdown
# PLAN.md

## Task: Migrate Auth to JWT

### Phase 1: Foundation (Day 1)
- [x] 1.1 Create JWT utility module
- [x] 1.2 Add jose dependency
- [x] 1.3 Create token generation functions
- [x] 1.4 Create token validation functions
- [x] 1.5 Write unit tests for JWT utilities

### Phase 2: Endpoints (Day 2)
- [x] 2.1 Convert /register endpoint
- [x] 2.2 Convert /login endpoint
- [ ] 2.3 Create /refresh endpoint        ← CURRENT
- [ ] 2.4 Create /logout endpoint
- [ ] 2.5 Write endpoint integration tests

### Phase 3: Middleware (Day 3)
- [ ] 3.1 Create JWT auth middleware
- [ ] 3.2 Create dual-mode transition middleware
- [ ] 3.3 Update protected routes
- [ ] 3.4 Write middleware tests

### Phase 4: Cleanup (Day 4)
- [ ] 4.1 Remove session dependencies
- [ ] 4.2 Create session cleanup migration
- [ ] 4.3 Update documentation
- [ ] 4.4 Run full integration suite
- [ ] 4.5 Load test under JWT
```

Each session starts by reading this file and picking up where the last session left off. No context needed from previous sessions.

#### Session Handoff Template

At the end of each session, the agent writes a handoff note:

```markdown
# Session Handoff - 2026-03-18 14:30

## What I Did
- Implemented /refresh endpoint (task 2.3)
- Added refresh token rotation logic
- Wrote 4 integration tests (all passing)

## What's Next
- Task 2.4: /logout endpoint (invalidate refresh token)
- Then task 2.5: endpoint integration tests

## Gotchas for Next Session
- The refresh token is stored in an HttpOnly cookie, not in the response body
- Token rotation creates a new refresh token AND invalidates the old one
- The `token_family` column in the DB tracks rotation chains for replay detection

## Files Changed This Session
- src/routes/auth/refresh.ts (new)
- src/lib/jwt.ts (added rotateRefreshToken function)
- tests/auth/refresh.test.ts (new)
- migrations/043_token_family.sql (new)

## Test Status
- Unit tests: 47/47 passing
- Integration tests: 12/12 passing
- No lint warnings
```

### 4. Git as Memory

Git is the most underused memory system for long-running agent tasks. Unlike scratchpad files, git history is append-only, tamper-evident, and structured.

#### Commit Messages as Decision Documentation

Every commit message is a decision record that survives any number of compactions and session restarts:

```
feat(auth): convert login endpoint to JWT

- Replace express-session with jose JWT verification
- Access token: 15min expiry, signed with RS256
- Refresh token: 7-day expiry, stored in HttpOnly cookie
- Chose RS256 over HS256 for key rotation capability

Decision: using asymmetric keys so auth service can
issue tokens but any service can verify them without
sharing the secret.
```

This commit message contains the decision, the rationale, and the technical details. An agent in a future session can run `git log --oneline` and reconstruct the history of decisions.

#### The "Commit Checkpoint" Pattern

Before any compaction, before any session end, before any risky operation:

```bash
git add -A
git commit -m "checkpoint: completed tasks 2.1-2.3, starting 2.4

Progress:
- Registration endpoint converted and tested
- Login endpoint converted and tested
- Refresh endpoint created with token rotation
Next: logout endpoint and endpoint integration tests"
```

This creates a recoverable snapshot. If the next session goes badly, you can always return to this checkpoint.

#### Branch-Per-Subtask for Isolation

For large tasks, create a branch per major subtask:

```
main
├── feat/jwt-auth
│   ├── feat/jwt-auth-utilities    (merged)
│   ├── feat/jwt-auth-endpoints    (in progress)
│   ├── feat/jwt-auth-middleware   (not started)
│   └── feat/jwt-auth-cleanup     (not started)
```

Each branch can be worked on independently, reviewed independently, and merged independently. This gives you natural rollback points.

#### Worktrees for Parallel Work

Git worktrees enable multiple agents to work on the same repository simultaneously without merge conflicts. Claude Code has built-in worktree support:

```bash
# Agent 1: working on endpoints
claude --worktree feat/jwt-auth-endpoints

# Agent 2: working on middleware (in another terminal)
claude --worktree feat/jwt-auth-middleware
```

Each agent gets its own isolated working directory with its own branch and its own Claude Code session. The two agents work simultaneously without their edits colliding.

**Limitation**: Worktrees isolate code but not the runtime environment. Agents share ports, databases, and services on the same machine. If both agents try to run a dev server on port 3000, one will fail.

> Source: [Boris Cherny (Anthropic) - Claude Code worktree support](https://medium.com/@mabd.dev/git-worktrees-the-secret-weapon-for-running-multiple-ai-coding-agents-in-parallel-e9046451eb96)

### 5. Agent Teams for Long Tasks

When a task is too large for one agent -- or when parts of it can be parallelized -- split it across multiple agents.

#### Coordinator + Worker Pattern

```
┌─────────────────────────────────────────────────────┐
│                  COORDINATOR AGENT                    │
│  Reads PLAN.md, assigns tasks, monitors progress     │
├──────────┬──────────┬──────────┬────────────────────┤
│ Worker 1 │ Worker 2 │ Worker 3 │ Reviewer           │
│ (auth    │ (API     │ (front-  │ (validates each    │
│  module) │  routes) │  end)    │  worker's output)  │
└──────────┴──────────┴──────────┴────────────────────┘
```

**Communication mechanism**: File-based. Workers write to `team_chat/progress/<agent-name>.md`. Coordinator reads all progress files and updates `PLAN.md`.

**Task claiming**: Workers claim tasks by writing a lockfile:

```bash
# Worker claims task 2.4
echo "claimed by worker-1 at $(date)" > team_chat/claims/task-2.4.lock
```

**When to parallelize**: Tasks that touch different files. API routes, frontend components, database migrations, documentation -- these can often be worked on simultaneously.

**When to serialize**: Tasks with dependencies. The middleware depends on the JWT utility module. The protected routes depend on the middleware. These must be done in order.

For full details on agent team orchestration, see [03 - Agent Teams](03-agent-teams.md).

### 6. The Ralph Loop + Persistence Pattern

Ralph Loops (persistent execution with hooks) are powerful for single long-running tasks, but they accumulate context rapidly. Combining them with external persistence extends their effective range.

#### The Pattern

```
┌──────────────────────────────────────────────────────┐
│              RALPH LOOP + PERSISTENCE                  │
├──────────────────────────────────────────────────────┤
│                                                        │
│  Start: Read progress.md, decisions.md, PLAN.md        │
│     │                                                  │
│     ▼                                                  │
│  Work on next task from PLAN.md                        │
│     │                                                  │
│     ▼                                                  │
│  Check: task complete? ──No──▶ Continue working        │
│     │                              │                   │
│    Yes                             │                   │
│     │                              │                   │
│     ▼                              ▼                   │
│  Update progress.md          Context filling up?       │
│  Commit to git                    │                    │
│     │                            Yes                   │
│     ▼                             │                    │
│  More tasks in PLAN.md?           ▼                    │
│     │                     Write state to files         │
│    Yes                    Compact context               │
│     │                     Re-read progress.md          │
│     ▼                     Continue                     │
│  Pick next task ◄─────────────────┘                    │
│     │                                                  │
│    No more tasks                                       │
│     │                                                  │
│     ▼                                                  │
│  Run final verification                                │
│  Update progress.md: COMPLETE                          │
│  Exit                                                  │
│                                                        │
└──────────────────────────────────────────────────────┘
```

#### Progress Files with Iteration Tracking

Track not just what is done, but how many iterations it took:

```markdown
# Progress Tracker

## Iteration Log
| # | Timestamp | Task | Result | Compactions | Files Changed |
|---|-----------|------|--------|-------------|---------------|
| 1 | 09:00 | JWT utils | Success | 0 | src/lib/jwt.ts |
| 2 | 09:30 | Register endpoint | Success | 0 | src/routes/auth/register.ts |
| 3 | 10:15 | Login endpoint | FAILED | 1 | src/routes/auth/login.ts |
| 4 | 10:45 | Login endpoint (retry) | Success | 1 | src/routes/auth/login.ts |
| 5 | 11:30 | Refresh endpoint | Success | 2 | src/routes/auth/refresh.ts |

## Stall Detection
- Same task attempted 2+ times in a row: POSSIBLE STALL
- No progress across 3 iterations: DEFINITE STALL → pause for human review
```

#### The "Unstuck" Detection Pattern

If the progress file shows the same task attempted in consecutive iterations with no progress, the agent is stuck. Automated detection:

```bash
#!/bin/bash
# unstuck_detect.sh -- check if agent is making progress

LAST_TWO=$(tail -2 progress.md | grep -o 'Task: [^|]*' | sort -u | wc -l)

if [ "$LAST_TWO" -eq 1 ]; then
  echo "STALL DETECTED: Agent attempted same task twice with no progress."
  echo "Pausing for human review."
  exit 1
fi

exit 0
```

For full details on Ralph Loops, see [01 - Ralph Loops](01-ralph-loops.md).

---

## Advanced Techniques

### Hierarchical Planning

For truly large tasks (multi-week projects), use a hierarchy of planning documents at different levels of abstraction:

```
┌───────────────────────────────────────────────────┐
│  L0: PROJECT-SPEC.md                               │
│  "What are we building and why?"                   │
│  Changes: rarely (requirements updates)            │
│  Example: "Migrate from REST to GraphQL"           │
├───────────────────────────────────────────────────┤
│  L1: ARCHITECTURE.md                               │
│  "How is it structured?"                           │
│  Changes: weekly (design revisions)                │
│  Example: "Schema-first with code generation"      │
├───────────────────────────────────────────────────┤
│  L2: PLAN.md                                       │
│  "What are the tasks and their order?"             │
│  Changes: daily (tasks completed, new tasks found) │
│  Example: "Phase 2: Convert user queries"          │
├───────────────────────────────────────────────────┤
│  L3: progress.md + session handoff                 │
│  "Where am I right now?"                           │
│  Changes: per session (current state)              │
│  Example: "Converting getUserById resolver"        │
└───────────────────────────────────────────────────┘
```

Each session only needs to read L2 and L3 to know what to do. L0 and L1 are consulted only when the agent needs to make a decision that affects the overall architecture.

This hierarchy maps naturally to the memory hierarchy: L0 and L1 live in git (Level 3-4), L2 lives in tracked scratchpad files (Level 2-3), and L3 lives in session-scoped scratchpad files (Level 2).

### The "Briefing Document" Pattern

Before each session, the agent reads a single briefing document that contains everything it needs to start working immediately. After each session, the agent updates the briefing for the next session.

#### Briefing Template

```markdown
# Briefing: JWT Auth Migration
# Last updated: 2026-03-18 14:30 by Session 5

## Project Context (read once, skip on subsequent sessions)
We are migrating from express-session to JWT-based auth.
See PROJECT-SPEC.md for full requirements.
See ARCHITECTURE.md for technical design.

## Current State
- Phase 1 (Foundation): COMPLETE
- Phase 2 (Endpoints): 3/5 tasks done
- Phase 3 (Middleware): NOT STARTED
- Phase 4 (Cleanup): NOT STARTED

## What to Do Next
1. Implement /logout endpoint (task 2.4)
   - Must invalidate the refresh token family in DB
   - See decisions.md D002 for token expiry strategy
2. Then write endpoint integration tests (task 2.5)

## Key Decisions Already Made
- JWT library: jose (not jsonwebtoken) -- see D001
- Token expiry: 15min access / 7-day refresh -- see D002
- Dual-mode middleware during transition -- see D003

## Gotchas
- Refresh tokens are in HttpOnly cookies, NOT response body
- Token rotation uses family chains for replay detection
- The `token_family` column was added in migration 043

## Test Status as of Last Session
- Unit: 47/47 passing
- Integration: 12/12 passing
- No lint warnings

## Files You'll Probably Need
- src/lib/jwt.ts (JWT utilities)
- src/routes/auth/ (auth endpoints)
- src/middleware/auth.ts (auth middleware -- not yet converted)
- tests/auth/ (test files)
```

This pattern front-loads the agent with exactly the context it needs. No exploring, no re-discovering, no re-reading files to figure out what happened last session.

### The "Checkpoint-Resume" Pattern

Periodic, structured state snapshots that enable reliable recovery.

#### Checkpoint Format

```markdown
# Checkpoint: 2026-03-18T14:30:00Z
# Session: 5
# Git SHA: a1b2c3d

## Task State
current_phase: 2
current_task: 2.3
task_status: complete
next_task: 2.4

## Environment State
branch: feat/jwt-auth-endpoints
tests_passing: true
lint_clean: true
build_passing: true

## Context State
compactions_this_session: 2
estimated_context_usage: 65%
tokens_consumed_estimate: 450000

## Files Modified Since Last Checkpoint
- src/routes/auth/refresh.ts (created)
- src/lib/jwt.ts (modified -- added rotateRefreshToken)
- tests/auth/refresh.test.ts (created)
- migrations/043_token_family.sql (created)

## Recovery Instructions
If resuming from this checkpoint:
1. git checkout a1b2c3d (or later)
2. Read PLAN.md for task list
3. Start with task 2.4 (/logout endpoint)
4. The refresh endpoint (2.3) is complete and tested
```

#### Automated Checkpointing with Hooks

Claude Code hooks can automate checkpointing. Use a `PostToolUse` hook to checkpoint after significant tool operations:

```jsonc
// .claude/settings.json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "bash .claude/hooks/maybe_checkpoint.sh"
      }
    ],
    "PreCompact": [
      {
        "command": "bash .claude/hooks/pre_compact_save.sh"
      }
    ]
  }
}
```

```bash
#!/bin/bash
# .claude/hooks/maybe_checkpoint.sh
# Checkpoint every 10 file modifications

COUNTER_FILE=".claude/.edit_counter"
CHECKPOINT_INTERVAL=10

# Increment counter
COUNT=$(cat "$COUNTER_FILE" 2>/dev/null || echo 0)
COUNT=$((COUNT + 1))
echo "$COUNT" > "$COUNTER_FILE"

if [ $((COUNT % CHECKPOINT_INTERVAL)) -eq 0 ]; then
  git add -A
  git commit -m "checkpoint: auto-save after $COUNT edits" --allow-empty 2>/dev/null
  echo "Auto-checkpoint created after $COUNT edits."
fi
```

```bash
#!/bin/bash
# .claude/hooks/pre_compact_save.sh
# Save state before compaction so nothing is lost

echo "PRE-COMPACT: Saving state before context compaction."
echo "Reminder: after compaction, re-read progress.md and decisions.md."

# Auto-commit any uncommitted work
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "pre-compact checkpoint: saving state before compaction"
  echo "Committed uncommitted changes before compaction."
fi
```

The `PreCompact` hook is particularly valuable: it fires before context compaction, giving you a chance to preserve important information before the context window is compressed. As of January 2026, PreCompact hooks reduce critical information loss by 30% during compactions.

### Context Budget Management

Managing context like a finite budget prevents surprise compactions and keeps the agent performing well throughout the session.

#### Estimating Token Usage per Operation

| Operation | Approximate Token Cost |
|-----------|----------------------|
| Read a small file (< 100 lines) | 200-500 tokens |
| Read a large file (500+ lines) | 2,000-10,000 tokens |
| Grep/search results | 500-3,000 tokens |
| Run tests (output) | 1,000-10,000 tokens |
| Edit a file (tool call + response) | 300-1,000 tokens |
| Git diff output | 500-5,000 tokens |
| Agent reasoning per turn | 500-2,000 tokens |

#### The Budget Approach

For a 200K context window with an 80% compaction threshold (160K usable):

```
System prompt + tools:     ~5,000 tokens
CLAUDE.md / manifest:      ~2,000 tokens
─────────────────────────────────────────
Available for work:       ~153,000 tokens

Estimated per subtask:     ~15,000 tokens (10 tool calls avg)
Subtasks before compact:   ~10 subtasks

Plan: compact after every 8 subtasks (safety margin)
```

For a 1M context window at 80% threshold (~800K usable):

```
Available for work:       ~793,000 tokens
Subtasks before compact:   ~52 subtasks
```

This is why the 1M context window is transformative. Instead of compacting every hour, you might go an entire workday. But even 1M fills up on multi-day tasks.

#### Selective File Reading

Do not read entire files when you need one function. Use targeted reads:

```
BAD:  "Read src/lib/jwt.ts"              (might be 500 lines, ~5000 tokens)
GOOD: "Read src/lib/jwt.ts lines 45-80"  (just the function, ~350 tokens)
```

Similarly, use targeted grep rather than broad searches. Each search result consumes context.

#### The Cost of Re-Reading

Compaction saves context but forces re-reading files in the next phase of work. This has a cost:

```
Scenario A: Keep file in context (5,000 tokens)
Scenario B: Compact, then re-read file later (500 token summary + 5,000 token re-read = 5,500 tokens)
```

If you will need a file again soon, it is cheaper to keep it in context than to compact and re-read. Compact aggressively on content you will not need again; preserve content you will need shortly.

#### Deferred Tool Loading

Claude Code's deferred tool loading reduces initial context usage:

```
ENABLE_TOOL_SEARCH=auto:10  # Defer tools when context is 10%+ full
```

With many MCP servers connected, tool definitions alone can consume tens of thousands of tokens. Deferred loading keeps the prompt prefix small and loads tool schemas on demand.

---

## Tool-Specific Guidance

### Claude Code

**Session management flags**:
- `claude --continue` / `claude -c`: Resume the most recent conversation in the current directory. Use for 90% of resumption needs.
- `claude --resume` / `claude -r`: Select a specific session by name, ID, or interactive picker. Use when you have multiple active sessions.
- `claude -c "check if the tests pass now"`: Resume and immediately send a prompt.
- Name sessions early with `/rename` -- "jwt-auth-migration" is easier to find than "explain this function."

**Auto-compact behavior**: Claude Code reserves ~33K tokens and compacts at ~83.5% of the window. A 200K window gives ~150K usable tokens; a 1M window gives ~830K. Compaction behavior is automatic but can be triggered manually with `/compact [focus instructions]`.

**1M context window**: Available for Opus 4.6 and Sonnet 4.6. Standard rates up to 200K tokens; long-context pricing beyond that. Enable with `/model sonnet[1m]` or `/model opus[1m]`. As of March 2026, generally available with no beta headers or waiting list.

**Subagent isolation**: Each subagent gets its own fresh context window. Their work does not bloat your main context. Use subagents for self-contained subtasks (e.g., "write tests for this module"). Claude Code v2.x supports up to 5 simultaneous sub-agents.

**Hooks for long-running tasks**:
- `PreCompact`: Save state before compaction. Fires before context compaction.
- `PostToolUse`: Run checks after tool execution. Use with matcher for `Write|Edit` to auto-checkpoint.
- `SessionStart`: Re-inject critical context. Use to automatically load briefing documents.
- `Stop`: Validate final output before the agent exits.

**Worktree support**:
```bash
claude --worktree feature-auth    # Isolated copy, own branch, own session
claude --worktree bugfix-123      # Another isolated workspace
```

### Codex CLI

**Cloud execution**: The Codex app (launched February 2026 for macOS) runs agents in the cloud. You can close your laptop and come back to completed work. OpenAI is building Automations with cloud-based triggers for continuous background execution.

**Parallel agents**: Codex spawns specialized subagents in parallel and collects results. Each agent works on its own git worktree for zero-collision isolation.

```bash
# Codex multi-agent via the Agents SDK
codex exec --subagents "Implement the auth endpoints" \
  --agent auth-worker \
  --agent test-writer \
  --agent doc-updater
```

**AGENTS.md**: Codex reads AGENTS.md files before doing any work. Hierarchical discovery with a 32 KiB limit. Use this as your primary persistent memory mechanism.

**Scheduled automations**: Codex supports scheduled runs for recurring tasks (nightly test suites, weekly dependency updates). This is useful for the verification phase of long-running tasks.

### Aider

**Repository map**: Aider's primary context management tool. Built with tree-sitter, it extracts class/function signatures and uses graph ranking to fit within a configurable token budget. The map shows the agent the codebase structure without consuming tokens on full file contents.

```bash
aider --map-tokens 2048    # Increase repo map budget for larger codebases
aider --map-tokens 0       # Disable repo map (for small projects)
```

**Chat history**: Aider maintains `.aider.chat.history.md` as a conversation log. This persists across sessions and provides a record of what was discussed, but it is not automatically re-injected into context.

**The /run command**: Execute shell commands and inject output into context. Use for verification loops:

```
/run npm test
# Aider sees test output, can fix failures
```

**Context management approach**: Aider does not have compaction. Instead, it manages context through selective inclusion: only files explicitly added to the chat (via `/add`) are in context, plus the repo map. This is a different philosophy -- manual context curation rather than automatic compaction.

**Long-running strategy**: For multi-session tasks with Aider, use git commits as your primary state management. At the end of each session, commit with a detailed message. At the start of the next session, the repo map gives the agent structural awareness, and you provide the specific context via `/add`.

### OpenCode

**Compaction**: OpenCode uses a dedicated system agent for compaction. Configure thresholds and strategy in `opencode.json`.

**Session export/import**:
```bash
opencode export <session-id> > backup.json   # Save session state
opencode import backup.json                    # Restore on another machine
opencode session list                          # List all sessions
opencode session resume <session-id>           # Resume specific session
opencode --continue                            # Resume last session
```

**Multi-session coordination**: OpenCode's server mode enables multiple agents to work simultaneously:

```bash
opencode serve --port 4096                                    # Start server
opencode attach http://localhost:4096 --session worker-1      # Agent 1
opencode attach http://localhost:4096 --session worker-2      # Agent 2
```

**Plugin-based state management**: OpenCode's plugin system can be used to implement custom persistence logic, including automated checkpointing and state recovery.

---

## Anti-Patterns

### Starting a Huge Task Without a Plan

**Symptom**: Agent immediately starts coding without understanding the full scope. Gets 30% done, discovers a fundamental issue, has to restart.

**Fix**: Always start with spec and plan. Even 15 minutes of planning saves hours of wasted work.

### Never Committing During Long Sessions

**Symptom**: Agent works for 3 hours without committing. Compaction happens. Context is lost. No recovery point exists.

**Fix**: Commit after every completed subtask. Commit before compaction. Commit before risky operations. Commits are cheap; lost work is expensive.

### Relying Solely on Conversation Context

**Symptom**: All decisions and state exist only in the conversation. After compaction, the agent forgets key decisions and re-does work or contradicts earlier choices.

**Fix**: The "Write Before You Forget" pattern. If it matters, it must be in a file.

### Not Verifying After Each Major Change

**Symptom**: Agent makes 10 changes without running tests. Tests reveal the 3rd change broke something. Agent has to untangle 7 changes to find the bug.

**Fix**: Verify after every significant change. Run tests. Check compilation. Verify the specific behavior changed. This is more important in long-running tasks because the cost of backtracking increases with distance.

### Ignoring Signs of Context Rot

**Signs**:
- Agent asks about something it already decided
- Agent proposes an approach it already tried and rejected
- Agent claims a file contains something it does not
- Agent's responses become increasingly vague or generic
- Agent starts repeating itself

**Fix**: When you see these signs, stop immediately. Compact (or start a fresh session), write state to files, and resume with clean context. Pushing through context rot makes things worse, not better.

### Over-Engineering the Persistence Layer

**Symptom**: Spending 2 hours building a custom JSON-based state management system before starting the actual task. YAGNI applies.

**Fix**: Start with markdown files. progress.md, decisions.md, and git commits handle 95% of cases. Only add complexity (structured JSON checkpoints, automated state machines, custom databases) if you encounter a specific problem that markdown cannot solve.

---

## Metrics and Monitoring

### How to Tell If Your Agent Is Degrading

| Signal | Severity | Action |
|--------|----------|--------|
| Asking about already-decided things | Medium | Update memory files, consider compacting |
| Contradicting earlier decisions | High | Stop, write state, start fresh session |
| Hallucinating file contents | Critical | Stop immediately, revert to last checkpoint |
| Repeating the same failed approach | High | Agent is stuck -- pause for human review |
| Responses becoming vague/generic | Medium | Compact with focused instructions |
| Increasing time per task | Low-Medium | Normal fatigue or context pressure |

### Token Usage Tracking

Claude Code provides `/stats` to check current context usage. Monitor this periodically:

```
Good:  Context at 45% after 2 hours of work
OK:    Context at 65% after 3 hours of work
Watch: Context at 75% -- compact soon
Bad:   Context at 90% -- emergency compact, likely losing important context
```

### Progress Rate Monitoring

Track tasks completed per session. A declining rate across sessions suggests:
- Tasks are getting harder (normal)
- Context rot is accumulating (fixable)
- The plan needs revision (the remaining tasks may be poorly defined)

### When to Kill and Restart vs. When to Push Through

**Kill and restart when**:
- Agent is hallucinating file contents
- Agent contradicts itself within the same response
- The same error has occurred 3+ times with no progress
- Context is above 85% and the current task is not nearly done

**Push through when**:
- Agent is making steady progress but slowly
- Context is below 70%
- The current subtask is nearly complete (80%+ done)
- Restarting would require significant context re-loading

---

## Real-World Workflows

### Workflow 1: Large Refactor (1000+ File Changes)

**Scenario**: Migrating a Node.js Express codebase from CommonJS to ESM modules.

**Day 0: Planning (1 session)**
```
1. Read package.json, tsconfig.json, key source files
2. Create SPEC.md: scope, constraints, acceptance criteria
3. Create PLAN.md: ordered list of directories to convert
4. Create a test script that verifies ESM compatibility
5. Commit: "chore: add ESM migration spec and plan"
```

**Day 1-5: Execution (2-3 sessions/day)**
```
Each session:
1. Read PLAN.md and progress.md
2. Pick next directory from plan
3. For each file in directory:
   a. Convert require() to import
   b. Convert module.exports to export
   c. Update file extensions in imports
   d. Run tests for that module
4. Update progress.md
5. Commit: "refactor(dirname): convert to ESM"
6. Write session handoff note

Checkpoint strategy:
- Commit after each directory (not each file)
- Compact after every 2 directories
- Write progress before each compact
```

**Day 6: Verification (1 session)**
```
1. Read SPEC.md acceptance criteria
2. Run full test suite
3. Run ESM compatibility checker
4. Check for remaining require() calls
5. Update documentation
6. Final commit: "chore: complete ESM migration"
```

**Key insight**: The agent never needs to hold the entire codebase in context. Each session works on one directory. The plan file coordinates across sessions. Git history provides full traceability.

### Workflow 2: Full-Stack Feature (Multi-Day)

**Scenario**: Adding real-time collaborative editing to a document management app.

**Day 1: Foundation**
```
Session 1 (Morning): Spec + Architecture
- Research WebSocket libraries (ws vs socket.io)
- Define data model for operational transforms
- Write SPEC.md and ARCHITECTURE.md
- Decision: use Yjs CRDT library (document in decisions.md)
- Commit: "docs: add collaborative editing spec"

Session 2 (Afternoon): Backend Foundation
- Create WebSocket server module
- Implement Yjs document provider
- Write unit tests for CRDT operations
- Update progress.md
- Commit: "feat(collab): add WebSocket server and Yjs provider"
```

**Day 2: API Layer**
```
Session 3 (Morning): API Endpoints
- Read briefing from Session 2 handoff
- Create /documents/:id/collaborate endpoint
- Implement presence tracking (who's editing)
- Write integration tests
- Commit: "feat(collab): add collaboration API endpoints"

Session 4 (Afternoon): Permission Layer
- Read briefing from Session 3 handoff
- Add collaboration permissions to existing auth
- Implement document locking for non-collaborative edits
- Write permission tests
- Commit: "feat(collab): add collaboration permissions"
```

**Day 3: Frontend**
```
Session 5: Editor Integration
- Read briefing from Session 4 handoff
- Integrate Yjs with the editor component
- Implement cursor awareness (see other users' cursors)
- Write component tests
- Commit: "feat(collab): integrate Yjs with editor frontend"

Session 6: UI Polish
- Presence indicators
- Connection status display
- Conflict resolution UI
- Commit: "feat(collab): add collaboration UI components"
```

**Day 4: Integration + Polish**
```
Session 7: End-to-End Testing
- Full integration tests (multiple simulated users)
- Load testing (100 concurrent editors)
- Bug fixes found during testing
- Commit: "test(collab): add e2e and load tests"

Session 8: Documentation + Cleanup
- API documentation
- User-facing help content
- Code cleanup
- Final commit: "docs(collab): add documentation, complete feature"
```

### Workflow 3: Database Migration

**Scenario**: Migrating from PostgreSQL to CockroachDB for a multi-region deployment.

**Phase 1: Assessment (Day 1)**
```
Session 1: Schema Analysis
- Export current schema
- Identify PostgreSQL-specific features in use
- Document incompatibilities (sequences, extensions, custom types)
- Create MIGRATION-PLAN.md with risk assessment
- Commit: "docs: add CockroachDB migration assessment"
```

**Phase 2: Schema Adaptation (Day 2-3)**
```
Session 2-4: Convert Schema
- For each incompatibility:
  1. Research CockroachDB equivalent
  2. Write migration SQL
  3. Test migration on empty CockroachDB instance
  4. Document the change in decisions.md
  5. Commit each migration individually

Checkpoint strategy:
- Each migration is its own commit
- Test after each migration (not at the end)
- If a migration fails, the previous commit is the rollback point
```

**Phase 3: Application Changes (Day 4-5)**
```
Session 5-8: Update Application Code
- Convert PostgreSQL-specific queries
- Update ORM configuration
- Handle CockroachDB transaction semantics (serializable by default)
- Update connection pooling (CockroachDB handles this differently)
- Write dual-database tests (run same tests against both)
```

**Phase 4: Data Migration (Day 6)**
```
Session 9: Data Transfer
- Write data export scripts
- Write data import scripts with transformation
- Test with subset of production data
- Verify data integrity (row counts, checksums)
- Document rollback procedure
```

**Phase 5: Cutover (Day 7)**
```
Session 10: Go/No-Go Verification
- Run full test suite against CockroachDB
- Performance benchmarks (compare with PostgreSQL baseline)
- Verify multi-region replication
- Update runbooks and monitoring
- Final commit: "feat: complete CockroachDB migration"
```

**Key insight**: Database migrations are inherently sequential and high-risk. The checkpoint strategy is more conservative: commit after every individual migration, test immediately, and maintain a clear rollback path at every step.

---

## Cross-References

| Document | Relevance |
|----------|-----------|
| [01 - Ralph Loops](01-ralph-loops.md) | Persistent execution pattern; combine with external memory for long tasks |
| [02 - Spec-Driven Development](02-spec-driven-development.md) | Critical for multi-day tasks; specs provide persistent requirements |
| [03 - Agent Teams](03-agent-teams.md) | Split large tasks across multiple agents; file-based coordination |
| [04 - Context Management](04-context-management.md) | Foundational context strategies; this document extends them to multi-day scale |
| [05 - Session Teleportation](05-session-teleportation.md) | Move long-running sessions between devices |
| [METHODOLOGIES.md](../METHODOLOGIES.md) | Overview of all methodologies and research sources |
| [AI_AGENT_TRICKS.md](../AI_AGENT_TRICKS.md) | Implementation techniques across CLI agents; context compaction, manifest files, hooks |

---

## References

### Research Papers

- [LLMs Get Lost In Multi-Turn Conversation](https://arxiv.org/abs/2505.06120) -- Laban et al., Microsoft Research, May 2025. 39% performance drop in multi-turn vs single-turn across 15 LLMs.
- [METR - Measuring AI Ability to Complete Long Tasks](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/) -- March 2025. Task horizon doubling every ~7 months (accelerating to 4 months in 2024-2025).
- [How Does Time Horizon Vary Across Domains?](https://metr.org/blog/2025-07-14-how-does-time-horizon-vary-across-domains/) -- METR, July 2025. Domain-specific analysis of AI task horizons.
- [Active Context Compression: Autonomous Memory Management in LLM Agents](https://arxiv.org/html/2601.07190) -- January 2026. Techniques for automated context management.
- [A Scalable Benchmark for Repository-Oriented Long-Horizon Conversational Context Management](https://arxiv.org/html/2603.06358) -- March 2026. Benchmarking long-horizon context in code assistants.

### Vendor Documentation

- [Anthropic - Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) -- November 2025. Context editing (+29%), memory tool (+39%), combined (-84% tokens).
- [Anthropic - Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) -- Context engineering principles.
- [Anthropic - Managing Context on the Claude Developer Platform](https://www.anthropic.com/news/context-management) -- Context editing and memory tool capabilities.
- [Claude Code Documentation - How Claude Code Works](https://code.claude.com/docs/en/how-claude-code-works) -- Agentic loop, subagents, compaction.
- [Claude Code Documentation - Hooks Reference](https://code.claude.com/docs/en/hooks) -- PreCompact, PostToolUse, SessionStart hooks.
- [Claude Code Documentation - Memory](https://docs.anthropic.com/en/docs/claude-code/en/memory) -- CLAUDE.md, MEMORY.md system.
- [OpenAI - Introducing the Codex App](https://openai.com/index/introducing-the-codex-app/) -- Cloud execution, worktree isolation, parallel agents.
- [OpenAI - Codex Multi-Agent](https://developers.openai.com/codex/subagents) -- Subagent workflows, parallel execution.
- [Aider - Repository Map](https://aider.chat/docs/repomap.html) -- Tree-sitter based repo maps, graph ranking.

### Community Resources

- [Simon Willison - Embracing the Parallel Coding Agent Lifestyle](https://simonwillison.net/2025/Oct/5/parallel-coding-agents/) -- Practical patterns for running multiple agents.
- [AI Agents Context Management Breakthroughs](https://bytebridge.medium.com/ai-agents-context-management-breakthroughs-and-long-running-task-execution-d5cee32aeaa4) -- Context management survey.
- [Git Worktrees: The Secret Weapon for Running Multiple AI Coding Agents](https://medium.com/@mabd.dev/git-worktrees-the-secret-weapon-for-running-multiple-ai-coding-agents-in-parallel-e9046451eb96) -- Worktree isolation patterns.
- [Nate's Newsletter - Long-Running AI Agents](https://natesnewsletter.substack.com/p/i-read-everything-google-anthropic) -- Survey of Manus, Google, and Anthropic approaches.
- [Understanding Claude Code's Context Window](https://www.damiangalarza.com/posts/2025-12-08-understanding-claude-code-context-window/) -- Practical context window analysis.

---

*Last Updated: March 18, 2026*
