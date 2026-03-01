# Claude Code Skills

*Creating and using SKILL.md definitions to extend Claude's capabilities*

---

## Overview

**Skills** extend what Claude can do. Create a `SKILL.md` file with instructions, and Claude adds it to its toolkit. Skills follow the Agent Skills open standard, compatible across multiple AI tools.

**Key Features**:
- Automatic discovery based on context
- Direct invocation with `/skill-name`
- Bundled skills for common tasks
- Support for templates and examples

---

## Bundled Skills

Claude Code ships with built-in skills available in every session:

### `/simplify`

Reviews recently changed files and fixes quality issues.

**Process**:
1. Spawns 3 parallel review agents (reuse, quality, efficiency)
2. Aggregates findings
3. Applies fixes automatically

**Usage**:
```
/simplify
/simplify focus on memory efficiency
```

**When to use**: After implementing a feature or bug fix

---

### `/batch <instruction>`

Orchestrates large-scale changes across a codebase.

**Process**:
1. Researches codebase
2. Decomposes into 5-30 independent units
3. Presents plan for approval
4. Spawns background agents (one per unit)
5. Each agent implements, tests, and opens PR

**Usage**:
```
/batch migrate src/ from Solid to React
/batch update all API calls to use new client
```

**Requirements**: Git repository

**When to use**: Large refactoring, migrations, widespread changes

---

### `/debug [description]`

Troubleshoots current Claude Code session.

**Process**:
1. Reads session debug log
2. Analyzes for issues
3. Suggests fixes

**Usage**:
```
/debug
/debug Claude seems stuck in a loop
```

**When to use**: Session issues, unexpected behavior

---

### Developer Platform Skill

Activates automatically when code imports Anthropic SDK.

---

## Creating Skills

### Basic Structure

Create `.claude/skills/<name>/SKILL.md`:

```markdown
---
name: git-release
description: Create consistent releases and changelogs
---

## What I do
- Draft release notes from merged PRs
- Propose version bump
- Provide release command

## Steps
1. List merged PRs since last tag
2. Categorize changes
3. Draft release notes
4. Propose version
```

---

## Skill Locations

| Location | Scope | Path |
|----------|-------|------|
| Enterprise | Organization-wide | Managed settings |
| Personal | All your projects | `~/.claude/skills/<name>/SKILL.md` |
| Project | Single project | `.claude/skills/<name>/SKILL.md` |
| Plugin | When plugin enabled | `<plugin>/skills/<name>/SKILL.md` |

**Precedence**: Enterprise > Personal > Project > Plugin

**Plugin namespace**: `plugin-name:skill-name`

---

## Discovery

### Automatic Discovery

Claude discovers skills from:
1. Current working directory
2. Parent directories up to git root
3. Nested `.claude/skills/` in subdirectories (for monorepos)
4. Global `~/.claude/skills/`

### Live Change Detection

Skills defined in `--add-dir` directories are:
- Loaded automatically
- Picked up by live change detection
- Editable during session without restart

---

## Skill Structure

```
my-skill/
├── SKILL.md           # Main instructions (required)
├── template.md        # Template for Claude to fill
├── examples/
│   └── sample.md      # Example output
└── scripts/
    └── validate.sh    # Script Claude can run
```

---

## Frontmatter Reference

```markdown
---
name: my-skill                  # Display name (optional, defaults to dir name)
description: What this does     # When to use (recommended)
argument-hint: [filename]       # Autocomplete hint
disable-model-invocation: true  # Prevent auto-load (default: false)
user-invocable: true            # Show in / menu (default: true)
allowed-tools: Read, Grep       # Tools without permission
model: claude-3-5-sonnet        # Model override
context: fork                   # Run in forked subagent
agent: Explore                  # Subagent type for fork
---
```

### Field Details

| Field | Required | Description |
|-------|----------|-------------|
| `name` | No | Display name (lowercase, hyphens, max 64 chars) |
| `description` | Recommended | When to use skill |
| `argument-hint` | No | Shown in autocomplete |
| `disable-model-invocation` | No | Set `true` for manual-only |
| `user-invocable` | No | Set `false` to hide from `/` menu |
| `allowed-tools` | No | Tools usable without permission |
| `model` | No | Override model |
| `context` | No | `fork` for subagent execution |
| `agent` | No | Subagent type for `context: fork` |
| `hooks` | No | Skill-scoped hooks |

---

## Skill Types

### Reference Content

Knowledge Claude applies to current work:

```markdown
---
name: api-conventions
description: API design patterns for this codebase
---

When writing API endpoints:
- Use RESTful naming conventions
- Return consistent error formats
- Include request validation
- Document with JSDoc
```

**Use**: Conventions, patterns, style guides

---

### Task Content

Step-by-step instructions for actions:

```markdown
---
name: deploy
description: Deploy to production
disable-model-invocation: true
---

Deploy the application:
1. Run the test suite: npm test
2. Build the application: npm run build
3. Push to deployment target: npm run deploy
4. Verify health checks pass
```

**Use**: Deployments, commits, code generation

---

## String Substitutions

Skills support dynamic values:

| Variable | Description |
|----------|-------------|
| `$ARGUMENTS` | All arguments |
| `$1`, `$2`, etc. | Positional arguments |

**Example**:
```markdown
---
name: create-component
---
Create a React component named $1 in directory $2.
```

**Usage**: `/create-component Button components/`

---

## Example Skills

### Git Release

```markdown
---
name: git-release
description: Create consistent releases and changelogs
---

## What I do
- Draft release notes from merged PRs
- Propose semver version bump
- Provide copy-pasteable release command

## When to use
Preparing a tagged release

## Steps
1. Get last tag: `git describe --tags --abbrev=0`
2. List merged PRs: `git log --merges HEAD...<last-tag>`
3. Categorize:
   - Features → minor bump
   - Fixes → patch bump
   - Breaking → major bump
4. Draft release notes
5. Propose version
6. Provide `gh release create` command
```

### API Testing

```markdown
---
name: api-testing
description: Write comprehensive API tests
allowed-tools: Read, Write, Bash
---

Write tests for API endpoints:

1. Test each endpoint with:
   - Valid input (200 OK)
   - Invalid input (400 Bad Request)
   - Auth errors (401/403)
   - Not found (404)
2. Mock external dependencies
3. Use descriptive test names
4. Group with describe blocks
```

### Code Review

```markdown
---
name: code-review
description: Review code for quality issues
disable-model-invocation: true
---

Review code for:

- [ ] Style guide compliance
- [ ] Function size (keep small)
- [ ] Descriptive variable names
- [ ] Comprehensive error handling
- [ ] Edge case coverage
- [ ] No hardcoded secrets
- [ ] Input validation

For each issue:
1. **File:Line** - Location
2. **Severity** - Critical/High/Medium/Low
3. **Issue** - Description
4. **Suggestion** - Fix
```

---

## Best Practices

1. **Clear descriptions**: Help Claude know when to use
2. **Specific scope**: One skill = one responsibility
3. **Concrete examples**: Show expected format
4. **Use `disable-model-invocation`**: For manual-only workflows
5. **Document prerequisites**: Required tools, environment
6. **Include templates**: For consistent output

---

*Last Updated: March 1, 2026*
