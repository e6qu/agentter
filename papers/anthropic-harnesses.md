# Effective Harnesses for Long-Running Agents

**Authors**: Anthropic Research Team  
**Institution**: Anthropic  
**Published**: November 2025  
**Paper**: [Blog Post](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)  
**Code**: [Agent SDK Quickstart](https://github.com/anthropics/anthropic-quickstarts)

---

## Executive Summary

Anthropic's research on enabling AI agents to work consistently across multiple context windows. The core challenge: agents must work in discrete sessions, but each new session begins with no memory. The solution: a two-part approach with an **initializer agent** that sets up the environment, and **coding agents** that make incremental progress while leaving clear artifacts.

---

## The Long-Running Agent Problem

### The Challenge

```
Session 1:
  Agent works on task...
  Context fills up (200k tokens)
  Session ends

Session 2:
  New agent starts
  No memory of Session 1
  Has to figure out what was done
  Often wastes time or goes wrong direction
```

**Analogy**: Engineers working in shifts where each new engineer arrives with no memory of the previous shift.

### Why Compaction Isn't Enough

Context window compaction helps but doesn't solve:
1. **One-shot attempts**: Agent tries to do too much at once, runs out of context mid-implementation
2. **False completion**: Agent sees progress was made, declares job done prematurely
3. **Lost context**: Compacted context doesn't clearly convey state

---

## The Two-Part Solution

### Part 1: Initializer Agent

**Purpose**: Set up the environment for all future sessions

**What it creates**:

#### 1. Feature Checklist (`features.json`)
```json
[
  {
    "category": "functional",
    "description": "User can create new chat",
    "steps": [
      "Navigate to main interface",
      "Click 'New Chat' button",
      "Verify new conversation created"
    ],
    "passes": false
  },
  {
    "category": "functional", 
    "description": "User can send message",
    "steps": [...],
    "passes": false
  }
  // ... 200+ features
]
```

**Why JSON**: Model less likely to inappropriately change or overwrite JSON vs Markdown.

#### 2. Progress Log (`claude-progress.txt`)
```markdown
# Progress Log

## 2025-11-15 Session 1
- Initialized project structure
- Set up React + TypeScript
- Created component library

## 2025-11-15 Session 2
- Implemented auth flow
- Tests passing

## Current State
- 45/200 features passing
- Next priority: Chat interface
```

#### 3. Initialization Script (`init.sh`)
```bash
#!/bin/bash
# One-command setup for new sessions

git clone [repo]
cd project
npm install
npm run dev  # Start dev server
echo "Environment ready"
```

#### 4. Initial Git Commit
```bash
# Shows what files were added
# Clean starting point
# History of changes
```

### Part 2: Coding Agent

**Purpose**: Make incremental progress in each session

**Prompt structure**:
```
You are continuing work on [PROJECT].

Current state:
- [NUMBER] features passing
- Next priority: [FEATURE]

Your task:
1. Read claude-progress.txt to understand current state
2. Pick ONE feature to implement
3. Implement it completely
4. Test it thoroughly (use browser automation if web app)
5. Update features.json (mark as passing)
6. Update claude-progress.txt with what you did
7. Make a clean git commit

Constraints:
- Work on ONE feature at a time
- Leave code in mergeable state
- Do not remove or edit tests
```

---

## Key Techniques

### 1. Incremental Progress

**Not**: "Build the entire app"

**Yes**: "Implement one feature completely"

**Why**:
- Fits in context window
- Can be tested thoroughly
- Clear when done
- Easy to resume

### 2. Clean State Principle

Code at end of session should be:
- ✓ No major bugs
- ✓ Well-documented
- ✓ Follows project conventions
- ✓ Mergeable to main
- ✓ Next agent can start immediately

### 3. Feature Checklist

**Benefits**:
- Clear definition of "done"
- Progress tracking
- Prevents false completion
- Easy to resume

**Management**:
- Agents only change `passes` field
- Strong prompt: "Unacceptable to remove or edit tests"
- JSON format prevents accidental changes

### 4. Progress Artifacts

Files that track work:
- `claude-progress.txt`: What was done, current state
- `features.json`: What's implemented
- Git history: Code changes
- Test results: Verification

### 5. End-to-End Testing

**Critical**: Must test like a human user

```javascript
// Using Puppeteer MCP server
const screenshot = await browser.goto('http://localhost:3000');
// Analyze screenshot
// Click elements
// Verify behavior
```

**Why**: Unit tests don't catch integration issues

---

## Real-World Example: Building claude.ai Clone

### Session 1: Initialization

```
Initializer Agent:
- Analyzed requirements
- Created 200+ feature specifications
- Set up React + TypeScript project
- Created component structure
- Made initial git commit
- Wrote init.sh script

Output:
├── features.json (200 entries, all "passes: false")
├── claude-progress.txt (template)
├── init.sh
└── [project files]
```

### Session 2-20: Incremental Development

```
Session 2:
- Read progress
- Implemented: New Chat button
- Tests: Pass
- Features: 1/200 passing
- Commit: "Add new chat functionality"

Session 3:
- Read progress  
- Implemented: Chat input
- Tests: Pass
- Features: 2/200 passing
- Commit: "Add chat input component"

...

Session 20:
- Features: 45/200 passing
- All previous features still work
- Clear next priorities
```

---

## Implementation in OpenCode

### Project Structure

```
my-project/
├── features.json           # Feature checklist
├── progress.md            # Progress log
├── init.sh                # Setup script
├── src/
└── tests/
```

### OpenCode Configuration

```json
{
  "agents": {
    "initializer": {
      "system": "You are an initializer agent. Your job is to set up the environment for a long-running project.\n\nCreate:\n1. features.json - comprehensive feature checklist\n2. progress.md - progress tracking template\n3. init.sh - one-command setup\n4. Make initial git commit\n\nAll future agents will rely on these artifacts.",
      "one_time": true
    },
    
    "coder": {
      "system": "You are a coding agent continuing work on a project.\n\nProcess:\n1. Run init.sh to set up environment\n2. Read progress.md to understand current state\n3. Read features.json to see what's needed\n4. Pick ONE feature to implement\n5. Implement it completely\n6. Test thoroughly\n7. Update features.json and progress.md\n8. Git commit\n\nRules:\n- ONE feature per session\n- Leave code clean and working\n- Never remove tests",
      "mode": "iterative"
    }
  }
}
```

### Usage Workflow

```bash
# One-time initialization
opencode run --agent initializer "Set up [PROJECT] with full feature list"

# Iterative development
for i in {1..50}; do
  opencode run --agent coder "Continue implementing features"
done
```

---

## Best Practices

### DO

✓ **Start with comprehensive feature list**
- Prevents scope creep
- Clear definition of done
- Easy to track progress

✓ **One feature per session**
- Fits in context
- Can be tested fully
- Clear stopping point

✓ **Write progress artifacts**
- Next agent knows state
- Can resume anywhere
- Historical record

✓ **Test end-to-end**
- Use browser automation for web apps
- Test like a real user
- Catch integration issues

✓ **Git commit every session**
- Can rollback if needed
- Shows history
- Clean checkpoints

### DON'T

✗ **Try to one-shot the project**
- Will run out of context
- Half-implemented features
- Hard to resume

✗ **Work on multiple features**
- Context pollution
- Harder to test
- Unclear progress

✗ **Skip testing**
- Regressions
- False completion
- Technical debt

✗ **Remove or disable tests**
- "To get it working"
- Leads to broken features

---

## Advanced Patterns

### Pattern 1: Feature Prioritization

```json
{
  "features": [
    {
      "description": "Critical: User login",
      "priority": 1,
      "passes": false
    },
    {
      "description": "Nice to have: Dark mode",
      "priority": 3,
      "passes": false
    }
  ]
}
```

Agent works on priority 1 first.

### Pattern 2: Dependency Tracking

```json
{
  "features": [
    {
      "id": "auth",
      "description": "Authentication",
      "dependencies": [],
      "passes": false
    },
    {
      "id": "profile",
      "description": "User profile",
      "dependencies": ["auth"],
      "passes": false
    }
  ]
}
```

Agent checks dependencies are met first.

### Pattern 3: Session Templates

```markdown
# Session Template

## Pre-Session
- [ ] Run init.sh
- [ ] Read progress.md
- [ ] Check features.json

## During Session
- [ ] Pick one feature
- [ ] Implement
- [ ] Test
- [ ] Update artifacts

## Post-Session
- [ ] Git commit
- [ ] Update progress.md
- [ ] Note next priorities
```

---

## Integration with Other Methodologies

### + Ralph Loops

```
Initializer: Set up project
↓
Ralph Loop (Coding Agent):
  Work on feature
  → Try to exit
  → Hook: Not complete, continue
  → Keep working until done
↓
Next Ralph Loop for next feature
```

### + Agent Teams

```
Initializer: Set up project
↓
Parallel Coding Agents:
  Agent 1: Feature A (frontend)
  Agent 2: Feature B (backend)
  Agent 3: Feature C (auth)
↓
Integrator: Merge and verify
```

### + Spec-Driven Development

```
Human: Create spec
↓
Initializer: Convert spec to features.json
↓
Coding Agents: Implement per spec
↓
Verifier: Check against spec
```

---

## Research Implications

### Key Insights

1. **State management > Context length**: How you manage state matters more than context size
2. **Incremental > Big bang**: Small, complete steps beat large, incomplete ones
3. **Artifacts > Memory**: Files persist better than context
4. **Verification > Trust**: Test everything, trust nothing

### Future Directions

- Automatic feature list generation from specs
- AI-generated initialization scripts
- Self-monitoring agents that know when to checkpoint
- Cross-session learning

---

## Citation

```bibtex
@article{anthropic2025harnesses,
  title={Effective Harnesses for Long-Running Agents},
  author={{Anthropic Research Team}},
  journal={Anthropic Engineering Blog},
  year={2025},
  url={https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents}
}
```

---

*Last Updated: March 1, 2026*
