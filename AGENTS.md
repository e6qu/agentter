# Agentter Project Guidelines

*Guidelines for AI agents working on this repository*

---

## Git Workflow

### ⚠️ CRITICAL: Always Create Pull Requests

**NEVER push directly to `main` branch.**

All changes must go through pull requests:

1. **Create a feature branch** from `main`:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** on the feature branch

3. **Commit with clear messages**:
   ```bash
   git add .
   git commit -m "type: Brief description
   
   Longer explanation if needed."
   ```

4. **Push the branch** (NOT to main):
   ```bash
   git push -u origin feature/your-feature-name
   ```

5. **Create a Pull Request** via GitHub CLI or web interface

6. **Wait for review/approval** before merging

### Branch Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/description` | `feature/add-claude-hooks-docs` |
| Bugfix | `fix/description` | `fix/table-formatting` |
| Documentation | `docs/description` | `docs/opencode-skills-guide` |
| Research | `research/description` | `research/mcp-protocol` |

---

## Commit Message Format

Follow conventional commits:

```
type: Subject line (50 chars max)

Body explaining what and why (optional but recommended)

- Bullet points for details
- Another point
```

**Types**:
- `docs:` - Documentation changes
- `fix:` - Bug fixes
- `feat:` - New features
- `research:` - Research additions
- `refactor:` - Code refactoring
- `chore:` - Maintenance tasks

---

## Documentation Standards

### Markdown Tables

All tables MUST have proper separator lines:

```markdown
| Column 1 | Column 2 |
|----------|----------|
| Data 1   | Data 2   |
```

✅ **Correct**: Has `|---|---|` separator
❌ **Incorrect**: Missing separator row

### File Organization

| Directory | Content |
|-----------|---------|
| `opencoder/` | OpenCode-specific documentation |
| `claude-code/` | Claude Code-specific documentation |
| `methodologies/` | General agent methodologies |
| `papers/` | Research paper summaries |
| `tools/` | Individual tool documentation |

---

## Review Checklist

Before requesting review:

- [ ] No direct pushes to `main`
- [ ] All tables properly formatted
- [ ] Links are working
- [ ] Spelling checked
- [ ] Consistent terminology (see TERMINOLOGY.md)
- [ ] Code examples tested (if applicable)

---

## Getting Help

- Check existing documentation first
- Follow patterns from similar files
- Ask for clarification on complex changes

---

*Last Updated: March 1, 2026*
