# OpenCode Configuration

*Complete guide to opencode.json, TUI settings, and configuration precedence*

---

## Overview

OpenCode can be configured using JSON or JSONC (JSON with Comments) files. Configuration controls models, agents, tools, MCP servers, plugins, and UI behavior.

---

## Configuration Locations

OpenCode merges configuration from multiple sources. **Later sources override earlier ones** for conflicting keys.

### Precedence Order

1. **Remote config** (`.well-known/opencode`) - Organizational defaults
2. **Global config** (`~/.config/opencode/opencode.json`) - User preferences
3. **Custom path** (`OPENCODE_CONFIG` env var) - Custom overrides
4. **Project config** (`opencode.json`) - Project-specific settings
5. **`.opencode` directories** - Agents, commands, plugins
6. **Inline config** (`OPENCODE_CONFIG_CONTENT` env var) - Runtime overrides

**Non-conflicting settings from all sources are preserved**.

---

## Configuration Files

### Main Config: `opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "anthropic/claude-sonnet-4-20250514",
  "autoupdate": true,
  "server": {
    "port": 4096
  },
  "agent": {
    "build": {
      "model": "anthropic/claude-sonnet-4-20250514"
    }
  }
}
```

---

### TUI Config: `tui.json`

```json
{
  "$schema": "https://opencode.ai/tui.json",
  "theme": "tokyonight",
  "scroll_speed": 3,
  "diff_style": "auto"
}
```

---

## Location Details

### Remote Config

Organizations provide defaults via `.well-known/opencode` endpoint:

```json
{
  "mcp": {
    "jira": {
      "type": "remote",
      "url": "https://jira.example.com/mcp",
      "enabled": false
    }
  }
}
```

Users can override in local config:
```json
{
  "mcp": {
    "jira": {
      "enabled": true
    }
  }
}
```

---

### Global Config

**Location**: `~/.config/opencode/opencode.json`

Use for user-wide preferences:
- Default models
- Provider settings
- Global agents/commands
- Permissions

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "anthropic/claude-sonnet-4-20250514",
  "provider": {
    "anthropic": {
      "options": {
        "timeout": 600000
      }
    }
  }
}
```

**TUI Settings**: `~/.config/opencode/tui.json`

---

### Project Config

**Location**: `opencode.json` in project root

Use for project-specific settings:
- Project agents
- MCP servers
- Mode configurations
- Custom commands

**Safe to commit to Git**.

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    }
  },
  "agent": {
    "backend": {
      "description": "Backend specialist",
      "prompt": "You work on Node.js backend code..."
    }
  }
}
```

---

### Environment Variables

#### `OPENCODE_CONFIG`

Specify custom config file path:

```bash
export OPENCODE_CONFIG=/path/to/my/config.json
opencode run "Hello world"
```

Loaded between global and project configs.

---

#### `OPENCODE_CONFIG_DIR`

Specify custom config directory:

```bash
export OPENCODE_CONFIG_DIR=/path/to/config-directory
opencode run "Hello world"
```

Directory searched for agents, commands, modes, plugins.

**Can override** standard `.opencode` settings.

---

#### `OPENCODE_CONFIG_CONTENT`

Inline configuration for runtime overrides:

```bash
export OPENCODE_CONFIG_CONTENT='{"model": "openai/gpt-4o"}'
opencode run "Hello world"
```

Highest precedence - overrides everything.

---

#### `OPENCODE_TUI_CONFIG`

Specify custom TUI config file:

```bash
export OPENCODE_TUI_CONFIG=/path/to/my-tui.json
opencode
```

---

## Configuration Sections

### Schema

Always include schema for validation and autocomplete:

```json
{
  "$schema": "https://opencode.ai/config.json"
}
```

---

### Models & Providers

#### Default Model

```json
{
  "model": "anthropic/claude-sonnet-4-20250514"
}
```

#### Small Model (for lightweight tasks)

```json
{
  "small_model": "anthropic/claude-haiku-4-20250514"
}
```

Used for: Title generation, summaries, compaction

**Default**: Cheaper model from provider, or falls back to main model

---

#### Provider Configuration

```json
{
  "provider": {
    "anthropic": {
      "options": {
        "timeout": 600000,
        "setCacheKey": true
      }
    },
    "openai": {
      "options": {
        "timeout": 300000
      }
    }
  }
}
```

**Common Options**:
| Option | Description |
|--------|-------------|
| `timeout` | Request timeout in ms (default: 300000) |
| `setCacheKey` | Ensure cache key is set |
| `apiKey` | API key (usually from env) |
| `baseURL` | Custom endpoint URL |

---

#### Amazon Bedrock Specific

```json
{
  "provider": {
    "amazon-bedrock": {
      "options": {
        "region": "us-east-1",
        "profile": "my-aws-profile",
        "endpoint": "https://bedrock-runtime.us-east-1.vpce.amazonaws.com"
      }
    }
  }
}
```

| Option | Description |
|--------|-------------|
| `region` | AWS region (default: `AWS_REGION` or `us-east-1`) |
| `profile` | AWS profile from `~/.aws/credentials` |
| `endpoint` | VPC endpoint URL |

---

### Agents

Configure specialized agents:

```json
{
  "agent": {
    "build": {
      "mode": "primary",
      "model": "anthropic/claude-sonnet-4-20250514",
      "prompt": "{file:./prompts/build.txt}",
      "temperature": 0.3,
      "tools": {
        "write": true,
        "edit": true,
        "bash": true
      }
    },
    "plan": {
      "mode": "primary",
      "model": "anthropic/claude-haiku-4-20250514",
      "tools": {
        "write": false,
        "edit": false,
        "bash": false
      }
    },
    "reviewer": {
      "mode": "subagent",
      "description": "Code reviewer",
      "prompt": "You review code for quality...",
      "temperature": 0.1
    }
  }
}
```

**Options**:
- `mode`: `primary` or `subagent`
- `model`: Override default model
- `prompt`: System prompt (string or `{file:path}`)
- `temperature`: Randomness (0.0-1.0)
- `tools`: Tool permissions
- `steps`: Max iterations
- `disable`: Disable agent

---

### Modes

Configure modes:

```json
{
  "mode": {
    "build": {
      "model": "anthropic/claude-sonnet-4-20250514",
      "prompt": "{file:./prompts/build.txt}",
      "tools": {
        "write": true,
        "edit": true
      }
    },
    "plan": {
      "model": "anthropic/claude-haiku-4-20250514",
      "temperature": 0.1,
      "tools": {
        "write": false,
        "edit": false
      }
    }
  }
}
```

**Options**:
- `model`: Mode-specific model
- `temperature`: Creativity control
- `prompt`: Mode system prompt
- `tools`: Available tools

---

### Tools

Enable/disable tools globally:

```json
{
  "tools": {
    "write": false,
    "bash": false,
    "webfetch": true
  }
}
```

**Available Tools**:
- `bash` - Execute shell commands
- `edit` - Modify files
- `write` - Create files
- `read` - Read files
- `grep` - Search content
- `glob` - Find files
- `list` - List directories
- `patch` - Apply patches
- `todowrite` - Manage todos
- `todoread` - Read todos
- `webfetch` - Fetch web content
- `skill` - Load skills

---

### MCP Servers

Configure Model Context Protocol servers:

```json
{
  "mcp": {
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
      "args": ["run", "-i", "--rm", "mcp/postgres", "postgresql://localhost/mydb"]
    }
  }
}
```

**Options**:
- `command`: Executable
- `args`: Arguments array
- `env`: Environment variables
- `type`: `"remote"` for remote servers
- `url`: Remote server URL
- `enabled`: Boolean to enable/disable

---

### Plugins

Load plugins from npm:

```json
{
  "plugin": [
    "opencode-helicone-session",
    "opencode-wakatime",
    "@my-org/custom-plugin"
  ]
}
```

Both regular and scoped packages supported.

---

### Permissions

Control access to skills and features:

```json
{
  "permission": {
    "skill": {
      "*": "allow",
      "pr-review": "allow",
      "internal-*": "deny",
      "experimental-*": "ask"
    }
  }
}
```

**Levels**:
- `allow` - Immediate access
- `deny` - Hidden and rejected
- `ask` - Prompt user

**Patterns**:
- `*` - Match all
- `internal-*` - Prefix match
- `*-testing` - Suffix match

---

### Server Settings

Configure `opencode serve` and `opencode web`:

```json
{
  "server": {
    "port": 4096,
    "hostname": "0.0.0.0",
    "mdns": true,
    "mdnsDomain": "myproject.local",
    "cors": ["http://localhost:5173", "https://app.example.com"]
  }
}
```

**Options**:
| Option | Description |
|--------|-------------|
| `port` | Listen port |
| `hostname` | Bind address |
| `mdns` | Enable mDNS discovery |
| `mdnsDomain` | Custom mDNS domain |
| `cors` | Allowed CORS origins |

---

### TUI Settings

In `tui.json`:

```json
{
  "$schema": "https://opencode.ai/tui.json",
  "theme": "tokyonight",
  "scroll_speed": 3,
  "scroll_acceleration": {
    "enabled": true
  },
  "diff_style": "auto",
  "keybinds": {
    "switch_mode": "Tab",
    "switch_agent": "Ctrl+Tab"
  }
}
```

**Themes**: `tokyonight`, `dracula`, `nord`, etc.

**Legacy**: `theme`, `keybinds`, `tui` keys in `opencode.json` are deprecated.

---

## Complete Example

```json
{
  "$schema": "https://opencode.ai/config.json",
  
  "model": "anthropic/claude-sonnet-4-20250514",
  "small_model": "anthropic/claude-haiku-4-20250514",
  
  "provider": {
    "anthropic": {
      "options": {
        "timeout": 600000
      }
    }
  },
  
  "agent": {
    "review": {
      "mode": "subagent",
      "description": "Code reviewer",
      "temperature": 0.1,
      "tools": {
        "write": false,
        "edit": false
      }
    }
  },
  
  "mode": {
    "debug": {
      "temperature": 0.1,
      "tools": {
        "bash": true,
        "write": false
      }
    }
  },
  
  "mcp": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    }
  },
  
  "plugin": [
    "opencode-helicone-session"
  ],
  
  "permission": {
    "skill": {
      "*": "allow"
    }
  },
  
  "server": {
    "port": 4096,
    "mdns": true
  }
}
```

---

## Validation

Use the JSON schema for validation:

```json
{
  "$schema": "https://opencode.ai/config.json"
}
```

Most editors provide autocomplete and validation with this schema.

---

*Last Updated: March 1, 2026*
