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
| `SessionStart` | Session begins/resumes | Yes (startup, resume, clear, compact) |
| `UserPromptSubmit` | User submits prompt | No |
| `PreToolUse` | Before tool executes | Yes (tool name) |
| `PermissionRequest` | Permission dialog appears | Yes (tool name) |
| `PostToolUse` | After tool succeeds | Yes (tool name) |
| `PostToolUseFailure` | After tool fails | Yes (tool name) |
| `Notification` | Notification sent | Yes (type) |
| `SubagentStart` | Subagent spawned | Yes (agent type) |
| `SubagentStop` | Subagent finishes | Yes (agent type) |
| `Stop` | Claude finishes responding | No |
| `TeammateIdle` | Agent team member idle | No |
| `TaskCompleted` | Task marked complete | No |
| `ConfigChange` | Config file changes | Yes (source) |
| `WorktreeCreate` | Worktree being created | No |
| `WorktreeRemove` | Worktree being removed | No |
| `PreCompact` | Before context compaction | Yes (manual, auto) |
| `SessionEnd` | Session terminates | Yes (reason) |

---

## Hook Execution Behavior

### Timeouts

Hook commands have a default execution timeout. If a hook script exceeds the timeout, it is terminated and treated as a failure. Keep hook scripts fast to avoid blocking the agent loop.

### Error Handling

- If a hook script exits with a **non-zero exit code**, the hook is considered failed.
- For `PreToolUse` hooks: a failed hook (non-zero exit, no JSON output) does **not** block the tool -- it is treated as "no opinion" (equivalent to allowing the tool). To explicitly block a tool, return JSON with `permissionDecision: "deny"`.
- For `PostToolUse` hooks: failures are logged but do not affect the tool result.
- If a hook script produces **invalid JSON** on stdout, the output is ignored and the hook is treated as having no opinion.
- Multiple hooks for the same event run sequentially in order. If any `PreToolUse` hook returns `deny`, the tool is blocked regardless of other hooks.
- Hooks that crash or time out are logged for debugging but do not crash the Claude Code session.

### Blocking vs Non-Blocking

- `PreToolUse` and `PermissionRequest` hooks are **blocking** -- they run before the tool executes and can prevent execution.
- `PostToolUse`, `SessionStart`, `SessionEnd`, and other hooks are **non-blocking** -- they run for side effects (logging, notifications) and do not affect the agent's behavior.

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

1. **Fast execution**: Hooks block the agent loop -- keep them under a few seconds
2. **Graceful failures**: Exit 0 to allow if uncertain
3. **Specific matchers**: Avoid wildcard `*` for performance
4. **Logging**: Use hooks for audit trails
5. **Security**: Validate inputs in hook scripts
6. **Idempotency**: Design hooks to be safe if run multiple times

---

*Last Updated: March 18, 2026*
