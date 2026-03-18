# Session Teleportation

*Moving work seamlessly between devices and interfaces*

---

## Overview

Session Teleportation allows you to start work in one place (terminal), continue in another (web browser), switch to a third (mobile), and resume seamlessly. This is essential for long-running projects that span days and devices.

> **Note:** This document describes both **currently available** features and **aspirational/future** capabilities. Features marked with "(Future)" or "(Experimental)" do not exist in current tools and represent design patterns the ecosystem is moving toward. Currently available session continuity is limited to:
> - Claude Code: `--continue` / `--resume` flags for resuming sessions on the same machine
> - OpenCode: Session export/import via JSON files
> - Git-based state: CLAUDE.md / AGENTS.md files persist context across sessions

---

## The Problem

Traditional workflow:
```
Work on laptop -> Go home -> Try to remember state -> Re-explain to new session -> Lost time
```

With Session Teleportation:
```
Work on laptop -> Teleport session to phone -> Review on commute -> Teleport to desktop -> Continue seamlessly
```

---

## Core Concepts

### Session Persistence

Sessions are stored server-side, not locally:

```
┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│   Laptop     │◄────▶│   Server     │◆────▶│    Phone     │
│   Terminal   │      │  (opencode   │      │   Browser    │
└──────────────┘      │   server)    │      └──────────────┘
                      └──────────────┘
                           ▲
                      ┌──────────────┐
                      │    iPad      │
                      └──────────────┘
```

### State Synchronization

What gets synchronized:
- Conversation history
- File modifications
- Tool outputs
- Working directory state
- Environment variables

---

## What Works Today

The features in this section are available now with current tooling.

### Starting a Teleportable Session

```bash
# Option 1: Built-in persistence
opencode serve  # Start server
# Sessions automatically persist to server

# Option 2: Cloud sync
opencode --sync=cloud
# Sessions sync to OpenCode cloud
```

### Teleporting Between Interfaces

```bash
# Terminal: Start work
opencode
> Implementing feature X...
> Made changes to src/feature.ts

# Generate share link
> /share
Share link: https://opencode.ai/s/abc123

# On phone: Open link in browser
# Full session state available
# Can review, comment, approve

# On desktop: Continue work
opencode resume abc123
# Pick up exactly where you left off
```

### Session Export/Import

```bash
# Export session for offline transfer
opencode export <session-id> > my-session.json

# Transfer file to another machine (USB, cloud, etc.)

# Import on target machine
opencode import my-session.json
```

---

## Use Cases

### Use Case 1: Commute Review

```
9:00 AM - Office
  Terminal: "Implement user authentication"
  Made progress, need to pause

  > /share
  Link: https://opencode.ai/s/auth-456

6:00 PM - Train home
  Phone browser: Open link
  Review code changes
  Add comments/questions

8:00 PM - Home
  Desktop: opencode resume auth-456
  See phone comments
  Continue implementation
```

### Use Case 2: Collaboration

```
Developer A:
  opencode
  > Working on complex algorithm
  > Stuck on edge case
  > /share with Developer B

Developer B (different timezone):
  Opens share link
  Reviews the code
  Suggests fix in comments

Developer A (next morning):
  Sees suggestion
  Implements fix
  > /close-share
```

### Use Case 3: Presentation Mode

```
Before meeting:
  opencode
  > Complete feature implementation
  > /share --readonly

In meeting:
  Project browser with share link
  Walk through changes
  Stakeholders review

After meeting:
  Close share link
  Merge changes
```

---

## Experimental / Aspirational Features

> **These features are aspirational designs that do not yet exist in current tools.** They represent patterns that would be valuable if implemented.

### Session Branching (Experimental)

Session branching would allow you to fork a session to try an alternative approach without losing your current progress. This concept is inspired by git branching but applied to conversation and agent state.

```bash
# Concept: Branch a session to experiment
opencode branch main experiment
> Try alternative approach
> If it works: opencode merge experiment main
> If not: opencode delete experiment
```

**Status**: Not widely supported. Some tools offer session duplication, but true branching with merge support is not yet available.

### Session Snapshots (Experimental)

Named checkpoints within a session that you can restore to, similar to VM snapshots.

```bash
# Concept: Create a named checkpoint
opencode snapshot "Before refactoring"

# Work, make changes

# Restore to checkpoint
opencode restore "Before refactoring"
```

**Status**: Basic session persistence exists, but named snapshot/restore within a session is not yet a standard feature. Use git commits as a practical alternative.

### Selective Sync (Experimental)

```bash
# Sync only conversation, not files
opencode --sync=conversation

# Sync files but not environment
opencode --sync=files

# Full sync
opencode --sync=all
```

**Status**: Most tools sync all-or-nothing. Granular sync control is a planned feature in some tools.

---

## Security Considerations

### Share Links

```bash
# Default: Expires in 24h
opencode /share

# Custom expiration
opencode /share --expires=7d

# Password protected
opencode /share --password

# Read-only
opencode /share --readonly

# Revoke early
opencode /unshare <link-id>
```

### Data Privacy

```bash
# Local-only mode (no cloud)
opencode --local

# End-to-end encryption
opencode --encrypt

# Self-hosted server
opencode serve --self-hosted
```

---

## Configuration

### Server Settings

```json
// opencode.json
{
  "server": {
    "enabled": true,
    "port": 4096,
    "host": "0.0.0.0",
    "persistence": "disk",
    "sync": {
      "enabled": true,
      "interval": 30
    }
  },

  "sharing": {
    "defaultExpiry": "24h",
    "maxExpiry": "30d",
    "requireAuth": true
  }
}
```

### Client Settings

```json
{
  "client": {
    "autoSync": true,
    "offlineMode": "cache",
    "defaultInterface": "auto"
  }
}
```

---

## Best Practices

### DO

- **Use descriptive session names**: `auth-implementation` not `session-1`
- **Snapshot before big changes**: Easy rollback (use git commits as a practical alternative today)
- **Set appropriate share permissions**: Read-only for reviews
- **Close shares when done**: Clean up access
- **Sync before switching devices**: Ensure latest state

### DON'T

- **Don't leave shares open indefinitely**: Security risk
- **Don't sync sensitive data unencrypted**: Use --encrypt
- **Don't forget to checkpoint**: You'll want to rollback eventually
- **Don't mix personal and work sessions**: Keep separate

---

## Troubleshooting

### Issue: Session out of sync

```bash
# Force full sync
opencode sync --force

# Check for conflicts
opencode conflicts

# Resolve manually
opencode resolve <file>
```

### Issue: Can't resume session

```bash
# List available sessions
opencode session list

# Check if session exists on server
opencode session status <id>

# Restore from export
opencode import backup.json
```

### Issue: Share link not working

```bash
# Check expiration
opencode shares

# Regenerate
opencode /share --regenerate

# Check permissions
opencode share-info <link-id>
```

---

## Cross-References

- [01 - Ralph Loops](01-ralph-loops.md): Teleport a long-running Ralph Loop session to another device for monitoring.
- [02 - Spec-Driven Development](02-spec-driven-development.md): Share spec review sessions with collaborators for feedback.
- [03 - Agent Teams](03-agent-teams.md): Team members can monitor agent progress from any device via session sharing.
- [04 - Context Management](04-context-management.md): Compact context before teleporting to minimize transfer overhead and ensure a clean session on the target device.
- [METHODOLOGIES.md](../METHODOLOGIES.md): Overview of all methodologies.

---

## Integration with Other Methodologies

### Session Teleportation + Context Management

```
┌─────────────────────────────────────────────────────────────┐
│                    WORKFLOW                                  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Terminal: opencode                                          │
│  > Work for 2 hours                                          │
│  > /compact (optimize context)                               │
│  > Update memory.md                                          │
│  > /share                                                    │
│                                                             │
│  [Teleport to phone]                                        │
│                                                             │
│  Phone: Review compacted session                            │
│  > Add comments                                              │
│                                                             │
│  [Teleport to desktop]                                      │
│                                                             │
│  Desktop: opencode resume                                    │
│  > Read memory.md                                            │
│  > Continue work                                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Session Teleportation + Agent Teams

```
Agent 1 (Laptop): Working on backend
  > /share

Agent 2 (Desktop): Working on frontend
  > opencode attach --session agent-1
  > Coordinate via shared session

Agent 3 (Cloud): Reviewer
  > Access via web interface
  > Leave review comments
```

---

## Future Directions

> **Note**: These are speculative ideas about where session teleportation could go. None of these are implemented or available today.

### VR/AR Interfaces (Future)

Immersive visualization of codebases could allow spatial navigation of architecture, with the ability to teleport back to traditional interfaces for implementation.

```
VR headset: 3D visualization of codebase
  > Navigate architecture
  > Make changes with gestures
  > Teleport to desktop for implementation
```

### Voice Integration (Future)

Voice-based session interaction could enable hands-free review and task management during commutes or other activities.

```
Car: Voice interface
  "Review my open session"
  "What did I work on yesterday?"
  "Add a todo for when I get home"
```

---

## References

- [Claude Code Sessions](https://docs.anthropic.com/en/docs/claude-code/en/sessions)
- [Reddit - Multi-Device Workflow](https://www.reddit.com/r/ClaudeAI/)

---

*Last Updated: March 18, 2026*
