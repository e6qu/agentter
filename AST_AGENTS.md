# AST-Based Agent Coding: Structural Abstractions for AI Agents

*Research compilation — March 18, 2026*

---

## Table of Contents

1. [Overview](#overview)
2. [The Problem with Raw Text Editing](#the-problem-with-raw-text-editing)
3. [Structural Approaches](#structural-approaches)
   - [AST-Based Navigation & Editing](#ast-based-navigation--editing)
   - [Tree-sitter as Foundation](#tree-sitter-as-foundation)
   - [Refactoring Libraries as Agent Interfaces](#refactoring-libraries-as-agent-interfaces)
   - [LSP as Abstraction Layer](#lsp-as-abstraction-layer)
   - [Progressive Disclosure of Code](#progressive-disclosure-of-code)
4. [The Refactoring-Only Agent Vision](#the-refactoring-only-agent-vision)
5. [Reducing Hallucination via Structure](#reducing-hallucination-via-structure)
6. [Existing Tools & Implementations](#existing-tools--implementations)
7. [The Hybrid Approach (Emerging Consensus)](#the-hybrid-approach-emerging-consensus)
8. [Implications for AI Coding Agent Design](#implications-for-ai-coding-agent-design)
9. [Cross-References](#cross-references)

---

## Overview

The central concept: AI coding agents that are deliberately withheld from seeing raw source code, instead operating through higher-level structural abstractions — ASTs, refactoring libraries, language servers, and tool-based progressive disclosure.

Where traditional agents treat source files as flat text to be read and rewritten, structurally-aware agents interact with code through its semantic representation. They navigate via symbols, edit via refactoring operations, and only request raw source when strictly necessary. This architectural choice addresses fundamental limitations in how LLMs process code: they see token sequences, not structured programs, and this mismatch is the root cause of a large class of coding errors.

This document surveys the tools, research papers, and emerging design patterns that support this approach.

---

## The Problem with Raw Text Editing

### LLMs See Tokens, Not Programs

LLMs process source code as sequences of tokens — subword units that carry no inherent structural meaning. The token boundary for `getUserById` might split into `get`, `User`, `By`, `Id`, with no representation of the fact that this is a method name, belongs to a class, accepts certain parameter types, or is called from specific locations. The model must reconstruct all of this structure from token co-occurrence patterns learned during training.

This creates a fundamental impedance mismatch: the model operates on a flat token stream while the code it is editing has rich hierarchical structure (modules, classes, methods, scopes, types, control flow).

### Hallucination of APIs, Variable Names, and Syntax

When LLMs generate or edit code based on token-level understanding, they frequently:

- **Invent plausible but nonexistent APIs**: Generating calls to methods that do not exist in the target library, because the method name is statistically likely given the context.
- **Hallucinate variable names**: Referencing variables that exist in training data but not in the current codebase.
- **Produce syntactically invalid edits**: Mismatched brackets, incorrect indentation levels, dangling references — all consequences of editing text without structural awareness.
- **Break cross-file references**: Renaming a function in one file without updating call sites, because the agent has no dependency graph.

### Full-File Context Wastes Tokens

A standard agent pattern is to read an entire file into context, make a change, and write the entire file back. For a 2,000-line file where the agent needs to rename a single function, this consumes thousands of tokens to represent code the agent does not need to see or modify. At current pricing and context window limits, this is both expensive and limiting.

### No Semantic Guarantees on Edits

Text-based edits provide no guarantees about semantic preservation. A search-and-replace that renames `count` to `total` will also rename `account` to `actotal` unless carefully bounded. A diff-based edit that inserts a line at the wrong indentation level can silently change program semantics (particularly in Python). There is no mechanism in raw text editing to ensure that a refactoring operation preserves program behavior.

---

## Structural Approaches

### AST-Based Navigation & Editing

#### AutoCodeRover (ISSTA 2024 / ICLR 2025)

AutoCodeRover works on the Abstract Syntax Tree rather than file collections, which is its distinguishing architectural choice. The agent navigates code through AST-level search APIs — searching for classes, methods, and code snippets by their structural role rather than by text matching.

- **Paper**: "AutoCodeRover: Autonomous Program Improvement via Automated Code Reasoning" (Zhang et al., 2024)
- **Venue**: ISSTA 2024, subsequently at ICLR 2025
- **Results**: Uniquely resolved 26 SWE-bench tasks that no other agent solved. Achieved 46.2% on SWE-bench Verified.
- **Key Mechanism**: The agent uses spectrum-based fault localization combined with AST-level code search to identify buggy code elements, then generates patches at the structural level.
- **Source**: [https://github.com/nus-apr/auto-code-rover](https://github.com/nus-apr/auto-code-rover)

#### SuperCoder2.0

SuperCoder2.0 uses Python's built-in `ast` library for code rewriting. Rather than performing text-level find-and-replace, it parses source into an AST, manipulates tree nodes directly, and then unparses back to source. This ensures syntactic validity of all edits and enables operations like function extraction and argument reordering that are error-prone at the text level.

- **Approach**: Parse → transform AST → unparse
- **Language support**: Python (via `ast` module)
- **Trade-off**: Limited to Python, but demonstrates the principle that AST-level editing eliminates a class of syntax errors entirely.

#### RepoGraph

RepoGraph constructs a repository-level graph where nodes represent code lines and edges represent dependency relationships (calls, imports, inheritance, data flow). The agent navigates this graph to understand code structure before making changes.

- **Results**: 32.8% improvement on SWE-bench over baseline approaches
- **Key insight**: Representing repository structure as an explicit graph allows the agent to reason about the impact of changes before making them, reducing cascading errors.

#### cAST (EMNLP 2025)

cAST introduces recursive AST-based chunking for code retrieval. Instead of splitting code files at arbitrary line boundaries (which breaks structural units), cAST splits at AST node boundaries — ensuring that each chunk is a semantically complete unit (a full function, a full class, a complete import block).

- **Venue**: EMNLP 2025
- **Application**: Code retrieval for RAG-based coding agents
- **Benefit**: Retrieval chunks that respect code structure produce more useful context than arbitrary line-based chunks.

---

### Tree-sitter as Foundation

[Tree-sitter](https://tree-sitter.github.io/tree-sitter/) is an incremental parsing library that supports 100+ programming languages. It produces concrete syntax trees (CSTs) that can be queried, navigated, and used to extract structural information from source code. Its incremental nature means it can re-parse only the changed portions of a file, making it suitable for real-time use in editors and agents.

#### Aider's Repository Map

Aider uses tree-sitter as the foundation for its repository map — one of the most widely cited examples of structural context management in coding agents.

The pipeline:

1. **Tree-sitter parsing**: Parse all repository files to extract symbols (classes, functions, methods, variables).
2. **Symbol extraction**: Build a catalog of all defined and referenced symbols across the repository.
3. **PageRank ranking**: Construct a graph of symbol references and apply PageRank to identify the most "important" symbols — those that are widely referenced and therefore most likely to be relevant context.
4. **Token-limited context**: Present the agent with a ranked, token-budget-aware map of repository structure rather than raw file contents.

This means the agent sees something like:

```
src/auth/service.py
│ class AuthService
│   def authenticate(self, credentials: Credentials) -> AuthResult
│   def refresh_token(self, token: str) -> str
│   def revoke(self, session_id: str) -> None
│ class Credentials
│   username: str
│   password: str
```

Rather than the full 500-line implementation of `AuthService`.

Source: [Aider repository map documentation](https://aider.chat/docs/repomap.html) and source code in `aider/repomap.py`.

#### ast-mcp-server

An MCP server that transforms source code into a queryable Semantic Graph. The server parses source files using tree-sitter and exposes the resulting structure through MCP tool calls, allowing an agent to query code structure without reading raw files.

- **Interface**: MCP protocol
- **Operations**: Query classes, functions, imports, call relationships
- **Source**: Available on npm / GitHub

#### code-to-tree MCP Server

A similar MCP server that exposes tree-sitter parse trees directly to agents. The agent can request the tree structure of a file or subtree, navigate parent/child/sibling relationships, and query nodes by type (function_definition, class_declaration, etc.).

---

### Refactoring Libraries as Agent Interfaces

The key insight: refactoring libraries already implement semantically safe code transformations. If an agent issues commands through a refactoring library rather than editing text directly, every edit is guaranteed to preserve program semantics (within the scope of what the refactoring tool validates).

#### Python Rope

[Rope](https://github.com/python-rope/rope) is a pure Python refactoring library that has been maintained since 2006. It provides programmatic access to refactoring operations that are typically available only through IDEs.

**Supported Operations**:

| Operation | Description |
|-----------|-------------|
| **Rename** | Rename any symbol (variable, function, class, module) across all references in the project |
| **Extract Method** | Extract a selection of code into a new method, automatically determining parameters and return values |
| **Extract Variable** | Extract an expression into a named variable |
| **Inline** | Inline a function or variable (replace all references with the definition) |
| **Move** | Move a function, class, or module to a different location, updating all imports |
| **Restructure** | Pattern-based code transformation using a structural pattern language |
| **Change Signature** | Add, remove, or reorder function parameters, updating all call sites |

**Agent Workflow with Rope**:

```python
from rope.base.project import Project
from rope.refactor.rename import Rename

# Agent never sees raw source — only issues refactoring commands
project = Project('/path/to/codebase')
resource = project.get_resource('module.py')

# Agent asks: "rename function 'process_data' to 'transform_data'"
renamer = Rename(project, resource, offset=find_offset('process_data'))
changes = renamer.get_changes('transform_data')

# Preview what will change (agent can review before applying)
print(changes.get_description())

# Apply the change — safe, semantic rename across all references
project.do(changes)
```

The critical property: `project.do(changes)` performs a rename that is guaranteed to update every reference to `process_data` across the entire project, including imports, call sites, and string references (optionally). A text-based agent would need to find all references manually and risk missing some.

**MCP Integration**: A Rope-based MCP skill is available on Smithery.ai (`python-rope-refactoring`), exposing Rope operations as MCP tools that any compatible agent can call.

#### Comby

[Comby](https://comby.dev/) is a structural code search and replace tool that is language-agnostic. Unlike regex-based search and replace, Comby understands code structure — it respects string boundaries, comment boundaries, and balanced delimiters.

**Example**: Renaming a function parameter while respecting structure:

```
comby 'process(:[args])' 'transform(:[args])' .py
```

This matches any call to `process(...)` regardless of the arguments, and rewrites it to `transform(...)`, preserving the arguments exactly. Unlike regex, it correctly handles nested parentheses, multi-line arguments, and string literals containing parentheses.

- **Language support**: Language-agnostic (works with any language that uses balanced delimiters)
- **Speed**: Designed for large-scale codebase refactoring
- **Agent use case**: Structural code transformations that are too complex for regex but do not require full semantic analysis

#### srcML

[srcML](https://www.srcml.org/) wraps source code in AST-annotated XML, enabling XML query tools (XPath, XSLT) to navigate and transform code structurally.

- **Performance**: 25 KLOCS/sec (25,000 lines of code per second)
- **Languages**: C, C++, C#, Java
- **Agent use case**: Convert code to XML, use XPath to locate structural elements, transform via XSLT or programmatic XML manipulation, convert back to source

#### Semgrep

[Semgrep](https://semgrep.dev/) provides pattern-based structural analysis. Patterns are written in a syntax that resembles the target language, with metavariables for matching.

**Example** — finding all functions that call `eval()`:

```
rules:
  - id: eval-usage
    pattern: eval($X)
    message: "Found eval() call"
    languages: [python]
```

- **Agent use case**: Structural search (find all instances of a pattern), security analysis, enforcing code conventions
- **Integration**: CLI tool, CI/CD integration, LSP-like diagnostics

#### CodeQL

[CodeQL](https://codeql.github.com/) provides semantic dataflow analysis — it can trace data flow through a program to answer questions like "does user input reach this SQL query without sanitization?"

- **Agent use case**: Understanding code semantics beyond structure — tracking data flow, finding security vulnerabilities, understanding how values propagate through a program
- **Limitation**: Requires database generation step (not real-time)

#### JetBrains PSI (Program Structure Interface)

JetBrains IDEs expose their internal Program Structure Interface, which provides fine-grained AST access and refactoring capabilities for all supported languages.

- **MCP Integration**: Available via the "MCP Steroid" plugin, which exposes PSI operations as MCP tools
- **Operations**: Full IDE refactoring suite (rename, extract, inline, move, change signature, etc.)
- **Languages**: All languages supported by JetBrains IDEs (Java, Kotlin, Python, JavaScript, TypeScript, Go, Rust, etc.)

---

### LSP as Abstraction Layer

The Language Server Protocol (LSP) was designed to decouple language intelligence from editors. The same decoupling makes it a natural abstraction layer for AI agents — instead of reading files, an agent can query an LSP server for structured information about code.

#### LSAP (Language Server Agent Protocol)

LSAP transforms LSP capabilities into agent-native cognitive tools. Rather than exposing raw LSP methods (which are designed for editor UI interactions), LSAP repackages them as higher-level operations suited to agent reasoning.

- **Concept**: LSP methods mapped to agent-friendly tool descriptions
- **Example**: Instead of `textDocument/definition` (an LSP method), the agent calls `go_to_definition("processPayment")` and receives a structured response with file, line, and surrounding context

#### Serena

[Serena](https://github.com/stophobia/serena) is a coding agent toolkit built on symbol-level tools rather than file-level tools. Its core API:

- `find_symbol("UserService")` — locate a symbol by name, returning its type, location, and signature
- `find_references("process_payment")` — find all call sites and references
- `insert_after_symbol(symbol, code)` — insert code relative to a structural element
- `replace_symbol_body(symbol, new_body)` — replace the implementation of a function or method

The key distinction from file-based tools: the agent never specifies line numbers or file offsets. It operates entirely in terms of named symbols, and the toolkit resolves these to physical locations.

#### Claude Code LSP Integration

As of December 2025, Claude Code includes native LSP integration, allowing it to query language servers for type information, go-to-definition, find-references, and diagnostics. This supplements its existing text-based tools with structural awareness.

Source: Anthropic documentation, December 2025 release notes.

#### LSP-AI

[LSP-AI](https://github.com/SilasMarvin/lsp-ai) is an open-source language server backend designed specifically for AI-assisted coding. It implements the LSP protocol with AI-specific extensions, providing a standardized interface for AI tools to access language intelligence.

---

### Progressive Disclosure of Code

Progressive disclosure is the principle that an agent should receive the minimum amount of code necessary for its current task, with the ability to request more detail on demand.

#### Anthropic's Agent Skills (December 2025)

Anthropic's documentation describes a three-layer disclosure model for agent skills:

1. **Index layer**: The agent sees a list of modules, classes, and function signatures — no implementation code.
2. **Details layer**: On request, the agent receives docstrings, type annotations, and parameter descriptions for a specific symbol.
3. **Deep Dive layer**: Only when necessary, the agent receives the full implementation of a specific function or method.

This means an agent working on a bug in `process_payment()` does not need to load the entire `payment_service.py` file. It first sees the module structure, then requests the signature of `process_payment`, and only if needed, requests the full implementation.

Source: [Anthropic Agent Skills documentation](https://docs.anthropic.com/en/docs/claude-code/en/skills)

#### Aider's Repository Map as Progressive Disclosure

Aider's repository map (described in the Tree-sitter section above) is itself a form of progressive disclosure: the agent starts with a structural overview of the entire repository (weighted by PageRank relevance), and can then request specific files or functions as needed.

#### The "Kitchen Sink" Anti-Pattern

The opposite of progressive disclosure: cramming as much code as possible into the agent's context window. This approach:

- Wastes tokens on irrelevant code
- Dilutes the agent's attention (the relevant code is buried in noise)
- Limits the size of codebases the agent can work with
- Increases latency and cost

Progressive disclosure directly addresses all four problems.

---

## The Refactoring-Only Agent Vision

### Architecture

```
Agent (LLM) ←→ Refactoring Interface ←→ Codebase
                    │
                    ├── AST queries (tree-sitter)
                    ├── Symbol navigation (LSP)
                    ├── Safe refactoring (rope/comby)
                    ├── Semantic search (CodeQL/Semgrep)
                    └── Progressive disclosure (on-demand code viewing)
```

In this architecture, the LLM never directly reads or writes files. Every interaction with the codebase is mediated by a structured interface that provides semantic guarantees.

### What the Agent Sees (Instead of Raw Code)

1. **Structural overview**: Module names, class hierarchy, function signatures with type annotations
2. **Dependency graph**: What calls what, import chains, inheritance relationships
3. **Type information**: Parameter types, return types, generic constraints (from LSP or type checker)
4. **Entrypoints**: `main()`, API routes, event handlers, test entry points
5. **On request only**: Actual implementation code for specific functions — and only when the agent determines it needs to see the implementation

### Available Commands (Not "Edit File")

Instead of generic file read/write tools, the agent has access to semantically meaningful operations:

| Command | Description | Guarantee |
|---------|-------------|-----------|
| `find_symbol("UserService")` | Returns location, type, signature, docstring | Read-only, no side effects |
| `find_references("process_payment")` | All call sites across the codebase | Complete (within analyzed scope) |
| `rename("old_name", "new_name")` | Safe rename across all references | Semantic preservation |
| `extract_method(file, start, end, "new_method_name")` | Extract code into new method | Behavior preservation |
| `inline("helper_function")` | Replace all calls with the function body | Behavior preservation |
| `show_implementation("process_payment")` | Progressive disclosure of actual code | Read-only |
| `find_entrypoints()` | Discover main(), routes, handlers | Read-only |
| `show_call_graph("process_payment")` | Who calls this, what does it call | Read-only |
| `change_signature("func", add_param="timeout: int = 30")` | Add parameter, update all call sites | Semantic preservation |

### Benefits

| Aspect | Traditional (Raw Text) | AST-Based Agent |
|--------|----------------------|-----------------|
| **Hallucination** | High — model invents names, APIs, syntax | Reduced — constrained by actual codebase structure |
| **Context usage** | Wasteful — full files loaded for small changes | Efficient — symbols and signatures only, code on demand |
| **Edit safety** | No guarantees — text edits can break syntax or semantics | Semantic preservation — refactoring tools validate changes |
| **Refactoring** | Error-prone text edits, missed references | Tool-guaranteed correctness across all references |
| **Codebase scale** | Limited by context window | Scales via progressive disclosure and graph navigation |
| **Cross-file changes** | Must manually track all affected files | Automatic — refactoring tools handle cross-file updates |

### Limitations

- **Cannot write novel code without seeing patterns**: If the agent needs to write a new function from scratch, it needs to see existing code for style, conventions, and available APIs. Pure refactoring tools do not cover greenfield development.
- **Limited to supported operations**: The agent can only perform operations that the refactoring tool implements. Novel or complex transformations may not be expressible as a sequence of supported refactoring steps.
- **Setup complexity**: Requires parsers (tree-sitter), language servers (LSP), and refactoring tools (Rope, Comby) to be installed and configured. This is significantly more infrastructure than a simple file read/write interface.
- **Creative leaps require raw code access**: Understanding algorithmic intent, recognizing design patterns, and making architectural decisions often require reading actual implementation code — not just signatures.
- **Language coverage varies**: Rope is Python-only. Comby is language-agnostic but shallow. Full semantic analysis (CodeQL, LSP) varies dramatically by language.

---

## Reducing Hallucination via Structure

### LLM Hallucinations in Practical Code Generation (ACM 2024)

This study systematically categorizes hallucination types in LLM-generated code and proposes structural detection methods.

- **Venue**: ACM Computing Surveys, 2024
- **Finding**: Hallucinations in code generation fall into identifiable structural categories — nonexistent API calls, incorrect parameter types, fabricated variable references — that can be detected by post-hoc AST analysis.

### Structural Trimming

A post-processing approach that parses LLM-generated code into an AST to detect "hallucination anchors" — structural elements that do not correspond to anything in the target codebase or standard libraries.

- **Method**: Parse generated code → walk AST → check each identifier, function call, and import against known symbols → flag or remove unresolvable references
- **Results**: 100% precision, 87.6% recall on hallucination detection
- **Implication**: Even if the agent generates code via raw text, AST-based post-processing can catch a large majority of hallucinated elements before they reach the codebase.

### Grammar-Aligned Decoding (NeurIPS 2024)

Rather than post-processing, this approach constrains the LLM's token generation to produce only syntactically valid code.

- **Venue**: NeurIPS 2024
- **Method**: At each decoding step, mask out tokens that would produce a syntactically invalid program according to the target language's grammar.
- **Guarantee**: Every generated program is syntactically valid by construction.
- **Limitation**: Guarantees syntax, not semantics. A syntactically valid program can still contain logical errors.

### Type-Constrained Code Generation (2025)

Extends grammar-aligned decoding to include type information: the generated code must not only be syntactically valid but also type-correct.

- **Method**: Integrate type checker into the decoding loop, constraining token choices to those that maintain type consistency.
- **Status**: Active research area as of early 2025, with preliminary results showing significant reduction in type errors.

---

## Existing Tools & Implementations

| Tool | Type | Languages | Agent Integration | Key Feature |
|------|------|-----------|-------------------|-------------|
| **tree-sitter** | Incremental parser | 100+ languages | Library (C, Rust, Python, JS bindings) | Fast incremental parsing, CST queries |
| **Rope** | Refactoring library | Python | Python API, MCP (Smithery.ai) | Full refactoring suite, semantic rename |
| **Comby** | Structural search/replace | Language-agnostic | CLI, library | Respects code structure, balanced delimiters |
| **srcML** | AST-annotated XML | C, C++, C#, Java | CLI, XML tools | 25 KLOCS/sec, XPath/XSLT queryable |
| **Semgrep** | Pattern-based analysis | 30+ languages | CLI, CI/CD, API | Structural pattern matching, security rules |
| **CodeQL** | Semantic analysis | 10+ languages | CLI, GitHub integration | Dataflow analysis, vulnerability detection |
| **JetBrains PSI** | IDE refactoring API | 20+ languages | MCP (via Steroid plugin) | Full IDE refactoring capabilities |
| **ast-mcp-server** | MCP server | Multi-language (tree-sitter) | MCP protocol | Queryable Semantic Graph |
| **code-to-tree** | MCP server | Multi-language (tree-sitter) | MCP protocol | Direct tree-sitter access via MCP |
| **Serena** | Agent toolkit | Multi-language | Python API, MCP | Symbol-level agent tools |
| **LSP-AI** | Language server | Multi-language | LSP protocol | AI-specific LSP extensions |
| **AutoCodeRover** | Coding agent | Python (targets any) | Standalone agent | AST-based navigation, fault localization |

---

## The Hybrid Approach (Emerging Consensus)

The emerging consensus among agent developers is not "AST-only" or "text-only" but a hybrid approach that uses each strategy where it is strongest.

### When to Use Structural Tools

- **Navigation**: Understanding codebase structure, finding relevant code, mapping dependencies. Structural tools are strictly superior — they provide complete, accurate information without wasting context tokens.
- **Mechanical refactoring**: Renames, extractions, signature changes, moves. Refactoring libraries provide correctness guarantees that text editing cannot match.
- **Impact analysis**: Before making a change, understanding what will be affected. Call graphs, reference finding, and dependency analysis are structural operations.
- **Large codebases**: When the codebase exceeds the context window, progressive disclosure through structural tools is the only viable approach.

### When to Use Raw Text Editing

- **Novel code generation**: Writing new functions, classes, or modules from scratch. The agent needs to see existing code patterns and produce new text.
- **Complex logic changes**: Modifying algorithm implementations, fixing subtle bugs, optimizing performance. These require reading and understanding actual code.
- **Configuration files**: Non-code files (YAML, JSON, TOML, Markdown) where AST tools may not be available or useful.
- **Creative problem-solving**: Architectural decisions, design pattern selection, and unconventional solutions that cannot be expressed as sequences of standard refactoring operations.

### The Agent's Decision

In a well-designed hybrid system, the agent itself decides which approach to use:

> "Do I need to see the code, or can I just refactor?"

If the task is "rename `UserService` to `AuthService`" — use the refactoring tool. If the task is "optimize the payment processing pipeline" — read the code, understand it, and write new code.

---

## Implications for AI Coding Agent Design

### How Current Agents Implement Structural Understanding

**Claude Code**: As of December 2025, includes native LSP integration for type information and go-to-definition. Uses tree-sitter for syntax highlighting and structural awareness. Primary editing is still text-based (search-and-replace, file write), but structural tools supplement navigation and understanding.

**Aider**: The most mature structural integration among open-source agents. Tree-sitter-based repository map with PageRank ranking is a core architectural feature, not an add-on. The repo map is regenerated for each interaction, providing always-current structural context.

**Cursor**: Uses semantic indexing with Merkle trees for change detection. Maintains a persistent index of codebase structure that is incrementally updated as files change.

### The Case for Building Agents on LSP

LSP provides a standardized, language-agnostic interface for exactly the operations agents need most:

- **Go to definition**: Resolve any symbol to its definition
- **Find references**: Find all uses of any symbol
- **Hover information**: Type information, documentation
- **Diagnostics**: Compilation errors, warnings, lints
- **Code actions**: Quick fixes, refactoring suggestions
- **Rename**: Safe cross-file rename

Building an agent on LSP rather than file read/write means the agent inherits decades of language tooling investment — type checkers, linters, formatters, refactoring engines — without reimplementing any of it.

### Future Directions

- **Agents that primarily operate through refactoring commands**: As refactoring tool coverage improves, the fraction of agent actions that require raw text editing will decrease.
- **Structural context as default**: Rather than "read file, then maybe parse it," agents will start from structural representations and only drop to raw text when necessary.
- **Multi-tool pipelines**: Combining tree-sitter (parsing) + LSP (type info) + Rope/Comby (refactoring) + CodeQL (semantic analysis) into a unified agent interface.
- **Training on structural representations**: LLMs fine-tuned to work with AST representations rather than raw text, potentially reducing hallucination at the model level.

---

## Cross-References

- **[PAPERS.md](PAPERS.md)**: Full citations for AutoCodeRover, grammar-aligned decoding, and other referenced papers
- **[AI_AGENT_TRICKS.md](AI_AGENT_TRICKS.md)**: Implementation techniques including Aider's repo map, context management, and progressive disclosure patterns
- **[FEATURES.md](FEATURES.md)**: Feature explanations for code understanding technologies including tree-sitter, LSP, and semantic indexing
- **[TOOLS_RESEARCH.md](TOOLS_RESEARCH.md)**: Comprehensive feature matrix for AI coding agents, including structural analysis capabilities
- **[TERMINOLOGY.md](TERMINOLOGY.md)**: Definitions of terms used in this document (AST, LSP, MCP, RAG, token, context window)

---

*Last Updated: March 18, 2026*
