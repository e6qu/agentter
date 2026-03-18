# OpenCode Plugins & Hooks

*Extending OpenCode with JavaScript/TypeScript plugins*

---

## Overview

**Plugins** allow you to extend OpenCode by hooking into various lifecycle **events** and customizing behavior. You can create plugins to add new features, integrate with external services, or modify default behavior.

**Plugin Capabilities**:
- Hook into 25+ lifecycle events
- Add custom tools
- Modify tool inputs/outputs
- Inject environment variables
- Send notifications
- Log structured data

---

## Using Plugins

### From Local Files

Place JavaScript or TypeScript files in plugin directories:

- `.opencode/plugins/` - Project-level plugins
- `~/.config/opencode/plugins/` - Global plugins

Files are automatically loaded at startup.

---

### From NPM

Specify npm packages in `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "plugin": [
    "opencode-helicone-session",
    "opencode-wakatime",
    "@my-org/custom-plugin"
  ]
}
```

**Installation**: Packages are installed automatically using Bun at startup.

**Cache**: Dependencies cached in `~/.cache/opencode/node_modules/`

---

### Load Order

Plugins load in sequence:

1. Global config (`~/.config/opencode/opencode.json`)
2. Project config (`opencode.json`)
3. Global plugin directory (`~/.config/opencode/plugins/`)
4. Project plugin directory (`.opencode/plugins/`)

**Duplicates**: Same name+version loaded once; local and npm with similar names load separately.

---

## Creating Plugins

### Basic Structure

A plugin is a JavaScript/TypeScript module exporting a plugin function:

```javascript
// .opencode/plugins/my-plugin.js
export const MyPlugin = async ({ project, client, $, directory, worktree }) => {
  console.log("Plugin initialized!")

  return {
    // Hook implementations
    "session.created": async () => {
      console.log("Session created!")
    }
  }
}
```

### Context Object

The plugin function receives:

| Property | Description |
|----------|-------------|
| `project` | Current project information |
| `directory` | Current working directory |
| `worktree` | Git worktree path |
| `client` | OpenCode SDK client |
| `$` | Bun's shell API |

---

### TypeScript Support

Import types from the plugin package:

```typescript
import type { Plugin } from "@opencode-ai/plugin"

export const MyPlugin: Plugin = async ({ project, client, $, directory, worktree }) => {
  return {
    // Type-safe hook implementations
  }
}
```

---

### External Dependencies

Add a `package.json` to your config directory:

```json
{
  "dependencies": {
    "shescape": "^2.1.0"
  }
}
```

OpenCode runs `bun install` at startup.

**Usage in plugin**:
```javascript
import { escape } from "shescape"

export const MyPlugin = async () => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool === "bash") {
        output.args.command = escape(output.args.command)
      }
    }
  }
}
```

---

## Available Events

### Command Events

| Event | Description |
|-------|-------------|
| `command.executed` | After a command is executed |

---

### File Events

| Event | Description |
|-------|-------------|
| `file.edited` | When a file is edited |
| `file.watcher.updated` | When watched files change |

---

### Installation Events

| Event | Description |
|-------|-------------|
| `installation.updated` | When installation status changes |

---

### LSP Events

| Event | Description |
|-------|-------------|
| `lsp.client.diagnostics` | LSP diagnostics received |
| `lsp.updated` | LSP data updated |

---

### Message Events

| Event | Description |
|-------|-------------|
| `message.part.removed` | Message part removed |
| `message.part.updated` | Message part updated |
| `message.removed` | Message removed |
| `message.updated` | Message updated |

---

### Permission Events

| Event | Description |
|-------|-------------|
| `permission.asked` | Permission requested from user |
| `permission.replied` | User responded to permission |

---

### Server Events

| Event | Description |
|-------|-------------|
| `server.connected` | Client connected to server |

---

### Session Events

| Event | Description |
|-------|-------------|
| `session.created` | New session created |
| `session.compacted` | Context compacted |
| `session.deleted` | Session deleted |
| `session.diff` | Session diff generated |
| `session.error` | Error occurred |
| `session.idle` | Session became idle |
| `session.status` | Session status changed |
| `session.updated` | Session updated |

---

### Todo Events

| Event | Description |
|-------|-------------|
| `todo.updated` | Todo list updated |

---

### Shell Events

| Event | Description |
|-------|-------------|
| `shell.env` | Shell environment setup |

---

### Tool Events

| Event | Description |
|-------|-------------|
| `tool.execute.before` | Before tool executes |
| `tool.execute.after` | After tool executes |

---

### TUI Events

| Event | Description |
|-------|-------------|
| `tui.prompt.append` | Text appended to prompt |
| `tui.command.execute` | TUI command executed |
| `tui.toast.show` | Toast notification shown |

---

## Hook Signatures

### Before Hooks (Modify Input/Output)

```javascript
"tool.execute.before": async (input, output) => {
  // input: Original tool input
  // output: Mutable output object
  output.args.modified = true
}
```

### After Hooks (Read-Only Result)

```javascript
"tool.execute.after": async (input, output) => {
  // input: Tool input
  // output: Tool result (read-only)
  console.log("Tool result:", output.result)
}
```

### Event Hooks (Notification)

```javascript
"session.created": async () => {
  console.log("Session created!")
}
```

---

## Plugin Examples

### Example 1: Notifications

Send notifications when session completes:

```javascript
// .opencode/plugins/notifications.js
export const NotificationPlugin = async ({ project, client, $ }) => {
  return {
    "session.idle": async () => {
      // macOS notification
      await $`osascript -e 'display notification "Session completed!" with title "OpenCode"'`
    }
  }
}
```

---

### Example 2: .env Protection

Prevent reading sensitive `.env` files:

```javascript
// .opencode/plugins/env-protection.js
export const EnvProtection = async () => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool === "read" && output.args.filePath.includes(".env")) {
        throw new Error("Access to .env files is blocked by policy")
      }
    }
  }
}
```

---

### Example 3: Environment Variables

Inject environment variables into shell execution:

```javascript
// .opencode/plugins/inject-env.js
export const InjectEnvPlugin = async () => {
  return {
    "shell.env": async (input, output) => {
      output.env.PROJECT_ROOT = input.cwd
      output.env.NODE_ENV = "development"
      output.env.API_KEY = process.env.API_KEY
    }
  }
}
```

---

### Example 4: Command Logging

Log all executed commands:

```javascript
// .opencode/plugins/command-logger.js
export const CommandLogger = async ({ client }) => {
  return {
    "tool.execute.after": async (input, output) => {
      if (input.tool === "bash") {
        await client.app.log({
          body: {
            service: "command-logger",
            level: "info",
            command: input.args.command,
            exitCode: output.exitCode
          }
        })
      }
    }
  }
}
```

---

### Example 5: Custom Tool

Add a custom tool:

```typescript
// .opencode/plugins/custom-tools.ts
import { type Plugin, tool } from "@opencode-ai/plugin"

export const CustomToolsPlugin: Plugin = async (ctx) => {
  return {
    tool: {
      // Custom tool definition
      mytool: tool({
        description: "This is a custom tool",
        args: {
          foo: tool.schema.string(),
          bar: tool.schema.number().optional()
        },
        async execute(args, context) {
          const { directory, worktree } = context
          return `Hello ${args.foo} from ${directory} (worktree: ${worktree})`
        }
      })
    }
  }
}
```

**Custom tools are available alongside built-in tools**.

---

### Example 6: Compaction Customization

Customize context compaction:

```typescript
// .opencode/plugins/compaction.ts
import type { Plugin } from "@opencode-ai/plugin"

export const CompactionPlugin: Plugin = async () => {
  return {
    "experimental.session.compacting": async (input, output) => {
      // Inject additional context
      output.context.push(`
## Custom Context
- Current task status: ${getTaskStatus()}
- Important decisions: ${getDecisions()}
- Active files: ${getActiveFiles()}
`)
    }
  }
}
```

**Replace entire prompt**:
```typescript
export const CustomCompactionPlugin: Plugin = async () => {
  return {
    "experimental.session.compacting": async (input, output) => {
      output.prompt = `Custom compaction prompt...`
    }
  }
}
```

---

### Example 7: Structured Logging

Use `client.app.log()` instead of `console.log`:

```javascript
// .opencode/plugins/structured-logger.js
export const LoggerPlugin = async ({ client }) => {
  await client.app.log({
    body: {
      service: "my-plugin",
      level: "info",  // debug, info, warn, error
      message: "Plugin initialized",
      extra: {
        version: "1.0.0",
        features: ["logging", "analytics"]
      }
    }
  })

  return {
    "session.error": async (event) => {
      await client.app.log({
        body: {
          service: "my-plugin",
          level: "error",
          message: "Session error",
          error: event.error
        }
      })
    }
  }
}
```

---

## Advanced Patterns

### Pattern 1: Conditional Hooks

```javascript
export const SmartPlugin = async () => {
  return {
    "tool.execute.before": async (input, output) => {
      // Only modify certain tools
      if (input.tool !== "write") return

      // Only modify certain file types
      if (!output.args.filePath.endsWith(".ts")) return

      // Apply transformation
      output.args.content = addHeader(output.args.content)
    }
  }
}
```

### Pattern 2: State Management

```javascript
export const StatefulPlugin = async () => {
  const state = {
    commandCount: 0,
    lastCommand: null
  }

  return {
    "tool.execute.after": async (input) => {
      if (input.tool === "bash") {
        state.commandCount++
        state.lastCommand = input.args.command
      }
    },
    "session.idle": async () => {
      console.log(`Executed ${state.commandCount} commands this session`)
    }
  }
}
```

### Pattern 3: Async Initialization

```javascript
export const AsyncPlugin = async ({ $ }) => {
  // Fetch data at plugin load time
  const config = await $`cat ~/.my-plugin-config.json`.json()

  return {
    "tool.execute.before": async (input, output) => {
      // Use loaded config
      output.args.timeout = config.timeout
    }
  }
}
```

---

## Publishing Plugins

### As NPM Package

1. Create package with plugin export
2. Publish to npm
3. Users add to `opencode.json`:

```json
{
  "plugin": ["your-plugin-name"]
}
```

### Naming Conventions

- `opencode-<feature>`: Feature plugins
- `@org/opencode-<feature>`: Scoped plugins
- `opencode-<service>-integration`: Service integrations

---

## Best Practices

1. **Handle errors gracefully**: Don't crash the main application
2. **Use structured logging**: `client.app.log()` over `console.log`
3. **Check tool names**: Verify `input.tool` before modifying
4. **Be conservative**: Don't block critical operations
5. **Document side effects**: Users should know what the plugin does
6. **Test thoroughly**: Plugins run in the main process

---

## Troubleshooting

### Plugin not loading

**Check**:
- File extension: `.js` or `.ts`
- Export name matches filename (convention)
- No syntax errors
- Located in correct directory

### Hook not firing

**Check**:
- Event name is correct (case-sensitive)
- Plugin loaded (check with console.log on init)
- Event actually occurs

### Performance issues

**Tips**:
- Avoid heavy computation in hooks
- Use async operations
- Cache expensive operations
- Debounce rapid-fire events

---

*Last Updated: March 18, 2026*
