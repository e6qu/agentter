# Claude Code Agents

*Working with built-in and custom agents in Claude Code*

---

## Overview

Claude Code has a hierarchical agent system with built-in agents for common tasks and support for custom subagents with specialized capabilities.

**Agent Types**:
| Type | Description | Invocation |
|------|-------------|------------|
| **Default** | Main agent with full capabilities | Default on startup |
| **Built-in Subagents** | Specialized agents (Explore, Plan) | `@agent-name` |
| **Custom Subagents** | User-defined specialized agents | `@agent-name` |

---

## Built-in Agents

### Default Agent

The standard Claude Code agent with full tool access.

**Capabilities**:
- All tools (Read, Edit, Write, Bash, Grep, etc.)
- File modifications
- Command execution
- Git operations

**Use for**: General coding tasks, development work

---

### Explore Agent

A fast, read-only agent for codebase exploration.

**Capabilities**:
- Read files
- Search code (Grep)
- Find files (Glob)
- Cannot modify files

**Invocation**:
```
@explore find all React components in src/
@explore search for TODO comments
@explore understand the auth flow
```

**Use for**: Code understanding, finding code, analysis

---

### Plan Agent

An agent focused on analysis and planning without making changes.

**Capabilities**:
- Read files
- Analyze code
- Create plans
- Cannot modify files

**Invocation**:
```
@plan design the database schema
@plan create an implementation plan for feature X
```

**Use for**: Architecture design, planning, analysis

---

## Using Subagents

### Invocation Syntax

Use `@agent-name` to invoke a subagent:

```
@explore find usages of User.findById
@plan design the API for user management
@backend implement the auth middleware
```

### Context Handling

Subagents:
- Get current conversation context
- Can spawn their own subagents
- Report back to parent agent
- Can be run in isolated worktrees

### Parallel Execution

Invoke multiple subagents in parallel:

```
@frontend create the login form
@backend implement the login endpoint
@explore verify the current auth implementation
```

---

## Creating Custom Agents

### Agent Definition

Create `.claude/agents/<name>.json`:

```json
{
  "name": "backend",
  "description": "Backend development specialist",
  "system": "You are a backend developer specializing in Node.js, Express, and PostgreSQL. Focus on API design, database schema, and server-side logic.",
  "allowed_tools": ["Read", "Edit", "Write", "Bash", "Grep"]
}
```

### Agent Frontmatter

Create `.claude/agents/<name>.md`:

```markdown
---
name: security-auditor
description: Security-focused code reviewer
allowed-tools: Read, Grep, Glob
model: claude-3-5-sonnet-20241022
---
You are a security auditor. Review code for:
- SQL injection vulnerabilities
- XSS risks
- Authentication flaws
- Input validation issues

Provide specific recommendations with code examples.
```

---

## Agent Configuration Options

### `name`

Agent identifier (lowercase, alphanumeric with hyphens).

```json
{
  "name": "backend-dev"
}
```

### `description`

Brief description shown in autocomplete.

```json
{
  "description": "Backend development specialist"
}
```

### `system`

System prompt defining agent behavior.

```json
{
  "system": "You are a backend developer..."
}
```

### `allowed_tools`

Tools the agent can use.

```json
{
  "allowed_tools": ["Read", "Edit", "Grep"]
}
```

**Available Tools**:
- `Read` - Read files
- `Edit` - Edit files
- `Write` - Write files
- `Bash` - Execute commands
- `Grep` - Search content
- `Glob` - Find files
- `NotebookEdit` - Edit notebooks
- `NotebookRead` - Read notebooks

### `model`

Override the default model.

```json
{
  "model": "claude-3-5-sonnet-20241022"
}
```

### `hooks`

Hooks scoped to this agent.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": "validate.sh" }]
      }
    ]
  }
}
```

---

## Agent Locations

| Location | Scope | Path |
|----------|-------|------|
| Global | All projects | `~/.claude/agents/` |
| Project | Single project | `.claude/agents/` |
| Plugin | When plugin enabled | `<plugin>/agents/` |

---

## Best Practices

### 1. Clear Descriptions

Help users know when to use the agent:

```json
{
  "description": "Backend specialist for Node.js APIs and database design"
}
```

### 2. Specific System Prompts

Define narrow scope:

```markdown
You are a frontend developer specializing in React and TypeScript.
Focus on:
- Component design
- State management
- Performance optimization
- Accessibility

Do not write backend code.
```

### 3. Tool Restrictions

Limit tools to what's needed:

```json
{
  "allowed_tools": ["Read", "Grep"]
}
```

### 4. Consistent Naming

Use descriptive, consistent names:
- `backend-dev`
- `frontend-dev`
- `security-auditor`
- `test-writer`

---

## Example Agents

### Backend Developer

```json
{
  "name": "backend",
  "description": "Backend development specialist (Node.js, PostgreSQL)",
  "system": "You are a backend developer specializing in Node.js, Express, and PostgreSQL.",
  "allowed_tools": ["Read", "Edit", "Write", "Bash", "Grep", "Glob"]
}
```

### Security Auditor

```json
{
  "name": "security-auditor",
  "description": "Security-focused code reviewer",
  "system": "You are a security auditor. Review code for vulnerabilities and provide specific fixes.",
  "allowed_tools": ["Read", "Grep", "Glob"],
  "model": "claude-3-opus-20240229"
}
```

### Test Writer

```json
{
  "name": "test-writer",
  "description": "Writes comprehensive tests",
  "system": "You write thorough unit and integration tests. Aim for high coverage and edge cases.",
  "allowed_tools": ["Read", "Write", "Bash", "Grep"]
}
```

---

*Last Updated: March 1, 2026*
