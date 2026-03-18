# Agentter

*Comprehensive documentation and research on AI coding agents, tools, and methodologies*

---

## Overview

This repository contains comprehensive research, documentation, and guides for AI coding agents including OpenCode, Claude Code, and related tools. It covers feature comparisons, implementation methodologies, research papers, AI models, Hacker News culture, and terminology.

---

## Repository Structure

```
agentter/
├── README.md                    # This file - navigation hub
├── AGENTS.md                    # Agent instructions for AI assistants
├── AI_AGENT_TRICKS.md           # Tips and tricks for AI agent usage
├── AGENT_COMPARISON.md          # High-level comparison of AI coding tools
├── FEATURE_MATRIX.md            # Detailed feature comparison matrix
├── FEATURES.md                  # Technical concepts explained
├── METHODOLOGIES.md             # Agent orchestration methodologies
├── MODELS.md                    # AI model pricing and specifications
├── MODELS_OPEN_SOURCE.md        # Open source models guide
├── MODELS_WITHIN_128_GiB_RAM.md # Models that fit in 128 GiB RAM
├── PAPERS.md                    # Important research papers index
├── TERMINOLOGY.md               # Complete glossary of terms
├── TOOLS_RESEARCH.md            # Research on available tools
├── PROMINENT_PEOPLE.md          # Notable figures in AI/tech
├── PROMINENT_HACKER_NEWS_CONTRIBUTORS.md # Notable HN contributors
├── FAMOUS_SPATS.md              # Famous tech disagreements
├── HACKER_NEWS_DEEP_DIVE.md     # Deep dive into Hacker News
├── HACKER_NEWS_HISTORY.md       # History of Hacker News
├── HACKER_NEWS_LEGENDS.md       # Legendary HN moments
├── HACKER_NEWS_TECHNICAL.md     # Technical aspects of HN
├── HACKER_NEWS_DATA_SOURCES.md  # HN data sources and APIs
├── Hacker_News_opinions.md      # HN community opinions
│
├── opencoder/                   # OpenCode documentation
│   ├── README.md               # Overview and quick start
│   ├── TUTORIAL.md             # Complete setup guide
│   ├── agents.md               # Agents configuration
│   ├── modes.md                # Build/Plan modes
│   ├── skills.md               # SKILL.md system
│   ├── commands.md             # Custom slash commands
│   ├── plugins-hooks.md        # Plugin system and events
│   ├── configuration.md        # opencode.json reference
│   └── advanced-agents.md      # Ephemeral, heartbeat patterns
│
├── claude-code/                 # Claude Code documentation
│   ├── README.md               # Overview and quick start
│   ├── TUTORIAL.md             # Complete setup guide
│   ├── agents.md               # Built-in and custom agents
│   ├── skills.md               # Skills system
│   ├── hooks.md                # Lifecycle hooks
│   ├── agent-teams.md          # Parallel agent execution
│   ├── configuration.md        # settings.json reference
│   └── advanced-agents.md      # Subagents, ephemeral patterns
│
├── methodologies/               # Detailed methodology guides
│   ├── README.md               # Methodology navigation
│   ├── 01-ralph-loops.md       # Persistent execution
│   ├── 02-spec-driven-development.md
│   ├── 03-agent-teams.md
│   ├── 04-context-management.md
│   └── 05-session-teleportation.md
│
├── papers/                      # Research paper summaries
│   ├── README.md               # Paper index
│   ├── react-reasoning-acting.md
│   ├── context-engineering-survey.md
│   ├── llms-get-lost-multi-turn.md
│   ├── metr-time-horizons.md
│   ├── anthropic-harnesses.md
│   ├── metagent-multisession.md
│   ├── rag-lewis-2020.md
│   ├── chain-of-thought.md
│   ├── swe-bench.md
│   └── webarena-osworld.md
│
└── tools/                       # Individual tool documentation
    ├── README.md
    ├── opencode.md
    ├── claude-code.md
    ├── aider.md
    ├── codex-cli.md
    ├── gemini-cli.md
    ├── goose.md
    ├── cline.md
    ├── roo-code.md
    ├── kimi-code.md
    ├── TUTORIAL-aider.md        # Aider setup tutorial
    ├── TUTORIAL-cline.md        # Cline setup tutorial
    ├── TUTORIAL-codex-cli.md    # Codex CLI setup tutorial
    ├── TUTORIAL-gemini-cli.md   # Gemini CLI setup tutorial
    ├── TUTORIAL-goose.md        # Goose setup tutorial
    ├── TUTORIAL-kimi-code.md    # Kimi Code setup tutorial
    └── TUTORIAL-roo-code.md     # Roo Code setup tutorial
```

---

## Quick Navigation

### Getting Started

| Topic | Document | Description |
|-------|----------|-------------|
| **Compare Tools** | [AGENT_COMPARISON.md](./AGENT_COMPARISON.md) | High-level comparison of 9 AI coding tools |
| **Feature Matrix** | [FEATURE_MATRIX.md](./FEATURE_MATRIX.md) | 60+ features across 14 categories |
| **Terminology** | [TERMINOLOGY.md](./TERMINOLOGY.md) | Complete glossary of AI/LLM terms |
| **Agent Instructions** | [AGENTS.md](./AGENTS.md) | Agent instructions for AI assistants |
| **Agent Tricks** | [AI_AGENT_TRICKS.md](./AI_AGENT_TRICKS.md) | Tips and tricks for AI agent usage |

### Models

| Topic | Document | Description |
|-------|----------|-------------|
| **Model Pricing & Specs** | [MODELS.md](./MODELS.md) | AI model pricing and specifications |
| **Open Source Models** | [MODELS_OPEN_SOURCE.md](./MODELS_OPEN_SOURCE.md) | Guide to open source models |
| **Models for 128 GiB RAM** | [MODELS_WITHIN_128_GiB_RAM.md](./MODELS_WITHIN_128_GiB_RAM.md) | Models that fit within 128 GiB RAM |

### Hacker News

| Topic | Document | Description |
|-------|----------|-------------|
| **Deep Dive** | [HACKER_NEWS_DEEP_DIVE.md](./HACKER_NEWS_DEEP_DIVE.md) | Comprehensive deep dive into HN |
| **History** | [HACKER_NEWS_HISTORY.md](./HACKER_NEWS_HISTORY.md) | History of Hacker News |
| **Legends** | [HACKER_NEWS_LEGENDS.md](./HACKER_NEWS_LEGENDS.md) | Legendary HN moments |
| **Technical** | [HACKER_NEWS_TECHNICAL.md](./HACKER_NEWS_TECHNICAL.md) | Technical aspects of HN |
| **Data Sources** | [HACKER_NEWS_DATA_SOURCES.md](./HACKER_NEWS_DATA_SOURCES.md) | HN data sources and APIs |
| **Opinions** | [Hacker_News_opinions.md](./Hacker_News_opinions.md) | Community opinions and takes |

### People & Culture

| Topic | Document | Description |
|-------|----------|-------------|
| **Prominent People** | [PROMINENT_PEOPLE.md](./PROMINENT_PEOPLE.md) | Notable figures in AI and tech |
| **HN Contributors** | [PROMINENT_HACKER_NEWS_CONTRIBUTORS.md](./PROMINENT_HACKER_NEWS_CONTRIBUTORS.md) | Notable Hacker News contributors |
| **Famous Spats** | [FAMOUS_SPATS.md](./FAMOUS_SPATS.md) | Famous tech disagreements and debates |

### Tool Documentation

| Tool | Path | Best For |
|------|------|----------|
| **OpenCode** | [opencoder/](./opencoder/) | Multi-provider, open source, MCP |
| **Claude Code** | [claude-code/](./claude-code/) | Subagents, hooks, agent teams |
| **Aider** | [tools/aider.md](./tools/aider.md) | Git workflow, repo map |
| **Codex CLI** | [tools/codex-cli.md](./tools/codex-cli.md) | Parallel agents, automations |

### Tool Tutorials

| Tool | Tutorial | Description |
|------|----------|-------------|
| **OpenCode** | [opencoder/TUTORIAL.md](./opencoder/TUTORIAL.md) | Complete OpenCode setup guide |
| **Claude Code** | [claude-code/TUTORIAL.md](./claude-code/TUTORIAL.md) | Complete Claude Code setup guide |
| **Aider** | [tools/TUTORIAL-aider.md](./tools/TUTORIAL-aider.md) | Aider setup tutorial |
| **Cline** | [tools/TUTORIAL-cline.md](./tools/TUTORIAL-cline.md) | Cline setup tutorial |
| **Codex CLI** | [tools/TUTORIAL-codex-cli.md](./tools/TUTORIAL-codex-cli.md) | Codex CLI setup tutorial |
| **Gemini CLI** | [tools/TUTORIAL-gemini-cli.md](./tools/TUTORIAL-gemini-cli.md) | Gemini CLI setup tutorial |
| **Goose** | [tools/TUTORIAL-goose.md](./tools/TUTORIAL-goose.md) | Goose setup tutorial |
| **Kimi Code** | [tools/TUTORIAL-kimi-code.md](./tools/TUTORIAL-kimi-code.md) | Kimi Code setup tutorial |
| **Roo Code** | [tools/TUTORIAL-roo-code.md](./tools/TUTORIAL-roo-code.md) | Roo Code setup tutorial |

### Implementation Guides

| Topic | Path | Description |
|-------|------|-------------|
| **Methodologies Overview** | [METHODOLOGIES.md](./METHODOLOGIES.md) | Summary of agent orchestration patterns |
| **Ralph Loops** | [methodologies/01-ralph-loops.md](./methodologies/01-ralph-loops.md) | Persistent execution |
| **Spec-Driven Dev** | [methodologies/02-spec-driven-development.md](./methodologies/02-spec-driven-development.md) | Specification-first workflow |
| **Agent Teams** | [methodologies/03-agent-teams.md](./methodologies/03-agent-teams.md) | Multi-agent orchestration |
| **Context Management** | [methodologies/04-context-management.md](./methodologies/04-context-management.md) | Long-running sessions |
| **Session Teleportation** | [methodologies/05-session-teleportation.md](./methodologies/05-session-teleportation.md) | Cross-device sessions |

### Research Papers

| Paper | Path | Key Insight |
|-------|------|-------------|
| **Context Engineering** | [papers/context-engineering-survey.md](./papers/context-engineering-survey.md) | Comprehensive context taxonomy |
| **METR Time Horizons** | [papers/metr-time-horizons.md](./papers/metr-time-horizons.md) | Task length doubling every 7 months |
| **LLMs Get Lost** | [papers/llms-get-lost-multi-turn.md](./papers/llms-get-lost-multi-turn.md) | 39% performance drop in multi-turn |
| **ReAct** | [papers/react-reasoning-acting.md](./papers/react-reasoning-acting.md) | Reasoning + Acting synergy |
| **SWE-bench** | [papers/swe-bench.md](./papers/swe-bench.md) | Real-world software engineering eval |

---

## Featured Content

### 1. Feature Comparison

The [FEATURE_MATRIX.md](./FEATURE_MATRIX.md) compares 9 AI coding tools across 14 categories:

| Tool | Score | Best For |
|------|-------|----------|
| **OpenCode** | 36✅ 14⚠️ 11❌ | Provider flexibility, MCP |
| **Claude Code** | 34✅ 13⚠️ 14❌ | Deep reasoning, subagents |
| **Aider** | 33✅ 10⚠️ 18❌ | Git workflow, repo map |
| **Kimi Code** | 31✅ 16⚠️ 14❌ | Fixed-price billing |

### 2. Key Research Findings

From [PAPERS.md](./PAPERS.md):

- **Context Rot**: LLMs lose 39% performance in multi-turn conversations
- **Time Horizons**: AI task completion length doubles every ~7 months
- **Context Engineering**: 84% token reduction with combined techniques
- **ReAct**: 34% improvement over CoT on interactive tasks

### 3. Methodologies

From [METHODOLOGIES.md](./METHODOLOGIES.md):

| Methodology | Use Case | Complexity |
|-------------|----------|------------|
| **Ralph Loops** | Single long tasks | Low |
| **Spec-Driven Development** | Complex features | Medium |
| **Agent Teams** | Parallel work | High |
| **Context Management** | Long sessions | Medium |

---

## OpenCode vs Claude Code

| Feature | OpenCode | Claude Code |
|---------|----------|-------------|
| **Open Source** | ✅ Yes | ❌ No |
| **Multi-Provider** | ✅ 75+ providers | ❌ Anthropic only |
| **Subagents** | ✅ Via @mention | ✅ Built-in |
| **Agent Teams** | ✅ Parallel sessions | ✅ Worktree isolation |
| **Hooks** | ✅ 25+ events | ✅ 15+ events |
| **Skills** | ✅ SKILL.md | ✅ SKILL.md |
| **MCP** | ✅ Full support | ✅ Full support |
| **GitHub Integration** | ✅ GitHub agent | ✅ Native PRs |

**Documentation**:
- [OpenCode Docs](./opencoder/)
- [Claude Code Docs](./claude-code/)

---

## Terminology Quick Reference

### Core Concepts

| Term | Definition |
|------|------------|
| **Agent** | Autonomous AI system that perceives, decides, and acts |
| **Context Window** | Maximum tokens an LLM can process at once |
| **MCP** | Model Context Protocol - standard for tool integration |
| **RAG** | Retrieval-Augmented Generation - external knowledge |
| **CoT** | Chain-of-Thought - intermediate reasoning steps |
| **ReAct** | Reasoning + Acting interleaved |

### Agent Terms

| Term | Definition |
|------|------------|
| **Subagent** | Specialized agent invoked by parent |
| **Agent Team** | Multiple agents working in parallel |
| **Hook** | Lifecycle event handler |
| **Skill** | Reusable instructions (SKILL.md) |
| **Tool** | External capability (file read, bash, etc.) |

See [TERMINOLOGY.md](./TERMINOLOGY.md) for complete glossary.

---

## Research Papers Summary

### Foundational

| Paper | Authors | Year | Contribution |
|-------|---------|------|--------------|
| [ReAct](./papers/react-reasoning-acting.md) | Yao et al. | 2022 | Reasoning + Acting synergy |
| [Chain-of-Thought](./papers/chain-of-thought.md) | Wei et al. | 2022 | Eliciting reasoning |
| [RAG](./papers/rag-lewis-2020.md) | Lewis et al. | 2020 | Retrieval-augmented generation |

### Recent (2024-2025)

| Paper | Authors | Year | Contribution |
|-------|---------|------|--------------|
| [Context Engineering](./papers/context-engineering-survey.md) | Mei et al. | 2025 | Comprehensive taxonomy |
| [LLMs Get Lost](./papers/llms-get-lost-multi-turn.md) | Laban et al. | 2025 | Multi-turn degradation |
| [METR Time Horizons](./papers/metr-time-horizons.md) | Rein et al. | 2025 | Task length trends |
| [Anthropic Harnesses](./papers/anthropic-harnesses.md) | Anthropic | 2025 | Long-running agents |

See [PAPERS.md](./PAPERS.md) for full index.

---

## How to Use This Repository

### For Decision Makers

1. Read [AGENT_COMPARISON.md](./AGENT_COMPARISON.md) for high-level comparison
2. Review [FEATURE_MATRIX.md](./FEATURE_MATRIX.md) for detailed features
3. Check [TOOLS_RESEARCH.md](./TOOLS_RESEARCH.md) for pricing and setup
4. Browse [MODELS.md](./MODELS.md) for model pricing and specs

### For Developers

1. Choose tool docs: [opencoder/](./opencoder/) or [claude-code/](./claude-code/)
2. Read methodologies: [methodologies/](./methodologies/)
3. Implement patterns from [METHODOLOGIES.md](./METHODOLOGIES.md)
4. Review [AI_AGENT_TRICKS.md](./AI_AGENT_TRICKS.md) for practical tips

### For Researchers

1. Start with [PAPERS.md](./PAPERS.md)
2. Read paper summaries: [papers/](./papers/)
3. Review [TERMINOLOGY.md](./TERMINOLOGY.md)
4. Explore [HACKER_NEWS_DEEP_DIVE.md](./HACKER_NEWS_DEEP_DIVE.md) for community perspectives

---

## Contributing

To add content:

1. **New Tool**: Create `tools/<tool-name>.md`
2. **New Paper**: Create `papers/<paper-name>.md`, update [PAPERS.md](./PAPERS.md)
3. **New Methodology**: Create `methodologies/XX-name.md`, update [METHODOLOGIES.md](./METHODOLOGIES.md)
4. **New Terms**: Add to [TERMINOLOGY.md](./TERMINOLOGY.md)

---

## License

This documentation is released under [AGPL-3.0](./LICENSE).

---

## Resources

### Official Documentation

- [OpenCode Docs](https://opencode.ai/docs)
- [Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code)
- [MCP Specification](https://modelcontextprotocol.io/)

### Community

- [Awesome OpenCode](https://github.com/awesome-opencode/awesome-opencode)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)
- [Agent Skills](https://github.com/VoltAgent/awesome-agent-skills)

### Research

- [Anthropic Research](https://www.anthropic.com/research)
- [METR](https://metr.org/)
- [arXiv cs.AI](https://arxiv.org/list/cs.AI/recent)

---

## Changelog

| Date | Change |
|------|--------|
| 2026-03-18 | Added Models, Hacker News, People & Culture, and Tool Tutorials navigation sections; updated tree structure with all repo files |
| 2026-03-01 | Initial comprehensive documentation |

---

*Last Updated: March 18, 2026*
