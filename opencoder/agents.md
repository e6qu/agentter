# OpenCode Agents

*Creating and configuring primary and subagents in OpenCode*

---

## Overview

Agents in OpenCode are specialized AI assistants that can be configured for specific tasks and workflows. Each agent has its own system prompt, model, temperature, and tool permissions.

**Agent Types**:
| Type | Description | Invocation |
|------|-------------|------------|
| **Primary** | Main assistants you interact with directly | `Tab` to cycle |
| **Subagent** | Specialized assistants for specific tasks | `@mention` |

---

## Built-in Agents

### Primary Agents

#### Build Agent

| Property | Value |
|----------|-------|
| **Mode** | `primary` |
| **Default** | Yes |
| **Tools** | All enabled |

The standard agent for development work with full access to file operations and system commands.

**Use for**: Writing code, editing files, running commands, general development.

#### Plan Agent

| Property | Value |
|----------|-------|
| **Mode** | `primary` |
| **Default** | No |
| **Tools** | Read-only (write/edit/bash = ask) |

Restricted agent for planning and analysis. Prevents unintended changes.

**Use for**: Code analysis, creating implementation plans, documentation review.

---

### Subagents

#### General Subagent

| Property | Value |
|----------|-------|
| **Mode** | `subagent` |
| **Tools** | Full (except todo) |

General-purpose agent for researching complex questions and executing multi-step tasks.

**Use for**: Parallel work units, research tasks, independent investigations.

**Invocation**:
```
@general help me search for this function
```

#### Explore Subagent

| Property | Value |
|----------|-------|
| **Mode** | `subagent` |
| **Tools** | Read-only |

Fast, read-only agent for exploring codebases. Cannot modify files.

**Use for**: Finding files, searching code, answering questions about code.

**Invocation**:
```
@explore find all API endpoints in this project
```

---

### Hidden System Agents

| Agent | Purpose |
|-------|---------|
| `compaction` | Compacts long context into summaries |
| `title` | Generates session titles |
| `summary` | Creates session summaries |

These run automatically and are not user-selectable.

---

## Using Agents

### Switching Primary Agents

**Keyboard**: Press `Tab` to cycle through primary agents

**Or**: Use configured `switch_agent` keybind

### Invoking Subagents

**Automatic**: Primary agents invoke subagents based on their descriptions

**Manual**: Use `@mention` in your message:
```
@explore find usages of User.findById
@general write a test for the auth middleware
```

### Navigating Subagent Sessions

When subagents create child sessions:

| Keybind | Action |
|---------|--------|
| `<Leader>+Right` | Cycle forward (parent → child1 → child2) |
| `<Leader>+Left` | Cycle backward |

---

## Creating Custom Agents

### Method 1: JSON Configuration

Add to `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "agent": {
    "code-reviewer": {
      "mode": "subagent",
      "description": "Reviews code for best practices and potential issues",
      "model": "anthropic/claude-sonnet-4-20250514",
      "temperature": 0.1,
      "prompt": "You are a code reviewer. Focus on security, performance, and maintainability.",
      "tools": {
        "write": false,
        "edit": false,
        "bash": false,
        "read": true,
        "grep": true,
        "glob": true
      }
    },
    "backend-dev": {
      "mode": "primary",
      "description": "Backend development specialist",
      "model": "anthropic/claude-sonnet-4-20250514",
      "prompt": "You are a backend developer specializing in Node.js and PostgreSQL.",
      "tools": {
        "write": true,
        "edit": true,
        "bash": true
      },
      "steps": 10
    }
  }
}
```

### Method 2: Markdown Files

Create `.opencode/agents/<name>.md`:

> **Note**: The markdown filename (without extension) becomes the agent name. For example, `.opencode/agents/code-reviewer.md` creates an agent named `code-reviewer`.

```markdown
---
description: Reviews code for quality and best practices
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
tools:
  write: false
  edit: false
  bash: false
---
You are in code review mode. Focus on:
- Code quality and best practices
- Potential bugs and edge cases
- Performance implications
- Security considerations

Provide constructive feedback without making direct changes.
```

**File locations**:
- Global: `~/.config/opencode/agents/`
- Project: `.opencode/agents/`

---

## Agent Configuration Options

### Required Options

#### `description`

Brief description of what the agent does and when to use it.

```json
{
  "agent": {
    "review": {
      "description": "Reviews code for best practices and potential issues"
    }
  }
}
```

**Required**: Yes

---

### Optional Options

#### `mode`

Agent type: `primary` or `subagent`

```json
{
  "agent": {
    "my-agent": {
      "mode": "subagent"
    }
  }
}
```

**Default**: `primary`

---

#### `model`

Override the default model for this agent.

```json
{
  "agent": {
    "plan": {
      "model": "anthropic/claude-haiku-4-20250514"
    },
    "implement": {
      "model": "anthropic/claude-opus-4-20250514"
    }
  }
}
```

---

#### `temperature`

Control randomness (0.0-1.0+):

| Range | Use Case |
|-------|----------|
| 0.0-0.2 | Code analysis, planning (deterministic) |
| 0.3-0.5 | General development (balanced) |
| 0.6-1.0 | Brainstorming, exploration (creative) |

```json
{
  "agent": {
    "analyze": { "temperature": 0.1 },
    "brainstorm": { "temperature": 0.8 }
  }
}
```

**Default**: Model-specific (typically 0, or 0.55 for Qwen)

---

#### `prompt`

Custom system prompt for the agent.

```json
{
  "agent": {
    "review": {
      "prompt": "You are a security-focused code reviewer..."
    }
  }
}
```

**Loading from file**:
```json
{
  "agent": {
    "review": {
      "prompt": "{file:./prompts/review.txt}"
    }
  }
}
```

---

#### `tools`

Control which tools the agent can use.

```json
{
  "agent": {
    "readonly": {
      "tools": {
        "write": false,
        "edit": false,
        "bash": false,
        "read": true,
        "grep": true,
        "glob": true
      }
    }
  }
}
```

**Available Tools**:
| Tool | Description |
|------|-------------|
| `bash` | Execute shell commands |
| `edit` | Modify existing files |
| `write` | Create new files |
| `read` | Read file contents |
| `grep` | Search file contents |
| `glob` | Find files by pattern |
| `list` | List directory contents |
| `patch` | Apply patches |
| `todowrite` | Manage todo lists |
| `todoread` | Read todo lists |
| `webfetch` | Fetch web content |
| `skill` | Load agent skills |

**Default**: All enabled

---

#### `steps`

Maximum number of agentic iterations before forced text response.

```json
{
  "agent": {
    "quick-thinker": {
      "description": "Fast reasoning with limited iterations",
      "steps": 5
    }
  }
}
```

**Use case**: Cost control, preventing runaway agents

**Default**: Unlimited

---

#### `disable`

Disable an agent.

```json
{
  "agent": {
    "review": {
      "disable": true
    }
  }
}
```

---

#### `permission`

Override global permissions for this agent.

```json
{
  "agent": {
    "plan": {
      "permission": {
        "skill": {
          "internal-*": "allow"
        }
      }
    }
  }
}
```

---

## Agent Patterns

### Pattern 1: Specialized Reviewers

```json
{
  "agent": {
    "security-reviewer": {
      "mode": "subagent",
      "description": "Security-focused code review",
      "prompt": "Focus on security vulnerabilities, injection risks, authentication issues...",
      "tools": { "read": true, "write": false, "edit": false }
    },
    "performance-reviewer": {
      "mode": "subagent",
      "description": "Performance optimization review",
      "prompt": "Focus on algorithmic complexity, database queries, caching opportunities...",
      "tools": { "read": true, "write": false, "edit": false }
    }
  }
}
```

**Usage**:
```
@security-reviewer review the auth module
@performance-reviewer check the API endpoints
```

### Pattern 2: Capability-Based Agents

```json
{
  "agent": {
    "frontend-dev": {
      "mode": "primary",
      "description": "Frontend specialist (React, CSS, accessibility)",
      "prompt": "You are a frontend developer specializing in React, TypeScript, and accessibility.",
      "tools": { "write": true, "edit": true, "bash": true }
    },
    "backend-dev": {
      "mode": "primary",
      "description": "Backend specialist (Node.js, PostgreSQL)",
      "prompt": "You are a backend developer specializing in Node.js, Express, and PostgreSQL.",
      "tools": { "write": true, "edit": true, "bash": true }
    }
  }
}
```

### Pattern 3: Workflow Agents

```json
{
  "agent": {
    "test-writer": {
      "mode": "subagent",
      "description": "Writes comprehensive tests",
      "prompt": "Write thorough unit and integration tests. Aim for high coverage.",
      "tools": { "write": true, "read": true }
    },
    "docs-writer": {
      "mode": "subagent",
      "description": "Writes documentation",
      "prompt": "Write clear documentation with examples. Use JSDoc for code documentation.",
      "tools": { "write": true, "read": true }
    }
  }
}
```

---

## CLI Commands

### List Agents

```bash
opencode agent list
```

### Create Agent (Interactive)

```bash
opencode agent create
```

Guides you through creating a new agent with prompts and tool configuration.

---

## Best Practices

1. **Clear descriptions**: Help the system know when to invoke subagents
2. **Specific prompts**: Narrow scope for more consistent results
3. **Tool restrictions**: Limit tools to what the agent actually needs
4. **Temperature tuning**: Lower for precision, higher for creativity
5. **Mode selection**: Use `subagent` for parallelizable work

---

## Example: Complete Agent Setup

**File**: `.opencode/agents/architect.md`

```markdown
---
description: Software architect for designing systems and APIs
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.2
tools:
  write: false
  edit: false
  bash: false
  read: true
  grep: true
  glob: true
---
You are a software architect. Your role is to:

1. Design system architecture
2. Define API specifications
3. Create data models
4. Plan technology choices
5. Document trade-offs

**Guidelines**:
- Consider scalability and maintainability
- Document assumptions and constraints
- Provide alternatives with pros/cons
- Never implement, only design

**Output format**:
Provide designs as markdown documentation with clear sections for:
- Overview
- Architecture diagram (text-based)
- API specifications
- Data models
- Technology choices with rationale
```

**Usage**:
```
@architect design the user authentication system
```

---

*Last Updated: March 18, 2026*
