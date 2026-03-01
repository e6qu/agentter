# OpenCode Skills

*Creating and using reusable SKILL.md definitions*

---

## Overview

**Skills** in OpenCode are reusable instructions defined in `SKILL.md` files that agents can discover and load on-demand. They allow you to codify domain knowledge, workflows, and best practices.

**Key Concept**: Skills are loaded lazily—agents see available skills but only load the full content when needed via the `skill` tool.

---

## Skill Structure

A skill consists of a directory containing a `SKILL.md` file:

```
skills/
└── git-release/
    └── SKILL.md
```

### SKILL.md Format

```markdown
---
name: git-release
description: Create consistent releases and changelogs
license: MIT
compatibility: opencode
metadata:
  audience: maintainers
  workflow: github
---

## What I do
- Draft release notes from merged PRs
- Propose a version bump
- Provide a copy-pasteable `gh release create` command

## When to use me
Use this when you are preparing a tagged release.
Ask clarifying questions if the target versioning scheme is unclear.

## Steps
1. List merged PRs since last tag
2. Categorize changes (features, fixes, breaking)
3. Draft release notes
4. Propose version based on semver
5. Provide release command
```

---

## Frontmatter Fields

### Required Fields

#### `name`

The skill identifier. Must:
- Be 1-64 characters
- Be lowercase alphanumeric with single hyphens
- Not start/end with `-`
- Not contain consecutive `--`
- Match the directory name

**Valid**: `git-release`, `api-testing`, `docs-review`
**Invalid**: `GitRelease`, `api--testing`, `-docs-review`

#### `description`

Brief description (1-1024 characters) of what the skill does.

Used by agents to decide when to load the skill.

```yaml
---
description: Create consistent releases and changelogs following semver
---
```

---

### Optional Fields

#### `license`

SPDX license identifier.

```yaml
---
license: MIT
---
```

#### `compatibility`

Tools compatible with this skill.

```yaml
---
compatibility: opencode  # or "claude", "codex", etc.
---
```

#### `metadata`

Custom key-value pairs for additional context.

```yaml
---
metadata:
  audience: maintainers
  workflow: github
  category: devops
---
```

---

## Skill Discovery

### Search Locations

OpenCode searches for skills in these directories (in order):

**Project-local** (walks up from cwd to git root):
1. `.opencode/skills/<name>/SKILL.md`
2. `.claude/skills/<name>/SKILL.md`
3. `.agents/skills/<name>/SKILL.md`

**Global**:
1. `~/.config/opencode/skills/<name>/SKILL.md`
2. `~/.claude/skills/<name>/SKILL.md`
3. `~/.agents/skills/<name>/SKILL.md`

### Discovery Process

1. OpenCode scans all skill locations
2. Loads `name` and `description` from frontmatter
3. Presents available skills to agent:

```xml
<available_skills>
  <skill>
    <name>git-release</name>
    <description>Create consistent releases and changelogs</description>
  </skill>
  <skill>
    <name>api-testing</name>
    <description>Write comprehensive API tests</description>
  </skill>
</available_skills>
```

---

## Loading Skills

Agents load skills using the `skill` tool:

```javascript
skill({ name: "git-release" })
```

Once loaded:
- Full SKILL.md content is added to context
- Agent can reference the skill's instructions
- Skill remains loaded for the session

---

## Creating Skills

### Step 1: Create Directory

```bash
mkdir -p .opencode/skills/my-skill
```

### Step 2: Write SKILL.md

```markdown
---
name: my-skill
description: What this skill does
---

## Purpose
Explain what this skill helps with.

## When to use
Describe situations where this skill applies.

## Instructions
Detailed steps or guidelines.

## Examples
Concrete examples of usage.
```

### Step 3: Verify Loading

```bash
opencode
# Ask: "What skills are available?"
```

---

## Skill Permissions

Control which skills agents can access in `opencode.json`:

```json
{
  "permission": {
    "skill": {
      "*": "allow",           // Default: allow all
      "pr-review": "allow",   // Explicit allow
      "internal-*": "deny",   // Deny internal skills
      "experimental-*": "ask" // Ask before loading
    }
  }
}
```

### Permission Levels

| Level | Behavior |
|-------|----------|
| `allow` | Skill loads immediately |
| `deny` | Hidden from agent, access rejected |
| `ask` | User prompted for approval |

### Pattern Matching

Use wildcards for grouping:
- `internal-*`: Matches `internal-docs`, `internal-tools`
- `*-testing`: Matches `api-testing`, `e2e-testing`

---

## Per-Agent Permissions

Override global permissions for specific agents.

**In agent frontmatter** (markdown):
```markdown
---
permission:
  skill:
    "documents-*": "allow"
---
```

**In opencode.json** (built-in agents):
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

## Disabling Skills

Completely disable skills for an agent:

**In agent frontmatter**:
```markdown
---
tools:
  skill: false
---
```

**In opencode.json**:
```json
{
  "agent": {
    "plan": {
      "tools": {
        "skill": false
      }
    }
  }
}
```

When disabled, `<available_skills>` is omitted from context.

---

## Skill Examples

### Example 1: Git Release

**File**: `.opencode/skills/git-release/SKILL.md`

```markdown
---
name: git-release
description: Create consistent releases and changelogs
license: MIT
metadata:
  category: devops
---

## What I do
- Draft release notes from merged PRs
- Propose a version bump based on semver
- Provide a copy-pasteable `gh release create` command

## When to use me
Use this when you are preparing a tagged release.
Ask clarifying questions if the target versioning scheme is unclear.

## Steps
1. Get the last tag: `git describe --tags --abbrev=0`
2. List merged PRs since last tag: `git log --merges HEAD...<last-tag>`
3. Categorize changes:
   - Features → minor version bump
   - Fixes → patch version bump
   - Breaking → major version bump
4. Draft release notes with categories
5. Propose next version
6. Provide release command

## Output format
```
## Proposed Version: X.Y.Z

### Features
- PR #123: Description

### Fixes
- PR #124: Description

### Release command:
gh release create vX.Y.Z --notes "..."
```
```

---

### Example 2: API Testing

**File**: `.opencode/skills/api-testing/SKILL.md`

```markdown
---
name: api-testing
description: Write comprehensive API tests
license: MIT
metadata:
  category: testing
  framework: jest
---

## What I do
- Write unit tests for API endpoints
- Mock external dependencies
- Test success and error cases
- Validate response schemas

## When to use me
When you need to add tests for REST API endpoints.

## Guidelines
1. Test each endpoint with:
   - Valid input (200 OK)
   - Invalid input (400 Bad Request)
   - Authentication errors (401/403)
   - Not found (404)
2. Mock database and external services
3. Use descriptive test names
4. Group related tests with describe blocks

## Example structure
```typescript
describe('POST /api/users', () => {
  it('creates a new user with valid data', async () => {});
  it('returns 400 with invalid email', async () => {});
  it('returns 409 if email exists', async () => {});
});
```
```

---

### Example 3: Code Review

**File**: `.opencode/skills/code-review/SKILL.md`

```markdown
---
name: code-review
description: Review code for quality and best practices
license: MIT
metadata:
  category: quality
---

## What I do
- Review code for quality issues
- Check for security vulnerabilities
- Verify test coverage
- Suggest improvements

## Review checklist
- [ ] Code follows project style guide
- [ ] Functions are small and focused
- [ ] Variable names are descriptive
- [ ] Error handling is comprehensive
- [ ] Tests cover edge cases
- [ ] No hardcoded secrets
- [ ] No SQL injection risks
- [ ] Input is validated

## Output format
For each issue:
1. **File:Line**: Location
2. **Severity**: Critical/High/Medium/Low
3. **Issue**: Description
4. **Suggestion**: How to fix
```

---

### Example 4: Documentation

**File**: `.opencode/skills/documentation/SKILL.md`

```markdown
---
name: documentation
description: Write clear technical documentation
license: MIT
metadata:
  category: docs
---

## What I do
- Write README files
- Document APIs
- Add code comments
- Create usage guides

## Guidelines
1. Start with "Why" - explain purpose
2. Include installation instructions
3. Provide code examples
4. Document all parameters
5. Include error scenarios

## Style
- Use clear, concise language
- Active voice
- Short sentences
- Code blocks for examples
```

---

## Troubleshooting

### Skill not showing up

**Check**:
1. `SKILL.md` is in ALL CAPS
2. File is in correct location: `skills/<name>/SKILL.md`
3. Frontmatter has `name` and `description`
4. `name` matches directory name
5. No syntax errors in frontmatter

### Skill name conflicts

Skills must have unique names across all locations. If duplicates exist:
- First found wins (based on search order)
- Check with: "What skills are available?"

### Permissions not working

**Verify**:
1. JSON syntax in `opencode.json`
2. Permission path: `permission.skill.<pattern>`
3. Agent-specific permissions override global

---

## Best Practices

1. **Clear descriptions**: Help agents choose the right skill
2. **Specific scope**: One skill = one responsibility
3. **Concrete examples**: Show expected inputs/outputs
4. **Version compatibility**: Note which tools it works with
5. **Document prerequisites**: Required tools, files, environment
6. **Use metadata**: Categorize for organization

---

## Sharing Skills

### Within Team

Check skills into version control:
```
.opencode/skills/
├── git-release/
├── api-testing/
└── deployment/
```

### As NPM Package

Publish reusable skills:
```bash
npm publish @myorg/opencode-skills
```

### Community

Share on:
- GitHub Gists
- Skill marketplaces
- Team wikis

---

*Last Updated: March 1, 2026*
