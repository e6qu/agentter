# Implementation Techniques in CLI AI Coding Agents

*A fact-based survey of documented implementation patterns in popular CLI coding agents as of March 2026*

---

## Executive Summary

This document catalogs specific, verifiable implementation techniques used by CLI AI coding agents. These techniques address four core challenges:

| Challenge | Key Techniques |
|-----------|----------------|
| **Codebase navigation** | On-demand lexical search (Claude Code), semantic indexing with Merkle trees (Cursor), repository maps with graph ranking (Aider) |
| **Edit reliability** | Unified diff format (Aider), tool-level patch application (OpenAI), line number avoidance |
| **Long-running sessions** | Context compaction, persistent manifests (CLAUDE.md/AGENTS.md), prompt caching, deferred tool loading |
| **Multi-agent orchestration** | Subagents for context isolation, parallel execution with worktree isolation, modular agent architecture |

**Evidence standard**: All claims are limited to vendor documentation, open-source evidence, or attributable community claims. Unsourced speculation is explicitly excluded.

---

## Scope and Evidence Standard

This document surveys specific, named implementation techniques (algorithms, optimizations, and harness design patterns) used by widely discussed CLI coding agents. Coverage is limited to:

- **Vendor documentation**: Claims explicitly documented by the vendor
- **Open-source evidence**: Claims verifiable from source code or official repositories
- **Attributable community claims**: Specific, attributed claims from discussion platforms

This document explicitly does **not** include:
- Unsourced speculation about implementation details
- Claims inferred from behavior without documentation
- Vendor marketing language presented as technical fact

Agents covered: Claude Code, Codex CLI, Aider, OpenCode, Cursor, Trae Agent.

---

## 1. The Agentic Loop Foundation

### 1.1 Core Loop Pattern

A recurring foundation across agents is a **tool-augmented loop**: gather context → take actions (file edits/commands) → verify → repeat.

**Claude Code** documents this explicitly:

> "it works through three phases: gather context, take action, and verify results."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/how-claude-code-works`

The loop is described as powered by two components:

> "The agentic loop is powered by two components: models that reason and tools that act."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/how-claude-code-works`

**OpenAI Codex CLI** uses similar framing:

> "the Codex harness... provides the core agent loop and execution logic"
> 
> Source: `https://openai.com/index/unrolling-the-codex-agent-loop/`

### 1.2 Tool Primitives

The basic loop is implemented with primitives mapping to developer activities:

| Category | Operations |
|----------|------------|
| Search | grep, glob, regex-based content search |
| Read | File content retrieval |
| Edit | Structured patch application, file writes |
| Execute | Shell commands, test runners, compilers |
| Verify | Test re-runs, lint checks |

Claude Code documents a canonical sequence for "fix failing tests":

1. Run test suite → 2. Read error output → 3. Search for relevant files → 4. Read source files → 5. Edit files → 6. Re-run tests to verify

> "Run the tests again to verify"
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/how-claude-code-works`

---

## 2. Codebase Navigation Techniques

### 2.1 On-Demand Lexical Navigation vs. Semantic Indexing

A documented design fork is whether agents maintain persistent semantic indexes or navigate on-demand.

**Claude Code** explicitly states it does **not** build a vector database index:

> "Claude Code doesn't use embeddings or a vector database."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/faq`

This is a deliberate architectural constraint: the harness uses grep/read/edit/execute primitives without persistent embedding infrastructure.

**Cursor** takes the opposite approach, maintaining a semantic index. The Cursor documentation on secure codebase indexing describes their approach:

> "split into syntactic chunks and embed each chunk"
> 
> Source: `https://cursor.com/blog/secure-codebase-indexing`

### 2.2 Repository Map Summarization (Aider)

**Aider** implements a non-vector navigation technique: sending a compact, structured "map" of repository symbols.

The repo map contains:

> "aider sends GPT a concise map of your whole git repository..."
> 
> Source: `https://aider.chat/2023/10/22/repomap.html`

Built using tree-sitter:

> "built automatically using tree-sitter to extract symbol definitions"
> 
> Source: `https://aider.chat/2023/10/22/repomap.html`

With graph-based ranking for token budget compliance:

> "analyzing the full repo map using a graph ranking algorithm"
> 
> Source: `https://aider.chat/2023/10/22/repomap.html`

The map includes class/function signatures and types but omits full implementations, fitting within a configurable token budget (default 1k tokens via `--map-tokens`).

### 2.3 Semantic Indexing with Incremental Updates (Cursor)

**Cursor** documents a multi-component indexing system. Cursor trains its own embedding model for code:

> "Cursor trains its own embedding model for code."
> 
> Source: `https://cursor.com/blog/improving-agent-with-semantic-search`

---

## 3. Incremental Indexing and Caching

### 3.1 Merkle Trees for Change Detection

**Cursor** documents using Merkle trees to detect changed chunks:

> "construct a Merkle tree of these chunk hashes."
> 
> Source: `https://cursor.com/blog/secure-codebase-indexing`

Operational semantics:
- Each leaf: chunk hash
- Internal nodes: hashes of children
- Root hash: summarizes directory/subtree

This enables efficient differential updates:

> "We can quickly find... which chunks have been modified."
> 
> Source: `https://cursor.com/blog/secure-codebase-indexing`

### 3.2 Content-Addressed Embedding Cache

**Cursor** caches embeddings keyed by chunk content:

> "cache embeddings based on the chunk content"
> 
> Source: `https://cursor.com/blog/secure-codebase-indexing`

Unchanged chunks reuse cached vectors, avoiding recomputation.

### 3.3 SimHash for Cross-User Index Reuse

**Cursor** documents using SimHash to reuse indexes across teammates:

> "compute a SimHash for every repository"
> 
> Source: `https://cursor.com/blog/secure-codebase-indexing`

And storing SimHashes for similarity search:

> "vector database of SimHashes... perform a similarity search"
> 
> Source: `https://cursor.com/blog/secure-codebase-indexing`

This enables "bootstrap" from existing similar indexes rather than full re-indexing.

### 3.4 Content Proofs for Access Control

**Cursor** documents a security mechanism to prevent cross-repository leakage:

> "use content proofs to control access to entries in the database."
> 
> Source: `https://cursor.com/blog/secure-codebase-indexing`

Filtering after similarity search:

> "filter out any results that... don't correspond to their repository."
> 
> Source: `https://cursor.com/blog/secure-codebase-indexing`

---

## 4. Edit Reliability Techniques

### 4.1 Unified Diff Format for Edits

**Aider** documents using unified diffs to improve edit correctness:

> "Aider now asks GPT-4 Turbo to use unified diffs to edit your code."
> 
> Source: `https://aider.chat/docs/unified-diffs.html`

This is implemented as a system prompt choice:

> "Aider's system prompt encourages GPT to produce... diffs."
> 
> Source: `https://aider.chat/docs/unified-diffs.html`

Quantified impact:

> "produce a 30-50% increase in editing errors" (without high-level diff prompting)
> 
> Source: `https://aider.chat/docs/unified-diffs.html`

Aider's benchmark showed:
- GPT-4 Turbo baseline (SEARCH/REPLACE format): 20% success
- Unified diff format: 61% success
- "Lazy comments" reduced from 12 tasks to 4 tasks

### 4.2 Tool-Level Patch Application

**OpenAI** exposes `apply_patch` as a platform tool:

> "Enable the tool with tools=[{\"type\": \"apply_patch\"}]."
> 
> Source: `https://developers.openai.com/api/docs/guides/tools-apply-patch/`

The Codex CLI configuration reference documents this capability:

> "include_apply_patch_tool... Legacy name for enabling... apply_patch"
> 
> Source: `https://developers.openai.com/codex/config-reference/`

This reflects a pattern of structured patch operations rather than whole-file rewrites.

### 4.3 Line Number Avoidance

**Aider** documents that GPT performs poorly with line numbers:

> "GPT is terrible at working with source code line numbers. This is a general observation about any use of line numbers in editing formats, backed up by many quantitative benchmark experiments."
> 
> Source: `https://aider.chat/docs/unified-diffs.html`

Aider's solution is to omit line numbers and interpret hunks as search/replace operations.

---

## 5. Long-Running Session Management

### 5.1 Context Compaction

**Claude Code** documents compaction as automatic summarization:

> "/compact [instructions] Compact conversation with optional focus instructions"
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/interactive-mode`

Compaction mechanics:

> "compaction summarizes the conversation to free space."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/hooks-guide`

**OpenCode** implements compaction via a dedicated system agent:

> "Hidden system agent that compacts long context into a smaller summary."
> 
> Source: `https://opencode.ai/docs/agents/`

### 5.2 Context Re-injection via Hooks

**Claude Code** documents a pattern for recovering from compaction loss:

> "Use a SessionStart hook... to re-inject critical context after every compaction."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/hooks-guide`

Hook output becomes context:

> "Any text your command writes to stdout is added to Claude's context."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/hooks-guide`

### 5.3 Persistent Project Manifests

Multiple agents implement hierarchical manifest file systems:

**Claude Code (CLAUDE.md)**:

Directory-based loading with precedence:

> "CLAUDE.md... above... loaded in full at launch... child... load on demand"
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/memory`

Hybrid memory design:

> "first 200 lines of MEMORY.md are loaded... Topic files... not loaded at startup."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/memory`

**OpenAI Codex (AGENTS.md)**:

> "Codex reads AGENTS.md files before doing any work."
> 
> Source: `https://developers.openai.com/codex/guides/agents-md/`

Hierarchical discovery with size limit:

> "Subject to a limit (32 KiB...): look in each folder... up to the cwd"
> 
> Source: `https://openai.com/index/unrolling-the-codex-agent-loop/`

**OpenHands**:

> "Always-on context (e.g., AGENTS.md) that is injected into the system prompt at conversation start."
> 
> Source: `https://docs.openhands.dev/overview/skills`

Auto-loading with multiple manifest names:

> "Automatically finds AGENTS.md, CLAUDE.md, GEMINI.md at workspace root"
> 
> Source: `https://docs.openhands.dev/sdk/guides/skill`

### 5.4 Tool Definition Management

**Claude Code** documents overhead from MCP server tool definitions:

> "Each MCP server adds tool definitions to your context, even when idle."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/costs`

Deferred loading mechanism:

> "automatically defers them and loads tools on-demand via tool search"
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/costs`

Configuration via environment variable:

```
ENABLE_TOOL_SEARCH=auto:<N>  # Trigger at N% of context (default 10%)
```

This threshold-based progressive disclosure keeps prompt prefixes small.

### 5.5 Prompt Caching

**Claude Code** documents prompt caching as automatic:

> "Claude Code automatically uses prompt caching to optimize performance and reduce costs."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/model-config`

Cost optimization description:

> "optimizes costs through prompt caching... and auto-compaction"
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/costs`

**Anthropic platform** definition:

> "Prompt caching caches the full prefix... tools, system, and messages"
> 
> Source: `https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching`

The technique involves keeping stable, cacheable prefixes (system prompt, tool schemas, persistent memory files) separate from frequently-changing content.

---

## 6. Subagents and Multi-Agent Orchestration

### 6.1 Subagents for Context Isolation

**Claude Code** documents subagents as a context-control mechanism:

> "Subagents get their own fresh context... Their work doesn't bloat your context."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/how-claude-code-works`

**OpenCode** treats subagents as invokable components:

> "Subagents are specialized assistants that primary agents can invoke"
> 
> Source: `https://opencode.ai/docs/agents/`

### 6.2 Parallel Agent Execution

**OpenAI Codex** documents multi-agent workflows:

> "spawning specialized agents in parallel and... collecting their results"
> 
> Source: `https://developers.openai.com/codex/multi-agent/`

Worktree isolation for parallel agents:

> "Each agent works on its own git worktree — so there's zero risk of changes colliding"
> 
> Source: `https://openai.com/index/introducing-codex-app/`

### 6.3 Modular Agent Architecture (Trae Agent)

**Trae Agent** (research system from ByteDance) documents a modular approach:

> "through modular agents for generation, pruning, and selection."
> 
> Source: `https://ar5iv.labs.arxiv.org/html/2507.23370`

Parallel patch generation:

> "generate diverse candidate patches in parallel"
> 
> Source: `https://ar5iv.labs.arxiv.org/html/2507.23370`

Trae Agent achieved 75.20% Pass@1 on SWE-bench Verified as of the paper's publication.

---

## 7. Permission Scoping and Safety

### 7.1 Tool Permission Restrictions

**OpenCode** documents permission-based agent restrictions:

> "A restricted agent designed for planning and analysis... set to ask... file edits... bash"
> 
> Source: `https://opencode.ai/docs/agents/`

**Claude Code** documents tool inheritance controls:

> "By default, subagents inherit all tools... including MCP tools."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/sub-agents`

### 7.2 Approval Policies

**OpenAI Codex** documents configurable approval policies:

> "Controls when Codex pauses for approval before executing commands."
> 
> Source: `https://developers.openai.com/codex/config-reference/`

Default sandbox posture:

> "By default, codex exec runs in a read-only sandbox."
> 
> Source: `https://developers.openai.com/codex/noninteractive/`

---

## 8. Model Configuration Techniques

### 8.1 Adaptive Reasoning Control

**Claude Code** documents effort levels for adaptive reasoning:

> "Effort levels control Opus 4.6's adaptive reasoning, which dynamically allocates thinking based on task complexity."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/model-config`

Three levels available: **low**, **medium**, **high** (default).

Configuration methods:
- Environment variable: `CLAUDE_CODE_EFFORT_LEVEL=low|medium|high`
- Settings file: `effortLevel` field
- Interactive: `/model` command with effort slider

### 8.2 Model Switching Patterns

**Claude Code** provides an `opusplan` alias:

> "Special mode that uses `opus` during plan mode, then switches to `sonnet` for execution"
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/model-config`

This implements a "strong model for planning, fast model for execution" pattern.

### 8.3 Extended Context Windows

**Claude Code** documents 1M token context support:

> "Opus 4.6 and Sonnet 4.6 support a 1 million token context window for long sessions with large codebases."
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/model-config`

Pricing threshold:

> "Your session uses standard rates until it exceeds 200K tokens of context. Beyond 200K tokens, requests are charged at long-context pricing"
> 
> Source: `https://docs.anthropic.com/en/docs/claude-code/en/model-config`

Usage:
```bash
/model sonnet[1m]  # Use 1M context variant
```

---

## 9. Technique Comparison Matrix

| Technique | Claude Code | Codex CLI | Aider | OpenCode | Cursor |
|-----------|:-----------:|:---------:|:-----:|:--------:|:------:|
| **Navigation** |
| Vector embeddings index | ❌ | ❌ | ❌ | ❌ | ✅ |
| Repo map (tree-sitter) | ❌ | ❌ | ✅ | ❌ | ❌ |
| On-demand lexical search | ✅ | ✅ | ✅ | ✅ | ❌ |
| **Indexing/Caching** |
| Merkle tree change detection | ❌ | ❌ | ❌ | ❌ | ✅ |
| Content-addressed embedding cache | ❌ | ❌ | ❌ | ❌ | ✅ |
| Cross-user index reuse (SimHash) | ❌ | ❌ | ❌ | ❌ | ✅ |
| **Edit Reliability** |
| Unified diff format | ❌ | ❌ | ✅ | ❌ | ❌ |
| Tool-level patch application | ❌ | ✅ | ❌ | ❌ | ❌ |
| **Session Management** |
| Context compaction | ✅ | ❓ | ❌ | ✅ | ❓ |
| Hooks for context re-injection | ✅ | ❌ | ❌ | ❌ | ❌ |
| Persistent manifest files | ✅ (CLAUDE.md) | ✅ (AGENTS.md) | ❌ | ✅ | ❌ |
| Prompt caching | ✅ | ❓ | ❌ | ❌ | ❓ |
| Deferred tool loading | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Multi-Agent** |
| Subagents | ✅ | ✅ | ❌ | ✅ | ❌ |
| Parallel agent execution | ✅ | ✅ | ❌ | ❌ | ❌ |
| Worktree isolation | ✅ | ✅ | ❌ | ❌ | ❌ |
| **Model Configuration** |
| Adaptive reasoning levels | ✅ | ❌ | ❌ | ❌ | ❌ |
| Model switching (plan/exec) | ✅ | ❌ | ❌ | ❌ | ❌ |
| Extended context (1M tokens) | ✅ | ❌ | ❌ | ❌ | ❌ |

*Legend: ✅ = Documented, ❌ = Not documented/Not applicable, ❓ = Unknown/not verified*

---

## 10. Source URL Reference

Primary sources referenced in this document:

| Agent | URL | Topic |
|-------|-----|-------|
| Claude Code | `https://docs.anthropic.com/en/docs/claude-code/en/how-claude-code-works` | Agentic loop |
| Claude Code | `https://docs.anthropic.com/en/docs/claude-code/faq` | No embeddings |
| Claude Code | `https://docs.anthropic.com/en/docs/claude-code/en/memory` | CLAUDE.md system |
| Claude Code | `https://docs.anthropic.com/en/docs/claude-code/en/hooks-guide` | Hooks, compaction |
| Claude Code | `https://docs.anthropic.com/en/docs/claude-code/en/costs` | Cost optimization |
| Claude Code | `https://docs.anthropic.com/en/docs/claude-code/en/model-config` | Models, caching |
| Claude Code | `https://docs.anthropic.com/en/docs/claude-code/en/sub-agents` | Subagents |
| Cursor | `https://cursor.com/blog/secure-codebase-indexing` | Merkle trees, SimHash |
| Cursor | `https://cursor.com/blog/improving-agent-with-semantic-search` | Embeddings |
| Aider | `https://aider.chat/2023/10/22/repomap.html` | Repo map |
| Aider | `https://aider.chat/docs/unified-diffs.html` | Diff format |
| OpenCode | `https://opencode.ai/docs/agents/` | Agents, compaction |
| OpenAI Codex | `https://openai.com/index/unrolling-the-codex-agent-loop/` | Agent loop |
| OpenAI Codex | `https://developers.openai.com/codex/guides/agents-md/` | AGENTS.md |
| OpenAI Codex | `https://developers.openai.com/codex/multi-agent/` | Multi-agent |
| OpenAI Codex | `https://developers.openai.com/codex/config-reference/` | Configuration |
| OpenAI Codex | `https://developers.openai.com/api/docs/guides/tools-apply-patch/` | apply_patch |
| OpenHands | `https://docs.openhands.dev/overview/skills` | Skills system |
| Trae Agent | `https://ar5iv.labs.arxiv.org/html/2507.23370` | Modular agents |

---

## 11. Methodological Notes

### 11.1 Limitations

1. **Closed-source verification**: Claims about Claude Code, Cursor, and Codex CLI rely on vendor documentation that cannot be independently verified from source code.

2. **Temporal validity**: Implementation details change. This document reflects documentation available as of March 2, 2026.

3. **Selection bias**: Vendors document features they consider differentiating or important. Common techniques may be under-documented.

4. **Attribution quality**: Community discussion (HN, Reddit, etc.) is used only for user-reported behavior patterns, not for implementation claims.

### 11.2 Validation Notes

Sources were validated via direct URL fetching as of March 2, 2026. The following sources returned content successfully:
- All Claude Code documentation URLs
- All Cursor blog URLs (though `improving-agent-with-semantic-search` returned minimal content)
- All Aider documentation URLs
- All OpenCode documentation URLs
- All OpenAI Codex documentation URLs
- Trae Agent arXiv paper

### 11.3 Terminology

This document uses terminology consistently with the project's [TERMINOLOGY.md](./TERMINOLOGY.md):

- **Agent**: Autonomous AI system that perceives, decides, and acts
- **Context window**: Maximum tokens an LLM can process at once
- **Harness**: The execution environment and orchestration logic around an LLM
- **MCP**: Model Context Protocol - standard for tool integration
- **Subagent**: Specialized agent invoked by a parent agent
- **Tool**: External capability provided to the agent (file read, bash, etc.)

---

*Last Updated: March 18, 2026*
