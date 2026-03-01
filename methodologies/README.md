# Agent Orchestration Methodologies

*Practical guides for long-running autonomous agent sessions*

---

## Overview

This directory contains detailed implementation guides for methodologies that enable AI agents to work autonomously over extended periods across context boundaries.

Each methodology is designed to be:
- **Practical**: Can be implemented today with available tools
- **Composable**: Can be combined with other methodologies
- **Measurable**: Has clear success criteria
- **Tool-agnostic**: Concepts apply across OpenCode, Claude Code, and other agents

---

## Methodology Index

| # | Methodology | Core Concept | Best For | Complexity |
|---|-------------|--------------|----------|------------|
| 01 | [Ralph Loops](01-ralph-loops.md) | Persistent re-prompting | Single long tasks | Low |
| 02 | [Spec-Driven Development](02-spec-driven-development.md) | Specification-first | Complex features | Medium |
| 03 | [Agent Teams](03-agent-teams.md) | Multi-agent orchestration | Parallel work | High |
| 04 | [Context Management](04-context-management.md) | Context optimization | Long sessions | Medium |
| 05 | [Session Teleportation](05-session-teleportation.md) | Cross-device sessions | Mobile workflows | Low |

---

## Quick Start

### For a Simple Task (1-2 hours)

Use: **Ralph Loops** or **Spec-Driven Development**

```bash
# Ralph Loop
opencode run --continue "Implement feature X"

# Or with spec
opencode run "Read SPEC.md and implement all requirements"
```

### For a Complex Feature (4-8 hours)

Use: **Spec-Driven Development** + **Context Management**

```bash
# 1. Create spec
opencode run "Create SPEC.md for feature X"

# 2. Review and refine
opencode  # Interactive mode

# 3. Implement with checkpointing
# Enable auto-compaction in opencode.json
opencode run "Implement feature per SPEC.md"
```

### For a Large Project (Multi-day)

Use: **Agent Teams** + **Spec-Driven Development** + **Context Management**

```bash
# 1. Setup
mkdir -p team_chat/{instructions,claims,progress}
opencode serve &

# 2. Create spec
opencode run "Create comprehensive SPEC.md"

# 3. Launch team
for agent in planner worker-1 worker-2 reviewer; do
  opencode attach http://localhost:4096 --session "$agent" &
done

# 4. Monitor
# Use Session Teleportation to check progress from anywhere
```

---

## Methodology Comparison

### When to Use What

```
┌─────────────────────────────────────────────────────────────┐
│                    DECISION TREE                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Is this a single focused task?                             │
│  ├── YES → Ralph Loops                                     │
│  │                                                             │
│  └── NO → Do you need multiple people/agents?              │
│      ├── YES → Agent Teams                                 │
│      │                                                         │
│      └── NO → Do you have clear requirements?              │
│          ├── YES → Spec-Driven Development                 │
│          │                                                     │
│          └── NO → Start with brainstorming, then SDD       │
│                                                             │
│  For all of the above:                                      │
│  - Context Management for sessions > 1 hour                │
│  - Session Teleportation if switching devices              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Compatibility Matrix

| Methodology | Ralph Loops | Spec-Driven | Agent Teams | Context Mgmt | Teleportation |
|-------------|-------------|-------------|-------------|--------------|---------------|
| Ralph Loops | — | ✅ | ✅ | ✅ | ✅ |
| Spec-Driven | ✅ | — | ✅ | ✅ | ✅ |
| Agent Teams | ✅ | ✅ | — | ✅ | ✅ |
| Context Mgmt | ✅ | ✅ | ✅ | — | ✅ |
| Teleportation | ✅ | ✅ | ✅ | ✅ | — |

All methodologies are designed to work together.

---

## Implementation Checklist

### Before Starting

- [ ] Choose appropriate methodology(ies)
- [ ] Set up project structure
- [ ] Configure context management
- [ ] Define completion criteria

### During Execution

- [ ] Monitor context usage
- [ ] Create regular checkpoints
- [ ] Update progress files
- [ ] Handle errors gracefully

### After Completion

- [ ] Verify against spec/requirements
- [ ] Update documentation
- [ ] Archive session notes
- [ ] Review lessons learned

---

## Common Patterns

### Pattern 1: The Full Stack

```
Spec-Driven Development
    ↓
Agent Teams (for parallel work)
    ↓
Ralph Loops (within each agent)
    ↓
Context Management (throughout)
    ↓
Session Teleportation (for monitoring)
```

### Pattern 2: The Solo Developer

```
Spec-Driven Development
    ↓
Context Management
    ↓
Session Teleportation (review on phone/tablet)
```

### Pattern 3: The Quick Fix

```
Ralph Loops (simple, focused task)
    ↓
Context Management (if task grows)
```

---

## Measuring Success

### Metrics for Long-Running Sessions

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Task completion rate | > 90% | Completed / Started |
| Context efficiency | < 60% | opencode status |
| Time to resume | < 5 min | After interruption |
| Accuracy vs spec | > 95% | Requirements met |
| Manual intervention | < 10% | Human steps / Total steps |

### Red Flags

- Context consistently over 80%
- Multiple session restarts for same task
- Agent making contradictory changes
- Tasks abandoned mid-implementation

---

## Troubleshooting Guide

### Agent keeps trying to exit

→ Use **Ralph Loops** with clear completion criteria

### Context window keeps filling up

→ Apply **Context Management** techniques

### Task too complex for one agent

→ Switch to **Agent Teams** with task decomposition

### Need to switch devices mid-task

→ Enable **Session Teleportation**

### Requirements unclear

→ Start with **Spec-Driven Development** planning phase

---

## Resources

### Primary Sources

- [Anthropic Research - Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Claude Code Documentation](https://code.claude.com/docs)
- [OpenCode Documentation](https://opencode.ai/docs)

### Community Resources

- [Reddit r/ClaudeAI](https://www.reddit.com/r/ClaudeAI/)
- [Hacker News](https://news.ycombinator.com/)
- [AI Engineering Substack](https://brentjohnson.substack.com/)

---

## Contributing

To add a new methodology:

1. Create `XX-methodology-name.md` following the template
2. Update this README
3. Add cross-references in related methodologies
4. Include practical examples

### Methodology Template

```markdown
# Methodology Name

## Overview
Brief description and core concept

## The Problem
What this solves

## The Solution
How it works

## Implementation
Step-by-step guide

## Examples
Real-world use cases

## Best Practices
Do's and don'ts

## References
Sources and further reading
```

---

*Last Updated: March 1, 2026*
