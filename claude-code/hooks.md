# Claude Code Hooks

*Lifecycle automation with hooks and event handlers*

---

## Overview

**Hooks** are user-defined shell commands, HTTP endpoints, or LLM prompts that execute automatically at specific points in Claude Code's lifecycle. Use hooks for automation, quality gates, logging, and safety checks.

**Hook Types**:
| Type | Description |
|------|-------------|
| `command` | Shell command execution |
| `http` | HTTP endpoint call |
| `prompt` | LLM prompt evaluation |

---

## Hook Events

| Event | When it fires | Matcher Support |
|-------|---------------|-----------------|
| `SessionStart` | Session begins/resumes | ✅ (startup, resume, clear, compact) |
| `UserPromptSubmit` | User submits prompt | ❌ |
| `PreToolUse` | Before tool executes | ✅ (tool name) |
| `PermissionRequest` | Permission dialog appears | ✅ (tool name) |
| `PostToolUse` | After tool succeeds | ✅ (tool name) |
| `PostToolUseFailure` | After tool fails | ✅ (tool name) |
| `Notification` | Notification sent | ✅ (type) |
| `SubagentStart` | Subagent spawned | ✅ (agent type) |
| `SubagentStop` | Subagent finishes | ✅ (agent type) |
| `Stop` | Claude finishes responding | ❌ |
| `TeammateIdle` | Agent team member idle | ❌ |
| `TaskCompleted` | Task marked complete | ❌ |
| `ConfigChange` | Config file changes | ✅ (source) |
| `WorktreeCreate` | Worktree being created | ❌ |
| `WorktreeRemove` | Worktree being removed | ❌ |
| `PreCompact` | Before context compaction | ✅ (manual, auto) |
| `SessionEnd` | Session terminates | ✅ (reason) |

---

## Hook Locations

| Location | Scope | Shareable |
|----------|-------|-----------|
| `~/.claude/settings.json` | All projects | No |
| `.claude/settings.json` | Single project | Yes |
| `.claude/settings.local.json` | Single project | No (gitignored) |
| Managed policy | Organization | Yes (admin) |
| Plugin `hooks/hooks.json` | When plugin enabled | Yes |
| Skill/agent frontmatter | While active | Yes |

---

## Configuration Structure

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "pattern",
        "hooks": [
          {
            "type": "command",
            "command": "path/to/script.sh"
          }
        ]
      }
    ]
  }
}
```

**Structure**:
1. Event name (e.g., `PreToolUse`)
2. Matcher group (filter when it fires)
3. Hook handlers (commands to run)

---

## Matchers

### Tool Events

Match by tool name:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [...]
      },
      {
        "matcher": "Edit|Write",
        "hooks": [...]
      },
      {
        "matcher": "mcp__.*",
        "hooks": [...]
      }
    ]
  }
}
```

**Matcher values**:
- `Bash` - Bash tool
- `Edit|Write` - Either Edit or Write
- `Notebook.*` - Any Notebook tool
- `mcp__.*` - Any MCP tool
- `mcp__memory__.*` - Memory server tools
- `mcp__.*__write.*` - Any write-related MCP tool

### SessionStart

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [...]
      }
    ]
  }
}
```

**Values**: `startup`, `resume`, `clear`, `compact`

### SessionEnd

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "matcher": "logout",
        "hooks": [...]
      }
    ]
  }
}
```

**Values**: `clear`, `logout`, `prompt_input_exit`, `bypass_permissions_disabled`, `other`

### No Matcher Support

These events always fire:
- `UserPromptSubmit`
- `Stop`
- `TeammateIdle`
- `TaskCompleted`
- `WorktreeCreate`
- `WorktreeRemove`

---

## Hook Handlers

### Command Hooks

Execute shell scripts:

```json
{
  "type": "command",
  "command": ".claude/hooks/validate.sh"
}
```

**Input**: JSON on stdin
**Output**: JSON on stdout

**Example script**:
```bash
#!/bin/bash
# .claude/hooks/block-rm.sh

# Read input
read -r input

# Extract command
COMMAND=$(echo "$input" | jq -r '.tool_input.command')

# Check if destructive
if echo "$COMMAND" | grep -q 'rm -rf'; then
  jq -n '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "Destructive command blocked"
    }
  }'
else
  exit 0  # Allow
fi
```

### HTTP Hooks

Call HTTP endpoints:

```json
{
  "type": "http",
  "url": "https://api.example.com/hook",
  "headers": {
    "Authorization": "Bearer token"
  }
}
```

**Input**: POST body
**Output**: JSON response

### Prompt Hooks

Evaluate LLM prompts:

```json
{
  "type": "prompt",
  "prompt": "Should this command be allowed? Answer yes/no."
}
```

---

## Input/Output Format

### PreToolUse Input

```json
{
  "tool_name": "Bash",
  "tool_input": {
    "command": "rm -rf /tmp/build",
    "description": "Clean build directory"
  },
  "conversation_id": "conv_123",
  "message_id": "msg_456"
}
```

### PreToolUse Output (Block)

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Destructive command blocked by policy"
  }
}
```

### PostToolUse Input

```json
{
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/project/src/app.ts",
    "content": "..."
  },
  "tool_output": {
    "success": true
  }
}
```

---

## Examples

### Block Destructive Commands

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/block-rm.sh"
          }
        ]
      }
    ]
  }
}
```

```bash
#!/bin/bash
read -r input
COMMAND=$(echo "$input" | jq -r '.tool_input.command')

if [[ "$COMMAND" =~ rm\ -rf ]]; then
  jq -n '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "deny", permissionDecisionReason: "rm -rf blocked"}}'
  exit 0
fi

exit 0
```

---

### Lint on File Write

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/lint-check.sh"
          }
        ]
      }
    ]
  }
}
```

```bash
#!/bin/bash
read -r input
FILE=$(echo "$input" | jq -r '.tool_input.file_path')

if [[ "$FILE" =~ \.ts$ ]]; then
  npx eslint "$FILE" || echo "Linting issues found"
fi
```

---

### Log Session Activity

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Session started' >> ~/.claude/sessions.log"
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Session ended' >> ~/.claude/sessions.log"
          }
        ]
      }
    ]
  }
}
```

---

### Notify on Completion

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification \"Claude finished\"'"
          }
        ]
      }
    ]
  }
}
```

---

### MCP Tool Validation

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "mcp__.*__write.*",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/validate-mcp-write.sh"
          }
        ]
      }
    ]
  }
}
```

---

## Advanced Features

### Async Hooks

Hooks run asynchronously by default. For blocking behavior, return a decision.

### Multiple Hooks

Chain multiple hooks for the same event:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "hook1.sh" },
          { "type": "command", "command": "hook2.sh" },
          { "type": "prompt", "prompt": "Final approval?" }
        ]
      }
    ]
  }
}
```

### Permission Decisions

Return from `PreToolUse` and `PermissionRequest`:

| Decision | Effect |
|----------|--------|
| `allow` | Execute tool |
| `deny` | Block tool |
| `ask` | Show permission dialog |

---

## Best Practices

1. **Fast execution**: Hooks block the agent loop
2. **Graceful failures**: Exit 0 to allow if uncertain
3. **Specific matchers**: Avoid wildcard `*` for performance
4. **Logging**: Use hooks for audit trails
5. **Security**: Validate inputs in hook scripts

---

*Last Updated: March 1, 2026*
