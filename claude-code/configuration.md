# Claude Code Configuration

*Complete guide to settings.json, permissions, and MCP*

---

## Overview

Claude Code is configured through `settings.json` files at various scopes. Configuration controls hooks, permissions, agents, MCP servers, and behavior.

---

## Configuration Locations

| Location | Scope | Shareable | Priority |
|----------|-------|-----------|----------|
| `~/.claude/settings.json` | Global | No | Lowest |
| `.claude/settings.json` | Project | Yes | Medium |
| `.claude/settings.local.json` | Project | No (gitignored) | High |
| Managed policy | Organization | Yes (admin) | Highest |

**Resolution**: Later configs override earlier ones for conflicting keys.

---

## Configuration Sections

### Hooks

Lifecycle automation:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/validate.sh"
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Session started'"
          }
        ]
      }
    ]
  }
}
```

See [Hooks documentation](./hooks.md) for all events.

---

### Permissions

Control tool access:

```json
{
  "permissions": {
    "allow": {
      "Bash": ["npm test", "npm run build", "git status"],
      "Edit": ["*.md", "*.txt"]
    },
    "deny": {
      "Bash": ["rm -rf /", "sudo *"]
    }
  }
}
```

**Format**:
```json
{
  "permissions": {
    "allow": {
      "ToolName": ["pattern1", "pattern2"]
    },
    "deny": {
      "ToolName": ["pattern1", "pattern2"]
    }
  }
}
```

**Pattern matching**:
- Exact match: `"npm test"`
- Wildcard: `"npm run *"`
- Any: `"*"`

---

### Agents

Custom subagent definitions:

```json
{
  "agents": {
    "backend": {
      "description": "Backend developer",
      "system": "You are a backend developer...",
      "allowed_tools": ["Read", "Edit", "Write", "Bash"]
    },
    "reviewer": {
      "description": "Code reviewer",
      "system": "You review code for quality...",
      "allowed_tools": ["Read", "Grep"]
    }
  }
}
```

See [Agents documentation](./agents.md) for all options.

---

### MCP Servers

Model Context Protocol configuration:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "postgres": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "mcp/postgres", "postgresql://localhost/db"]
    }
  }
}
```

**Fields**:
- `command`: Executable
- `args`: Arguments array
- `env`: Environment variables

---

## Complete Example

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/safety-check.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/lint.sh"
          }
        ]
      }
    ]
  },
  "permissions": {
    "allow": {
      "Bash": ["npm *", "git *", "ls *"]
    },
    "deny": {
      "Bash": ["rm -rf /", "sudo *", "*password*"]
    }
  },
  "agents": {
    "backend": {
      "description": "Backend developer",
      "system": "You specialize in Node.js and databases.",
      "allowed_tools": ["Read", "Edit", "Write", "Bash", "Grep"]
    },
    "security": {
      "description": "Security reviewer",
      "system": "You review code for security issues.",
      "allowed_tools": ["Read", "Grep"]
    }
  },
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    }
  }
}
```

---

## Project Instructions

### CLAUDE.md / .claude.md

Create project instructions:

```markdown
# Project Guidelines

## Tech Stack
- React 18 + TypeScript
- Node.js + Express
- PostgreSQL

## Coding Standards
- Use functional components
- Write tests for APIs
- Follow ESLint rules

## Git Workflow
- Feature branches
- Descriptive commits
- PRs for review
```

**Locations**:
- `.claude.md`
- `CLAUDE.md`
- `.claude/CLAUDE.md`

Loaded automatically in every session.

---

## Environment Variables

### API Keys

```bash
# Anthropic
export ANTHROPIC_API_KEY=your_key

# Or use
claude auth login
```

### MCP Environment

```json
{
  "mcpServers": {
    "github": {
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

---

## Managed Settings (Enterprise)

Organization-wide configuration:

```json
{
  "allowManagedHooksOnly": true,
  "hooks": {
    "PreToolUse": [...]
  }
}
```

**Fields**:
- `allowManagedHooksOnly`: Block user/project hooks

---

## Best Practices

1. **Project settings in Git**: Share team conventions
2. **Local settings for secrets**: Gitignore `.claude/settings.local.json`
3. **Hooks for safety**: Validate destructive operations
4. **Permissions for control**: Limit dangerous tools
5. **CLAUDE.md for context**: Document project specifics

---

*Last Updated: March 1, 2026*
