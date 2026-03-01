# AI Agent Research Papers

*Detailed explanations of foundational and recent papers in AI agents, context management, and benchmarks*

---

## Overview

This directory contains detailed explanations of the most important research papers in the field of AI agents. Each document provides:

- **Core contributions**: What the paper introduces
- **Technical details**: How it works
- **Results**: Key findings
- **Implications**: Why it matters
- **Practical applications**: How to use it

---

## Paper Categories

### Foundational Papers

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [ReAct](react-reasoning-acting.md) | Yao et al. | 2022 | Interleaving reasoning and acting |
| [Chain-of-Thought](chain-of-thought.md) | Wei et al. | 2022 | Eliciting reasoning through intermediate steps |
| [RAG](rag-lewis-2020.md) | Lewis et al. | 2020 | Retrieval-augmented generation |

### Context Management & Engineering

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [Context Engineering Survey](context-engineering-survey.md) | Mei et al. | 2025 | Comprehensive context engineering taxonomy |
| [LLMs Get Lost in Multi-Turn](llms-get-lost-multi-turn.md) | Laban et al. | 2025 | Multi-turn conversation degradation |
| [Effective Harnesses](anthropic-harnesses.md) | Anthropic | 2025 | Long-running agent patterns |

### Multi-Agent Systems

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [MetaGPT](metagent-multisession.md) | Hong et al. | 2023 | SOP-based multi-agent collaboration |

### Benchmarks & Evaluation

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [SWE-bench](swe-bench.md) | Jimenez et al. | 2023 | Real-world software engineering evaluation |
| [WebArena/OSWorld](webarena-osworld.md) | Zhou et al. / Xie et al. | 2023/24 | Web and computer use benchmarks |

### Long-Horizon Task Execution

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [METR Time Horizons](metr-time-horizons.md) | Rein et al. | 2025 | Measuring task completion length |

---

## Reading Guide

### For Beginners

Start with these papers to build foundational understanding:

1. **Chain-of-Thought** - Understand how to elicit reasoning
2. **ReAct** - Learn the reasoning+acting pattern
3. **RAG** - Understand external knowledge integration
4. **LLMs Get Lost in Multi-Turn** - Learn about conversation limitations

### For Agent Builders

Papers with practical implementation guidance:

1. **Effective Harnesses** - Patterns for long-running agents
2. **MetaGPT** - Multi-agent collaboration frameworks
3. **Context Engineering Survey** - Systematic context management
4. **SWE-bench** - What makes agents succeed/fail

### For Researchers

Key papers for understanding the field:

1. **METR Time Horizons** - Measuring agent capabilities
2. **Context Engineering Survey** - Comprehensive taxonomy
3. **WebArena/OSWorld** - Real-world evaluation
4. **LLMs Get Lost** - Fundamental limitations

---

## Key Insights Summary

### From Foundational Papers

| Insight | Implication |
|---------|-------------|
| Reasoning + Acting > Either alone | Agents need both capabilities |
| Intermediate steps improve reasoning | Always show work |
| External knowledge reduces hallucination | Use RAG for facts |

### From Context Management

| Insight | Implication |
|---------|-------------|
| Multi-turn degrades 39% performance | Prefer single-turn when possible |
| Context engineering is systematic | Go beyond prompt design |
| Artifacts > Memory for long tasks | Write to files, don't rely on context |

### From Benchmarks

| Insight | Implication |
|---------|-------------|
| Real software is hard (1% → 60%) | Agents need tools and iteration |
| Task length predicts difficulty | Match task to model capability |
| Web/computer use has large gap | Visual grounding essential |

### From Long-Horizon Research

| Insight | Implication |
|---------|-------------|
| Horizons double every 7 months | Rapid capability growth |
| 1-hour tasks now reliable | Current sweet spot |
| State management crucial | Design for interruptions |

---

## Citation Guide

When citing these papers in your work:

```bibtex
% Foundational
@article{wei2022chain,
  title={Chain-of-Thought Prompting Elicits Reasoning in Large Language Models},
  author={Wei, Jason and others},
  journal={NeurIPS},
  year={2022}
}

@article{yao2023react,
  title={ReAct: Synergizing Reasoning and Acting in Language Models},
  author={Yao, Shunyu and others},
  journal={ICLR},
  year={2023}
}

% Context Management
@article{mei2025context,
  title={A Survey of Context Engineering for Large Language Models},
  author={Mei, Lingrui and others},
  journal={arXiv:2507.13334},
  year={2025}
}

@article{laban2025lost,
  title={LLMs Get Lost In Multi-Turn Conversation},
  author={Laban, Philippe and others},
  journal={arXiv:2505.06120},
  year={2025}
}

% Multi-Agent
@article{hong2023metagpt,
  title={MetaGPT: Meta Programming for A Multi-Agent Collaborative Framework},
  author={Hong, Sirui and others},
  journal={arXiv:2308.00352},
  year={2023}
}

% Benchmarks
@inproceedings{jimenez2024swe,
  title={SWE-bench: Can Language Models Resolve Real-World GitHub Issues?},
  author={Jimenez, Carlos E. and others},
  booktitle={ICLR},
  year={2024}
}

@article{rein2025measuring,
  title={Measuring AI Ability to Complete Long Tasks},
  author={Rein, David and others},
  journal={arXiv:2503.14499},
  year={2025}
}
```

---

## Contributing

To add a new paper:

1. Create `[paper-short-name].md`
2. Follow the existing template structure
3. Include: Abstract, Problem, Solution, Results, Implications, Citation
4. Update this README
5. Add to appropriate category

### Template

```markdown
# Paper Title

**Authors**: Names  
**Institution**: Affiliation  
**Published**: Date  
**Paper**: [Link](URL)

---

## Abstract Summary

Brief summary of the paper's contribution.

---

## The Problem

What challenge does this paper address?

---

## The Solution

How does it work? Technical details.

---

## Results

Key findings and metrics.

---

## Implications

Why does this matter? What does it enable?

---

## For Agentter Users

Practical applications and code examples.

---

## Citation

```bibtex
@article{key,
  title={...},
  author={...},
  year={...}
}
```

---
```

---

## Related Resources

- [METHODOLOGIES.md](/METHODOLOGIES.md) - Practical implementation guides
- [FEATURES.md](/FEATURES.md) - Technical concepts explained
- [OpenCode Documentation](https://opencode.ai/docs) - Tool-specific guides

---

## Changelog

| Date | Change |
|------|--------|
| 2026-03-01 | Initial paper summaries added |

---

*Last Updated: March 1, 2026*
