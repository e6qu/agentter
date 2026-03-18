# OpenCode Commands

*Creating custom slash commands for repetitive tasks*

---

## Overview

**Custom commands** in OpenCode let you define reusable prompts that can be executed by typing `/` followed by the command name in the TUI. They automate repetitive tasks and standardize workflows.

**Built-in commands**: `/init`, `/undo`, `/redo`, `/share`, `/help`, `/compact`

**Custom commands**: User-defined for specific workflows

---

## Creating Commands

### Method 1: Markdown Files

Create `.opencode/commands/<name>.md`:

```markdown
---
description: Run tests with coverage
agent: build
model: anthropic/claude-sonnet-4-20250514
---
Run the full test suite with coverage report and show any failures.
Focus on the failing tests and suggest fixes.
```

**File locations**:
- Global: `~/.config/opencode/commands/`
- Project: `.opencode/commands/`

**Usage**: Type `/test` in TUI

---

### Method 2: JSON Configuration

Add to `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "command": {
    "test": {
      "template": "Run the full test suite with coverage report and show any failures.\nFocus on the failing tests and suggest fixes.",
      "description": "Run tests with coverage",
      "agent": "build",
      "model": "anthropic/claude-sonnet-4-20250514"
    }
  }
}
```

---

## Command Configuration

### Required Options

#### `template`

The prompt sent to the LLM when the command executes.

```json
{
  "command": {
    "test": {
      "template": "Run the test suite and report results."
    }
  }
}
```

**Markdown equivalent**:
```markdown
---
description: Run tests
---
Run the test suite and report results.
```

---

### Optional Options

#### `description`

Brief description shown in TUI when typing `/`.

```json
{
  "command": {
    "test": {
      "description": "Run tests with coverage"
    }
  }
}
```

---

#### `agent`

Specify which agent executes this command.

```json
{
  "command": {
    "review": {
      "agent": "plan"
    }
  }
}
```

**Default**: Current active agent

---

#### `model`

Override the default model for this command.

```json
{
  "command": {
    "analyze": {
      "model": "anthropic/claude-sonnet-4-20250514"
    }
  }
}
```

---

#### `subtask`

Force command to trigger a subagent invocation.

```json
{
  "command": {
    "analyze": {
      "subtask": true
    }
  }
}
```

**Use case**: Prevent polluting primary context with analysis work.

---

## Advanced Templates

### Arguments

Pass arguments using `$ARGUMENTS` or positional parameters.

#### Using $ARGUMENTS

```markdown
---
description: Create a new component
---
Create a new React component named $ARGUMENTS with TypeScript support.
Include proper typing and basic structure.
```

**Usage**: `/create-component Button`

**Result**: `$ARGUMENTS` → `Button`

---

#### Using Positional Parameters

| Variable | Description |
|----------|-------------|
| `$1` | First argument |
| `$2` | Second argument |
| `$3` | Third argument |
| ... | ... |

```markdown
---
description: Create a new file with content
---
Create a file named $1 in the directory $2
with the following content: $3
```

**Usage**: `/create-file config.json src '{ "key": "value" }'`

**Result**:
- `$1` → `config.json`
- `$2` → `src`
- `$3` → `{ "key": "value" }`

---

### Shell Output

Use ``!`command` `` to inject bash command output.

```markdown
---
description: Analyze test coverage
---
Here are the current test results:
!`npm test`
Based on these results, suggest improvements to increase coverage.
```

**Execution**:
1. Command runs in project root
2. Output captured
3. Output inserted into prompt

**Example with git**:
```markdown
---
description: Review recent changes
---
Recent git commits:
!`git log --oneline -10`
Review these changes and suggest any improvements.
```

**Example with file listing**:
```markdown
---
description: Check project structure
---
Current project structure:
!`find . -type f -name "*.ts" | head -20`
Analyze the file organization and suggest improvements.
```

---

### File References

Include file contents using `@filename`.

```markdown
---
description: Review component
---
Review the component in @src/components/Button.tsx.
Check for performance issues and suggest improvements.
```

**Behavior**:
- File content is read and included in prompt
- Relative to project root
- Multiple files: `@file1 @file2`

---

## Command Examples

### Testing Commands

```markdown
---
description: Run unit tests
agent: build
---
Run the unit test suite with npm test.
Show the test results and any failures.
If tests fail, analyze the errors and suggest fixes.
```

```markdown
---
description: Run tests with coverage
agent: build
---
Run tests with coverage reporting using npm run test:coverage.
Show coverage summary and identify untested code.
Suggest which areas need more test coverage.
```

---

### Code Quality Commands

```markdown
---
description: Run linter
agent: build
---
Run ESLint with npm run lint.
Show all linting errors and warnings.
Fix any auto-fixable issues.
```

```markdown
---
description: Format code
agent: build
---
Run the code formatter with npm run format.
Show which files were modified.
```

---

### Git Commands

```markdown
---
description: Show git status
agent: plan
---
Show the current git status with git status.
Explain what changes are staged, unstaged, and untracked.
Suggest next steps based on the state.
```

```markdown
---
description: Create commit
agent: build
---
Stage all changes with git add -A.
Create a commit with a descriptive message based on the changes.
Use conventional commit format (type: description).
```

---

### Documentation Commands

```markdown
---
description: Update README
agent: build
model: anthropic/claude-sonnet-4-20250514
---
Review the current README.md and update it to reflect the current state of the project.
Ensure it includes:
- Accurate installation instructions
- Updated API documentation
- Current feature list
- Working examples
```

---

### Analysis Commands

```markdown
---
description: Analyze dependencies
agent: plan
subtask: true
---
Analyze the project's dependencies.
!`npm list --depth=0`
Check for:
- Outdated packages
- Security vulnerabilities
- Unused dependencies
- Duplicate packages
Provide recommendations for updates.
```

---

### Component Generation

```markdown
---
description: Create React component
agent: build
---
Create a new React component named $1.
Include:
- TypeScript interfaces for props
- JSDoc documentation
- Basic styling
- Unit test file
- Export from index.ts
```

**Usage**: `/create-react-component UserCard`

---

## Built-in Commands

| Command | Description |
|---------|-------------|
| `/init` | Initialize project configuration |
| `/undo` | Undo last change |
| `/redo` | Redo previously undone change |
| `/share` | Share current session |
| `/compact` | Compact conversation context |
| `/help` | Show help |

**Note**: Custom commands with the same name override built-in commands.

---

## Command Organization

### By Project Type

```
.opencode/commands/
├── test.md           # Run tests
├── lint.md           # Run linter
├── build.md          # Build project
├── deploy.md         # Deploy to production
└── docs.md           # Generate documentation
```

### By Workflow

```
.opencode/commands/
├── pr-prep.md        # Prepare for PR
├── release.md        # Create release
├── hotfix.md         # Emergency fix process
└── onboarding.md     # New developer setup
```

### By Domain

```
.opencode/commands/
├── db-migrate.md     # Run database migrations
├── db-seed.md        # Seed database
├── api-test.md       # Test API endpoints
└── e2e-test.md       # Run E2E tests
```

---

## Best Practices

1. **Clear descriptions**: Help users understand what the command does
2. **Consistent naming**: Use kebab-case (`run-tests`, not `runTests`)
3. **Specific scope**: One command = one task
4. **Include error handling**: Prompt should handle failures gracefully
5. **Document arguments**: If using `$1`, `$2`, explain what they are
6. **Test commands**: Verify they work as expected

---

## Tips

### Chaining Commands

Commands can reference other commands:
```markdown
---
description: Full CI check
---
Run the full CI pipeline locally:
1. Run linter
2. Run type checker
3. Run tests
4. Build project

Use /lint, /typecheck, /test, and /build commands.
```

### Conditional Logic

Prompt can include conditional instructions:
```markdown
---
description: Smart test runner
---
Check if test files were modified:
!`git diff --name-only HEAD | grep -E '\.(test|spec)\.(ts|js)$'`

If test files changed: Run full test suite
If only source changed: Run related tests only
If no changes: Skip tests
```

### Interactive Elements

Prompt can ask clarifying questions:
```markdown
---
description: Create migration
---
Create a new database migration.

Before proceeding, ask:
1. What is the migration name?
2. Which tables are affected?
3. Is this a breaking change?

Then generate the migration file.
```

---

*Last Updated: March 18, 2026*
