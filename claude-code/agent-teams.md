# Claude Code Agent Teams

*Parallel execution with multiple agents*

---

## Overview

**Agent Teams** enable multiple Claude agents to work in parallel on different aspects of a task. Each agent works in an isolated git worktree, preventing conflicts while allowing concurrent progress.

**Key Features**:
- File-disjoint parallel execution
- Automatic task claiming with file locking
- Git worktree isolation
- Automatic coordination

---

## How Agent Teams Work

### Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    AGENT TEAMS FLOW                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  User Request: "Implement auth and user management"         │
│                                                              │
│         ↓                                                    │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                 Coordinator Agent                     │  │
│  │  - Breaks down task into subtasks                    │  │
│  │  - Creates task files in .claude/current_tasks/      │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│         ↓                                                    │
│                                                              │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │   Agent 1    │    │   Agent 2    │    │   Agent 3    │  │
│  │  (Auth API)  │    │ (User Model) │    │  (Frontend)  │  │
│  │              │    │              │    │              │  │
│  │  Worktree 1  │    │  Worktree 2  │    │  Worktree 3  │  │
│  │              │    │              │    │              │  │
│  │  auth.ts     │    │  user.ts     │    │  Login.tsx   │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│                                                              │
│         ↓                                                    │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Results aggregated                        │  │
│  │         PRs created or changes merged                  │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Task Claiming

### File Locking System

Agents claim tasks by creating files in `.claude/current_tasks/`:

```
.claude/current_tasks/
├── agent-1.txt   → "Working on: src/auth/auth.ts"
├── agent-2.txt   → "Working on: src/models/user.ts"
└── agent-3.txt   → "Working on: src/components/Login.tsx"
```

**Rules**:
- Each agent claims one task at a time
- Tasks must be file-disjoint (no overlapping files)
- Agents check for existing claims before starting
- Claims are released when task completes

### Claim File Format

```
Task: Implement authentication middleware
Files: src/auth/middleware.ts, src/auth/types.ts
Started: 2026-03-01T10:00:00Z
Agent: auth-agent
```

---

## Worktree Isolation

Each agent gets an isolated git worktree:

```bash
# Main worktree
~/project/

# Agent worktrees
~/project/.claude/worktrees/agent-1/
~/project/.claude/worktrees/agent-2/
~/project/.claude/worktrees/agent-3/
```

**Benefits**:
- Changes don't interfere with each other
- Can run tests independently
- Easy to discard if needed
- Clean merge when complete

---

## Using Agent Teams

### With /batch Command

The `/batch` command automates agent teams:

```
/batch migrate from Express to Fastify
```

**Process**:
1. Analyzes codebase
2. Creates 5-30 independent tasks
3. Shows plan for approval
4. Spawns background agents
5. Each agent works in isolated worktree
6. Results aggregated
7. PRs created (optional)

---

### Manual Agent Teams

Spawn agents with specific tasks:

```
Implement the authentication system:

@backend create the auth API endpoints in src/auth/
@database create the user table schema in migrations/
@frontend create the login form in src/components/

Work in parallel and report back when done.
```

---

### Custom Subagents for Teams

Create specialized agents:

```json
{
  "agents": {
    "backend": {
      "description": "Backend API developer",
      "system": "You implement backend APIs..."
    },
    "frontend": {
      "description": "Frontend UI developer",
      "system": "You implement React components..."
    },
    "database": {
      "description": "Database schema designer",
      "system": "You design database schemas..."
    }
  }
}
```

---

## Coordination

### Task Dependencies

Some tasks depend on others:

```
Phase 1 (Sequential):
  @database create user schema

Phase 2 (Parallel):
  @backend implement auth API
  @frontend create login form
```

### How Agents Communicate

Agents in a team coordinate through several mechanisms:

1. **Task files** (`.claude/current_tasks/`): Each agent writes a claim file declaring which files it is working on. Other agents read these files to avoid conflicts.
2. **Shared filesystem**: Agents in separate worktrees share the same git history. When one agent commits, others can see the changes via git.
3. **Coordinator agent**: The parent/coordinator agent orchestrates the team. It receives status updates as subagents complete their tasks, and can reassign work or merge results.
4. **Commit messages**: Agents write descriptive commit messages that serve as communication to other agents and the coordinator about what was changed and why.
5. **PR descriptions**: When agents create PRs, the descriptions document the changes for review and integration.

Agents do **not** have direct real-time message passing between them. Communication is asynchronous and file-based. The coordinator polls or waits for subagent completion, then aggregates results.

---

## Best Practices

### 1. File-Disjoint Tasks

```
Good:
  Agent 1: src/auth/*.ts
  Agent 2: src/user/*.ts
  Agent 3: src/components/*.tsx

Bad:
  Agent 1: src/app.ts (lines 1-50)
  Agent 2: src/app.ts (lines 51-100)
  → Will conflict!
```

### 2. Clear Task Boundaries

```
@backend implement auth middleware
  - Files: src/auth/middleware.ts
  - Interface: authenticate(req, res, next)
  - Returns: user object or 401
```

### 3. Shared Interfaces First

```
@architect define the auth interfaces
  - User type
  - AuthRequest type
  - Token payload type

@backend implement against interfaces
@frontend implement against interfaces
```

### 4. Test Isolation

Each worktree has its own:
- Database (if configured)
- Build artifacts
- Test environment

```bash
# Each agent runs tests in their worktree
npm test
```

---

## Example Workflows

### Feature Implementation

```
Implement user profiles:

1. @architect design the profile system
   - Data model
   - API endpoints
   - Component structure

2. @database create migration for profiles table

3. @backend implement profile API
   - GET /api/profile
   - PUT /api/profile
   - Upload avatar endpoint

4. @frontend create profile page
   - Profile form
   - Avatar upload
   - Display component

5. @qa write tests for profile functionality
```

### Refactoring

```
Refactor to use new API client:

/batch update all API calls to use new client
```

### Documentation

```
@backend document all API endpoints
@frontend document all components
@qa document test procedures
```

---

## Troubleshooting

### Conflicts

**Issue**: Agents editing same files

**Solution**:
- Better task decomposition
- Clear file ownership
- Use `/batch` for automatic decomposition

### Worktree Issues

**Issue**: Worktree not cleaning up

**Solution**:
```bash
# Clean up manually
rm -rf .claude/worktrees/
git worktree prune
```

### Stuck Agents

**Issue**: Agent not releasing claim

**Solution**:
```bash
# Remove claim file manually
rm .claude/current_tasks/agent-name.txt
```

---

*Last Updated: March 18, 2026*
