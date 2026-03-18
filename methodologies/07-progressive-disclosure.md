# Progressive Disclosure: Context Engineering for AI Agents

*The single most important context engineering technique for keeping agents effective over long tasks*

---

## Overview

Progressive disclosure is the practice of providing AI agents with the minimum information needed at each step, revealing more detail only when requested or required. Rather than front-loading the context window with everything an agent might need, progressive disclosure structures information in layers and loads each layer only when the agent's task demands it.

This is the single most important context engineering technique for keeping agents effective over long tasks. Every other technique -- compaction, memory files, session teleportation -- is a workaround for context that should never have been loaded in the first place.

---

## The Problem: Context Pollution

The instinct when working with AI agents is to give them everything: the full codebase, all documentation, every relevant file. This is the "kitchen sink" approach, and it actively degrades performance.

### Why More Context Hurts

- **The "LLMs Get Lost" finding**: Microsoft Research (Laban et al., May 2025) demonstrated a **39% average performance drop** as multi-turn conversations grow. The degradation is primarily driven by increased unreliability, not reduced aptitude -- the model can still reason, but it increasingly fails to attend to the right information.
- **Attention dilution**: Every irrelevant token in the context window competes for attention with relevant tokens. The transformer attention mechanism must distribute its capacity across all tokens, and irrelevant context steals capacity from the information that matters.
- **More context != better results**: This is counterintuitive but well-established. A 200k context window filled to 80% with irrelevant code will underperform a 20k window containing only the relevant function and its dependencies.
- **Context rot compounds**: Each new irrelevant addition slightly degrades attention on everything else. Over a long session, these small degradations compound into significant performance loss.

### The Kitchen Sink Pattern

```
Prompt: "Fix the bug in user authentication"

Kitchen sink approach:
  Load all 47 source files (~150k tokens)
  Load all test files (~80k tokens)
  Load all config files (~20k tokens)
  Load README and docs (~30k tokens)
  → 280k tokens, 95% irrelevant
  → Agent gets confused, makes wrong changes

Progressive disclosure approach:
  Load project structure (~500 tokens)
  Search for auth-related files (~200 tokens)
  Read auth module signatures (~300 tokens)
  Read the specific buggy function (~200 tokens)
  → 1,200 tokens, 90% relevant
  → Agent fixes the bug correctly
```

---

## The Principle

> "Show the map before the territory. Show the territory before the terrain."

Information exists at multiple levels of abstraction. Progressive disclosure means always starting at the highest level and drilling down only when needed. The agent should understand the shape of the system before it sees any code.

### Three Layers

| Layer | What It Provides | Example | Typical Token Cost |
|-------|-----------------|---------|-------------------|
| **Index layer** | What exists | File names, function signatures, module structure | 100-500 tokens |
| **Summary layer** | What it does | Docstrings, type signatures, dependency graphs | 500-2,000 tokens |
| **Detail layer** | How it works | Actual implementation code, full file contents | 2,000-50,000 tokens |

Most agent tasks can be completed by operating primarily at the index and summary layers, dropping to the detail layer only for the specific code being modified.

---

## Techniques

### 1. Structural Overviews First

Before reading any code, the agent should understand the project's shape.

**Repository maps (Aider's approach)**:
Aider uses tree-sitter to parse every file in the repository and extract symbols (functions, classes, methods). It then applies PageRank to rank symbols by importance (how many other symbols reference them). The result is a "repo map" -- a compressed representation of the entire codebase that fits in a few thousand tokens.

```
# Aider's repo map output (simplified)
src/
  auth/
    service.py
      class AuthService
        def authenticate(username, password) -> Token
        def validate_token(token) -> User
        def refresh_token(token) -> Token
    models.py
      class User(BaseModel)
      class Token(BaseModel)
  api/
    routes.py
      def login_route(request) -> Response
      def logout_route(request) -> Response
```

This gives the agent a complete picture of the project in ~200 tokens instead of the ~50,000 tokens required to read every file.

**Other structural overview techniques**:
- Directory listings before file reads
- Class/function signatures before implementations
- Module dependency graphs before code
- `--map-tokens` in Aider controls how much structure is shown (default: 1024 tokens)

### 2. Deferred Tool Loading

Tools consume context. Every tool definition the agent can see takes tokens away from the actual task.

**Claude Code's deferred tools**:
Claude Code defines a small set of core tools (Read, Edit, Bash, Grep, Glob) that are always available. Additional tools (WebSearch, WebFetch, NotebookEdit, etc.) are listed by name only -- their full schemas are loaded only when the agent requests them via `ToolSearch`.

```
Always loaded (core tools):     ~2,000 tokens
Deferred tools (name only):     ~100 tokens
Full deferred tool (on demand): ~300 tokens each

Savings: If 20 tools are deferred, that's ~6,000 tokens saved upfront
```

**The pattern**:
1. Define a small set of essential tools with full schemas
2. List additional tools by name/description only
3. Load full tool schemas on demand when the agent needs them
4. Unload tools that are no longer needed (if the system supports it)

**Why this matters**: An agent with 50 tool definitions loaded consumes ~15,000 tokens just on tool schemas. An agent with 5 core tools and 45 deferred tools consumes ~3,500 tokens. That is 11,500 tokens freed for actual work.

### 3. Layered File Reading

Never read an entire large file when you need one function.

**The anti-pattern**:
```
Agent: "I need to fix the validate_email function"
Action: Read entire utils.py (3,000 lines, ~12,000 tokens)
Result: 95% of tokens wasted on irrelevant utility functions
```

**The progressive pattern**:
```
Step 1: grep "def validate_email" utils.py
  → Line 847: def validate_email(email: str) -> bool:

Step 2: read utils.py lines 847-880
  → Just the function and its immediate context (~200 tokens)

Step 3: (only if needed) read surrounding functions for context
  → Read lines 830-900 for helper functions (~400 tokens)
```

**The general pattern**: `glob -> grep -> read(offset, limit)`

This pattern applies to any file type:
- For config files: search for the relevant key first
- For test files: find the specific test function
- For documentation: find the relevant section header

### 4. Search Before Read

The most efficient way to find information is to search for it, not to read everything looking for it.

**Use grep/ripgrep to find relevant lines BEFORE reading full files**:
```
# Find where authentication errors are handled
grep -rn "AuthenticationError" src/
  → src/auth/service.py:45: raise AuthenticationError("Invalid credentials")
  → src/auth/middleware.py:23: except AuthenticationError as e:
  → src/api/errors.py:12: class AuthenticationError(AppError):

# Now read only the relevant files and lines
read src/auth/service.py:40-55
read src/auth/middleware.py:18-30
```

**Use AST queries to find symbols BEFORE seeing implementation**:
```
# Find all classes that inherit from BaseModel
ast-query "class * (BaseModel)" src/
  → src/models/user.py: class User(BaseModel)
  → src/models/token.py: class Token(BaseModel)
```

**Use LSP to navigate BEFORE pulling source**:
```
# Find all references to a function
lsp-references "validate_token"
  → 7 references across 4 files
  → Read only the files that matter
```

**The pattern**: search -> narrow -> read only what is needed.

### 5. Summary Files as Indexes

Well-structured projects provide natural progressive disclosure through documentation hierarchy.

**Three-level documentation hierarchy**:
```
Level 1: CLAUDE.md / AGENTS.md (project-level summary)
  "This is a REST API for user management. Built with FastAPI, PostgreSQL, Redis."
  "Key directories: src/api/, src/models/, src/services/"
  "Run tests with: pytest"

Level 2: src/api/README.md (directory-level summary)
  "API routes are defined here. Each file handles one resource."
  "Authentication is handled by middleware in src/auth/"

Level 3: src/api/users.py docstrings (file-level summary)
  "CRUD operations for user resources. Depends on UserService."
```

**The pattern**: Agent reads CLAUDE.md -> decides which directory to explore -> reads directory README -> reads specific file docstrings -> reads implementation only if needed.

This is why CLAUDE.md files are so valuable: they serve as the top-level index for progressive disclosure. A well-written CLAUDE.md saves thousands of tokens per session by telling the agent where to look instead of making it search blindly.

### 6. Anthropic's Agent Skills Pattern

In December 2025, Anthropic published a three-layer progressive disclosure pattern for equipping agents with knowledge:

**Layer 1 -- Index (lightweight metadata)**:
```json
{
  "skills": [
    {"title": "Deploy to staging", "type": "runbook", "tokens": 2400},
    {"title": "Database migration", "type": "runbook", "tokens": 1800},
    {"title": "Code style guide", "type": "reference", "tokens": 5200}
  ]
}
```
The agent sees titles, types, and sizes. This costs ~100 tokens total.

**Layer 2 -- Details (full content on demand)**:
When the agent decides it needs the "Deploy to staging" runbook, it fetches the full 2,400-token document.

**Layer 3 -- Deep Dive (original sources if required)**:
If the runbook references a specific config file or script, the agent reads the original source.

**Adoption**: This pattern was adopted by OpenAI, Google, GitHub, and Cursor within weeks of publication. It has become the standard approach to agent knowledge management.

> Reference: [Equipping Agents for the Real World with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

---

## Implementation Patterns

### Pattern 1: The Exploration Funnel

Start broad, narrow progressively. Every step reduces the search space.

```
Step 1: ls (what files exist?)
  → 47 files across 12 directories

Step 2: grep "pattern" (where is the relevant code?)
  → 3 files contain the pattern

Step 3: read file.py:100-130 (what does this specific function do?)
  → The function's implementation and signature

Step 4: read file.py (full file only if needed for broader context)
  → Full file, but only when Steps 1-3 have confirmed it is necessary
```

**Key insight**: Most tasks never need Step 4. The funnel narrows quickly enough that targeted reads suffice.

### Pattern 2: The Index-Detail Split

Separate "understanding the system" from "working on the code."

```
Step 1: Read project README/CLAUDE.md (project overview)
  → Understand what this project is, how it is organized, key conventions

Step 2: Read directory structure (what modules exist?)
  → Understand the module layout and where to look

Step 3: Read module's public API (function signatures, types)
  → Understand what the module exposes without reading implementation

Step 4: Read specific implementation (only the function being changed)
  → Read the actual code, but only the specific function
```

**When to use**: Any task where you need to understand the project before making changes. This is the default pattern for unfamiliar codebases.

### Pattern 3: The Semantic Zoom

Like a map application: zoom from continent to street level.

```
Level 0: "This project is a REST API for managing users"
Level 1: "The API has routes/, models/, services/, utils/"
Level 2: "services/user_service.py has create_user(), get_user(), delete_user()"
Level 3: "create_user() validates input, hashes password, inserts into DB"
Level 4: [actual code of create_user()]
```

Each level provides 5-10x more detail than the previous. The agent stops zooming when it has enough detail to complete the task.

**When to use**: Debugging, code review, understanding unfamiliar code. The agent can explain its understanding at any zoom level and decide whether to go deeper.

### Pattern 4: The MCP Tool Cascade

When building custom tools for agents via Model Context Protocol (MCP), design them as a progressive disclosure cascade.

```
Tool 1: list_symbols(file) → returns function/class names
  → "What symbols exist in this file?"

Tool 2: get_signature(symbol) → returns type signature
  → "What are the inputs and outputs?"

Tool 3: get_docstring(symbol) → returns documentation
  → "What does this function do?"

Tool 4: get_implementation(symbol) → returns actual code
  → "How does it work?" (only when the agent needs to modify or deeply understand it)
```

**Why four tools instead of one**: A single `read_symbol` tool that returns everything wastes tokens when the agent only needs the signature. Four specialized tools let the agent request exactly the level of detail it needs.

---

## Progressive Disclosure in Existing Tools

### Claude Code

- **Subagents with "Explore" type**: Read-only subagents that search and summarize without modifying files. They operate at the index/summary layers and report back, keeping the main agent's context clean.
- **`/compact`**: Preserves key decisions while discarding implementation details. This is retroactive progressive disclosure -- compressing detail back to summary after it has been used.
- **Auto-memory**: Writes summaries of decisions and progress to CLAUDE.md for future sessions. Future sessions start at the summary layer instead of re-reading all the code.
- **Deferred tool loading**: Only loads tool schemas when the agent requests them via ToolSearch.

### Aider

- **Repo map**: Uses tree-sitter to parse files and PageRank to rank symbols. Shows the most important structural information in ~1,024 tokens.
- **`--map-tokens`**: Controls how much structure is shown. Lower values force more aggressive progressive disclosure.
- **Chat set vs. repo map**: Only files explicitly added to the "chat" set are sent in full. Everything else appears only in the repo map (index layer).

### Cursor

- **Codebase embeddings**: Semantic search over the entire codebase. Returns relevant snippets (summary layer), not full files.
- **AST-aware context selection**: Understands code structure and selects relevant functions/classes, not arbitrary line ranges.
- **Tab completion context**: Builds context progressively from the cursor position outward -- nearest code first, distant code only if relevant.

### OpenCode

- **Agent-specific tool restrictions**: Read-only agents see fewer tools, reducing context overhead.
- **Mode-based tool access**: Different modes (code, architect, ask) expose different tool sets, a form of progressive disclosure for agent capabilities.

---

## Anti-Patterns

### 1. The "Read Everything" Agent

**Symptom**: Reads every file in the project before starting any work.

**Why it happens**: The agent is trying to "understand the whole system" before making changes. This feels thorough but is counterproductive.

**Consequence**: Context window fills with irrelevant code. Performance degrades rapidly. The agent may hit context limits before it starts the actual task.

**Fix**: Start with structure (directory listing, README), zoom in as needed. The agent does not need to understand the billing module to fix a bug in authentication.

### 2. The "Full File Always" Agent

**Symptom**: Always reads complete files even when one function is needed.

**Why it happens**: The Read tool defaults to reading entire files. It is the path of least resistance.

**Consequence**: Wastes 90%+ of context on irrelevant code within the same file. A 3,000-line utility file loaded for one 20-line function wastes 99.3% of those tokens.

**Fix**: Use line ranges. Grep first to find the relevant lines, then read targeted sections. `read file.py:847-880` instead of `read file.py`.

### 3. The "No Map" Agent

**Symptom**: Jumps straight to implementation without understanding structure. Starts reading random files hoping to find what it needs.

**Why it happens**: No structural overview was provided, and the agent does not know to create one.

**Consequence**: Makes wrong assumptions about project organization. Edits the wrong file. Misses important dependencies.

**Fix**: Always read overview docs and directory structure first. If no overview docs exist, create a mental map from the directory listing before diving into code.

### 4. The "Over-Disclosed" Agent

**Symptom**: Too aggressive about hiding information. The agent spends more tokens requesting information incrementally than it would cost to include upfront.

**Why it happens**: Overly strict progressive disclosure rules that force the agent to ask for every piece of information individually.

**Consequence**: Token waste on meta-communication. The agent makes 10 tool calls to gather information that could have been provided in one 500-token block.

**Fix**: Include obvious necessities upfront. If the agent is editing a file, include the full file if it is under 500 lines. Progressive disclosure is about avoiding unnecessary information, not withholding necessary information.

---

## Metrics

How to measure whether progressive disclosure is working:

| Metric | What It Measures | Good Target | How to Measure |
|--------|-----------------|-------------|----------------|
| **Context utilization** | % of context tokens relevant to current task | > 50% | Sample context at random points, score relevance |
| **Exploration efficiency** | Read operations before finding the right code | < 5 | Count tool calls before productive editing begins |
| **Task completion rate** | Does progressive disclosure improve success? | Higher than baseline | A/B test with and without progressive disclosure |
| **Token efficiency** | Tokens consumed per completed subtask | Decreasing over session | Total tokens / completed subtasks |

**Reference point**: Cline reports achieving **17.5% context utilization** with progressive disclosure techniques, meaning 82.5% of context tokens are still irrelevant. This highlights how much room for improvement remains even with current best practices.

---

## The Connection to AST-Based Agents

Progressive disclosure is the natural paradigm for AST-based agents. The Abstract Syntax Tree (AST) is itself a progressive disclosure structure:

```
AST Level 0: Module (file name)
AST Level 1: Top-level declarations (classes, functions, imports)
AST Level 2: Class members (methods, properties)
AST Level 3: Function bodies (statements, expressions)
AST Level 4: Leaf nodes (literals, identifiers, operators)
```

An AST-based agent can operate at Levels 0-2 for understanding and planning, dropping to Levels 3-4 only for the specific code being modified. This maps directly to the three-layer model:

- **Index layer** = AST Levels 0-1 (what exists)
- **Summary layer** = AST Level 2 (what it does -- method signatures, types)
- **Detail layer** = AST Levels 3-4 (how it works -- actual implementation)

The "refactoring-only agent" vision: an agent that operates entirely at the structural level (renaming, moving, extracting) without ever needing to read full implementations. Tree-sitter and similar incremental parsers make this possible today.

See [AST-Based Agents](../AST_AGENTS.md) for detailed coverage.

---

## Cross-References

- [Context Management](./04-context-management.md): Core context management strategies, including the 60% rule and compaction techniques. Progressive disclosure reduces the need for compaction by avoiding context pollution in the first place.
- [Long-Running Tasks](./06-long-running-tasks.md): Long-running tasks are where progressive disclosure matters most. Without it, context rot sets in within hours.
- [AST-Based Agents](../AST_AGENTS.md): AST is the natural data structure for progressive disclosure of code.
- [AI Agent Tricks](../AI_AGENT_TRICKS.md): Practical tricks that implement progressive disclosure principles.
- [Context Engineering Survey](../papers/context-engineering-survey.md): Academic research on context engineering techniques.

---

*Last Updated: March 18, 2026*
