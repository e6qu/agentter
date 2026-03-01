# OpenCode Modes

*Configuring and using Build, Plan, and custom modes*

---

## Overview

Modes in OpenCode customize the behavior, tools, and prompts for different use cases. They allow you to restrict or enable capabilities based on your current task.

**Key Concept**: Modes control what the AI can do, helping prevent unintended changes during sensitive operations.

---

## Built-in Modes

### Build Mode

| Property | Value |
|----------|-------|
| **Default** | Yes |
| **Purpose** | Full development work |
| **Tool Access** | All tools enabled |

The standard mode for active development where you need complete access to file operations and system commands.

**Use for**:
- Writing and editing code
- Creating new files
- Running build commands
- Executing tests
- General development tasks

---

### Plan Mode

| Property | Value |
|----------|-------|
| **Default** | No |
| **Purpose** | Analysis and planning |
| **Tool Access** | Read-only (mostly) |

A restricted mode designed for planning and analysis without making changes.

**Default Restrictions**:
| Tool | Plan Mode | Notes |
|------|-----------|-------|
| `write` | ❌ Disabled | Cannot create new files |
| `edit` | ❌ Disabled | Cannot modify files (except `.opencode/plans/*.md`) |
| `patch` | ❌ Disabled | Cannot apply patches |
| `bash` | ❌ Disabled | Cannot execute shell commands |
| `read` | ✅ Enabled | Can read files |
| `grep` | ✅ Enabled | Can search code |
| `glob` | ✅ Enabled | Can find files |

**Use for**:
- Code analysis and understanding
- Creating implementation plans
- Writing specifications
- Documentation review
- Architecture design

**Special Permission**: Can write to `.opencode/plans/*.md` to save planning output.

---

## Switching Modes

### In TUI

Press `Tab` to cycle between available modes.

Or use your configured `switch_mode` keybind.

### Via Configuration

Set default mode in `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mode": {
    "build": {
      "prompt": "You are in build mode. Focus on implementation."
    }
  }
}
```

---

## Creating Custom Modes

### Method 1: JSON Configuration

Add to `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mode": {
    "docs": {
      "prompt": "You are in documentation mode. Write clear, comprehensive docs.",
      "tools": {
        "write": true,
        "edit": true,
        "bash": false,
        "read": true,
        "grep": true
      }
    },
    "debug": {
      "model": "anthropic/claude-sonnet-4-20250514",
      "temperature": 0.1,
      "prompt": "You are in debug mode. Investigate issues carefully.",
      "tools": {
        "bash": true,
        "read": true,
        "grep": true,
        "write": false,
        "edit": false
      }
    }
  }
}
```

### Method 2: Markdown Files

Create `.opencode/modes/<name>.md`:

```markdown
---
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
tools:
  bash: true
  read: true
  grep: true
  write: false
  edit: false
---
You are in debug mode. Your primary goal is to help investigate and diagnose issues.

Focus on:
- Understanding the problem through careful analysis
- Using bash commands to inspect system state
- Reading relevant files and logs
- Searching for patterns and anomalies
- Providing clear explanations of findings

Do not make any changes to files. Only investigate and report.
```

**File locations**:
- Global: `~/.config/opencode/modes/`
- Project: `.opencode/modes/`

---

## Mode Configuration Options

### `model`

Override the default model for this mode.

```json
{
  "mode": {
    "plan": {
      "model": "anthropic/claude-haiku-4-20250514"
    },
    "implement": {
      "model": "anthropic/claude-opus-4-20250514"
    }
  }
}
```

**Use case**: Use faster/cheaper models for planning, powerful models for implementation.

---

### `temperature`

Control creativity and determinism.

| Range | Use Case |
|-------|----------|
| 0.0-0.2 | Code analysis, planning (very focused) |
| 0.3-0.5 | General development (balanced) |
| 0.6-1.0 | Brainstorming, exploration (creative) |

```json
{
  "mode": {
    "analyze": {
      "temperature": 0.1,
      "prompt": "Analyze code carefully and methodically."
    },
    "brainstorm": {
      "temperature": 0.7,
      "prompt": "Generate creative ideas and solutions."
    }
  }
}
```

**Default**: Model-specific (typically 0, or 0.55 for Qwen)

---

### `prompt`

Custom system prompt for the mode.

```json
{
  "mode": {
    "review": {
      "prompt": "You are in code review mode. Focus on quality and best practices."
    }
  }
}
```

**Loading from file**:
```json
{
  "mode": {
    "review": {
      "prompt": "{file:./prompts/code-review.txt}"
    }
  }
}
```

---

### `tools`

Control which tools are available.

```json
{
  "mode": {
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

**All available tools**:
| Tool | Description |
|------|-------------|
| `bash` | Execute shell commands |
| `edit` | Modify existing files |
| `write` | Create new files |
| `read` | Read file contents |
| `grep` | Search file contents |
| `glob` | Find files by pattern |
| `list` | List directory contents |
| `patch` | Apply patches to files |
| `todowrite` | Manage todo lists |
| `todoread` | Read todo lists |
| `webfetch` | Fetch web content |

**Default**: All enabled

---

## Common Mode Patterns

### Pattern 1: Documentation Mode

```markdown
---
model: anthropic/claude-haiku-4-20250514
temperature: 0.3
tools:
  write: true
  edit: true
  read: true
  grep: true
  bash: false
---
You are in documentation mode. Your task is to write clear, comprehensive documentation.

**Guidelines**:
- Use clear, concise language
- Include code examples
- Follow existing documentation style
- Update table of contents if needed
- Never execute bash commands

Focus on:
- README files
- API documentation
- Code comments
- Usage guides
```

### Pattern 2: Refactoring Mode

```markdown
---
model: anthropic/claude-sonnet-4-20250514
temperature: 0.2
tools:
  edit: true
  read: true
  grep: true
  glob: true
---
You are in refactoring mode. Improve code quality without changing functionality.

**Priorities**:
1. Improve readability and maintainability
2. Apply consistent naming conventions
3. Reduce code duplication (DRY)
4. Optimize performance where appropriate
5. Ensure all tests continue to pass

**Constraints**:
- Do not change external behavior
- Maintain backward compatibility
- Run tests after changes
- Commit frequently with clear messages
```

### Pattern 3: Security Audit Mode

```markdown
---
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
tools:
  read: true
  grep: true
  bash: false
  write: false
  edit: false
---
You are in security audit mode. Analyze code for security vulnerabilities.

**Check for**:
- Injection vulnerabilities (SQL, command, XSS)
- Authentication/authorization issues
- Sensitive data exposure
- Insecure dependencies
- Input validation gaps

**Output format**:
For each issue found:
1. Severity (Critical/High/Medium/Low)
2. Location (file:line)
3. Description of vulnerability
4. Recommended fix

Do not make any changes. Only report findings.
```

### Pattern 4: Test Mode

```markdown
---
model: anthropic/claude-sonnet-4-20250514
temperature: 0.2
tools:
  write: true
  read: true
  bash: true
---
You are in test mode. Write comprehensive tests for the codebase.

**Requirements**:
- Unit tests for all functions
- Integration tests for API endpoints
- Edge case coverage
- Mock external dependencies
- Aim for >80% coverage

**Framework**: Use the existing test framework in the project.

Run tests after writing: `npm test` or equivalent.
```

---

## Mode vs Agent: When to Use Which

| Feature | Mode | Agent |
|---------|------|-------|
| **Purpose** | Tool permissions + behavior | Specialized assistant |
| **Switching** | Tab key | Tab key or @mention |
| **Use case** | Task-type restriction | Capability specialization |
| **Configuration** | `mode` key | `agent` key |

**Rule of thumb**:
- Use **Modes** to restrict/enable tools for safety
- Use **Agents** to create specialized assistants

You can combine them:
```json
{
  "agent": {
    "security-auditor": {
      "mode": "subagent",
      "prompt": "Security-focused analysis..."
    }
  },
  "mode": {
    "audit": {
      "tools": { "write": false, "edit": false }
    }
  }
}
```

---

## Workflow Example

### Spec-Driven Development Workflow

1. **Switch to Plan mode** (`Tab`)
   ```
   "Create a comprehensive SPEC.md for the user authentication feature"
   ```

2. **Review and refine the spec**
   - AI analyzes requirements
   - Creates detailed specification
   - Saves to `.opencode/plans/auth-spec.md`

3. **Switch to Build mode** (`Tab`)
   ```
   "Implement the authentication feature per SPEC.md"
   ```

4. **Implementation with full tools**
   - Write code
   - Create files
   - Run tests

---

## Best Practices

1. **Start with Plan mode** for new features
2. **Use restricted modes** when reviewing code
3. **Create project-specific modes** for team workflows
4. **Document mode purposes** in your README
5. **Set appropriate temperatures**: Lower for precision tasks

---

*Last Updated: March 1, 2026*
