# Spec-Driven Development (SDD)

*A systematic approach to AI-assisted development with clear specifications*

---

## Overview

Spec-Driven Development is the evolution from "vibe coding" (prompting and praying) to structured development where specifications drive implementation. The key insight: spending 10-20% more time upfront on specification saves 50%+ time in implementation and debugging.

---

## The SDD Workflow

```
┌─────────────────────────────────────────────────────────────┐
│                  SPEC-DRIVEN DEVELOPMENT                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐                                           │
│  │  Problem     │                                           │
│  │  Statement   │                                           │
│  └──────┬───────┘                                           │
│         ▼                                                   │
│  ┌──────────────┐    ┌──────────────┐                      │
│  │  Brainstorm  │───▶│  Iterative   │                      │
│  │  with AI     │    │  Refinement  │                      │
│  └──────┬───────┘    └──────┬───────┘                      │
│         │                   ▼                               │
│         │            ┌──────────────┐                      │
│         │            │  Questions   │                      │
│         │            │  Answered    │                      │
│         │            └──────┬───────┘                      │
│         └───────────────────┘                               │
│                             ▼                               │
│                    ┌──────────────┐                        │
│                    │  Spec.md     │                        │
│                    │  Created     │                        │
│                    └──────┬───────┘                        │
│                           ▼                                 │
│              ┌────────────────────────┐                    │
│              │  Implementation Plan   │                    │
│              │  (Bite-sized Tasks)    │                    │
│              └───────┬────────────────┘                    │
│                      ▼                                      │
│              ┌──────────────┐    ┌──────────────┐         │
│              │  Execute     │───▶│  Verify      │         │
│              │  Task 1      │    │  vs Spec     │         │
│              └──────┬───────┘    └──────┬───────┘         │
│                     │                   │                   │
│                     └───────────────────┘                   │
│                                         ▼                   │
│                              ┌──────────────┐              │
│                              │  Complete?   │              │
│                              └──────┬───────┘              │
│                                     │                       │
│                          No ────────┴─────── Yes           │
│                               ┌─────┐                       │
│                               ▼     ▼                       │
│                        ┌────────┐  └────▶ Done             │
│                        │ Next   │                         │
│                        │ Task   │                         │
│                        └────────┘                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Brainstorming

### Starting the Conversation

```markdown
# Initial Prompt

I'm planning to build [FEATURE]. Help me think through:

1. What are the core requirements?
2. What are the edge cases?
3. What technologies should I consider?
4. What are potential pitfalls?
5. How should I structure this?
```

### Iterative Refinement

The key is asking follow-up questions until you fully understand:

```
User: "I want a user authentication system"
AI: "What kind? Email/password, OAuth, SSO?"
User: "Email/password with optional 2FA"
AI: "What 2FA methods? SMS, TOTP, hardware keys?"
User: "TOTP for now"
AI: "Password requirements? Strength validation?"
...
```

Continue until you've covered:
- Functional requirements
- Non-functional requirements
- Edge cases
- Error handling
- Security considerations
- Performance requirements

---

## Phase 2: Specification Document

### SPEC.md Template

```markdown
# Specification: [Feature Name]

## Overview
Brief description of what this feature does and why it exists.

## Requirements

### Functional Requirements
1. REQ-001: Users can register with email/password
2. REQ-002: Passwords must be at least 12 characters
3. REQ-003: Users can enable TOTP 2FA
...

### Non-Functional Requirements
- Performance: Login < 200ms
- Security: OWASP compliance
- Availability: 99.9% uptime

## Architecture

### Data Models
```typescript
interface User {
  id: string;
  email: string;
  passwordHash: string;
  twoFactorSecret?: string;
  createdAt: Date;
}
```

### API Endpoints
| Method | Path | Description |
|--------|------|-------------|
| POST | /api/auth/register | Create account |
| POST | /api/auth/login | Authenticate |
| POST | /api/auth/2fa/setup | Enable 2FA |

## Implementation Plan

### Phase 1: Core Authentication
- [ ] Database schema
- [ ] Registration endpoint
- [ ] Login endpoint
- [ ] Password hashing

### Phase 2: Security
- [ ] Rate limiting
- [ ] Input validation
- [ ] Error handling

### Phase 3: 2FA
- [ ] TOTP generation
- [ ] QR code display
- [ ] Verification endpoint

## Testing Strategy
- Unit tests for all endpoints
- Integration tests for flows
- Security audit checklist

## Acceptance Criteria
- [ ] All requirements implemented
- [ ] All tests passing
- [ ] Security review complete
- [ ] Documentation updated
```

---

## Phase 3: Implementation Plan

### Breaking Down Work

Each implementation phase should be:
- **Self-contained**: Can be completed independently
- **Testable**: Has clear success criteria
- **Small**: Takes 1-2 hours max
- **Ordered**: Dependencies respected

### Example Plan

```markdown
## Implementation Plan: User Authentication

### Task 1: Database Setup (Est: 30 min)
**Goal**: Create users table with proper schema
**Files**: `migrations/001_users.sql`, `src/models/user.ts`
**Acceptance**: 
- Migration runs successfully
- Model type-checks
- Tests pass

### Task 2: Registration Endpoint (Est: 45 min)
**Goal**: POST /api/auth/register working
**Files**: `src/routes/auth.ts`, `src/services/auth.ts`
**Acceptance**:
- Can create user via API
- Passwords are hashed (bcrypt)
- Duplicate email handled
- Tests pass

### Task 3: Login Endpoint (Est: 45 min)
**Goal**: POST /api/auth/login working
**Files**: `src/routes/auth.ts`, `src/services/auth.ts`
**Acceptance**:
- Valid credentials return token
- Invalid credentials return 401
- Rate limited (5 attempts/min)
- Tests pass

[Continue for all tasks...]
```

---

## Phase 4: Execution

### OpenCode Workflow

```bash
# Step 1: Create comprehensive spec
opencode run "Create SPEC.md for user authentication system. Include requirements, architecture, data models, API endpoints, and implementation phases."

# Step 2: Review and refine
opencode
# > Read SPEC.md
# > Ask questions, refine requirements
# > Update SPEC.md

# Step 3: Generate implementation plan
# > Based on SPEC.md, create detailed implementation plan

# Step 4: Execute tasks one at a time
opencode run "Implement Task 1 from IMPLEMENTATION.md: Database Setup"

# Step 5: Verify
opencode run "Verify Task 1 complete per SPEC.md section 3.1. Run tests."

# Step 6: Continue to next task
opencode run "Implement Task 2 from IMPLEMENTATION.md: Registration Endpoint"
```

### Plan vs Build Mode

In OpenCode:

```
# Tab key switches modes

PLAN MODE:
- Read-only analysis
- Generate plans
- Research approaches
- Cannot modify files

BUILD MODE:
- File modifications allowed
- Execute commands
- Run tests
- Implement features
```

Best practice:
1. Use PLAN mode to analyze SPEC.md
2. Generate implementation approach
3. Switch to BUILD mode
4. Execute one task at a time
5. Verify against spec
6. Repeat

---

## Verification Strategies

### Automated Verification

```bash
# Create verify.sh
#!/bin/bash

# Check all requirements implemented
grep -r "REQ-" src/

# Run tests
npm test

# Check coverage
npm run test:coverage

# Lint
npm run lint

# Type check
npm run typecheck
```

### Manual Review Checklist

```markdown
## Pre-Completion Review

- [ ] All functional requirements implemented
- [ ] All non-functional requirements met
- [ ] Edge cases handled
- [ ] Error messages are user-friendly
- [ ] No TODO comments remaining
- [ ] Documentation is complete
- [ ] API responses match spec
- [ ] Security best practices followed
```

---

## Common Pitfalls

### DO NOT

1. **Skip the spec phase**: "I'll just start coding"
   - Result: Rewrite, confusion, bugs

2. **Make specs too large**: "Implement the entire system"
   - Result: Agent loses track, incomplete work

3. **Skip verification**: "Looks good to me"
   - Result: Missing requirements, bugs

4. **Mix concerns**: "Implement auth AND refactor database"
   - Result: Context overflow, mistakes

### DO

1. **Be specific**: "Hash passwords with bcrypt, cost factor 12"
2. **Iterate**: Revise spec as understanding grows
3. **Keep tasks small**: 1-2 hours per task max
4. **Verify at each step**: Don't batch verification

---

## Example: Complete SDD Session

```bash
# 1. Start OpenCode
opencode

# 2. In PLAN mode, brainstorm
"I want to add a search feature to my blog. Help me think through requirements."

# 3. AI asks questions, you answer
# 4. Generate SPEC.md
"Based on our discussion, create a comprehensive SPEC.md for the search feature."

# 5. Review SPEC.md, refine
"Update SPEC.md to include PostgreSQL full-text search instead of Elasticsearch"

# 6. Create implementation plan
"Create IMPLEMENTATION.md with bite-sized tasks"

# 7. Switch to BUILD mode
# 8. Execute tasks
"Implement Task 1: Database migration for search index"

# 9. Verify
"Run tests and verify Task 1 complete"

# 10. Continue
"Implement Task 2: Search API endpoint"

# ... until complete
```

---

## Integration with Other Methodologies

### SDD + Ralph Loops

Use Ralph loops within SDD for complex tasks:

```bash
# Spec is complete
# Working on Task 5: Complex algorithm

./ralph-loop.sh "Implement algorithm from SPEC.md section 4.2" "SPEC.md"
```

### SDD + Agent Teams

Parallelize independent tasks:

```bash
# Terminal 1: Task 1 (Database)
opencode run "Implement Task 1 per SPEC.md"

# Terminal 2: Task 2 (API) - can be parallel if files don't overlap
opencode run "Implement Task 2 per SPEC.md"
```

---

## References

- [Medium - LLM Coding Workflow 2026](https://medium.com/@addyosmani/my-llm-coding-workflow-going-into-2026-52fe1681325e)
- [OpenCode Documentation - Plan Mode](https://opencode.ai/docs)

---

*Last Updated: March 1, 2026*
