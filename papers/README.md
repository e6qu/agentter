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

### Deep Learning Foundations

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [AlphaGo / AlphaZero](alphago.md) | Silver et al. | 2016 | Deep RL + tree search for superhuman game play |

### Foundational Architecture

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [Attention Is All You Need](attention-is-all-you-need.md) | Vaswani et al. | 2017 | The Transformer architecture |
| [Chinchilla Scaling](chinchilla-scaling.md) | Hoffmann et al. | 2022 | Compute-optimal training laws |

### Scaling & Efficiency

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [LoRA / QLoRA](lora.md) | Hu et al. / Dettmers et al. | 2021/2023 | Parameter-efficient fine-tuning |

### Foundational Agent Papers

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [ReAct](react-reasoning-acting.md) | Yao et al. | 2022 | Interleaving reasoning and acting |
| [Chain-of-Thought](chain-of-thought.md) | Wei et al. | 2022 | Eliciting reasoning through intermediate steps |
| [RAG](rag-lewis-2020.md) | Lewis et al. | 2020 | Retrieval-augmented generation |

### Agents & Tool Use

| Paper | Authors | Year | Key Contribution |
|-------|---------|------|------------------|
| [Generative Agents](generative-agents.md) | Park et al. | 2023 | Memory-retrieval-reflection agent architecture |

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

1. **Attention Is All You Need** - The Transformer architecture underlying everything
2. **Chain-of-Thought** - Understand how to elicit reasoning
3. **ReAct** - Learn the reasoning+acting pattern
4. **RAG** - Understand external knowledge integration
5. **LLMs Get Lost in Multi-Turn** - Learn about conversation limitations

### For Agent Builders

Papers with practical implementation guidance:

1. **Generative Agents** - Memory-retrieval-reflection architecture for believable agents
2. **LoRA / QLoRA** - Fine-tune models for agent tasks on consumer hardware
3. **Effective Harnesses** - Patterns for long-running agents
4. **MetaGPT** - Multi-agent collaboration frameworks
5. **Context Engineering Survey** - Systematic context management
6. **SWE-bench** - What makes agents succeed/fail
7. **Chinchilla Scaling** - Understanding model training tradeoffs

### For Researchers

Key papers for understanding the field:

1. **AlphaGo / AlphaZero** - Self-play and search as foundations for agent reasoning
2. **METR Time Horizons** - Measuring agent capabilities
3. **Context Engineering Survey** - Comprehensive taxonomy
4. **WebArena/OSWorld** - Real-world evaluation
5. **LLMs Get Lost** - Fundamental limitations
6. **Chinchilla Scaling** - Compute-optimal training

---

## Key Insights Summary

### From Deep Learning Foundations

| Insight | Implication |
|---------|-------------|
| Deep networks + GPUs unlock visual recognition | Started the revolution that led to LLMs |
| Self-play transcends human knowledge | AI can surpass experts without human data |
| Skip connections enable depth | Residual connections power every Transformer |

### From Foundational Architecture

| Insight | Implication |
|---------|-------------|
| Attention alone suffices for sequence modeling | Parallelization enables massive scale |
| Data and model size should scale together | Proper training > bigger models |
| IO-aware attention removes memory bottleneck | Long context windows become practical |

### From Scaling & Efficiency

| Insight | Implication |
|---------|-------------|
| Fine-tuning updates have low intrinsic rank | LoRA makes customization accessible |
| 4-bit quantization preserves quality | QLoRA enables consumer-GPU fine-tuning |
| DPO simplifies alignment | No need for complex RL pipelines |

### From Foundational Agent Papers

| Insight | Implication |
|---------|-------------|
| Reasoning + Acting > Either alone | Agents need both capabilities |
| Intermediate steps improve reasoning | Always show work |
| External knowledge reduces hallucination | Use RAG for facts |

### From Agents & Tool Use

| Insight | Implication |
|---------|-------------|
| Memory + retrieval + reflection = believable agents | Architecture matters more than model size |
| Emergent behavior arises from simple rules | Complex coordination needs no central planner |

### From Context Management

| Insight | Implication |
|---------|-------------|
| Multi-turn degrades 39% performance | Prefer single-turn when possible |
| Context engineering is systematic | Go beyond prompt design |
| Artifacts > Memory for long tasks | Write to files, don't rely on context |

### From Benchmarks

| Insight | Implication |
|---------|-------------|
| Real software is hard (1% -> 60%) | Agents need tools and iteration |
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
% Deep Learning Foundations
@article{silver2016mastering,
  title={Mastering the game of Go with deep neural networks and tree search},
  author={Silver, David and others},
  journal={Nature},
  year={2016}
}

% Foundational Architecture
@inproceedings{vaswani2017attention,
  title={Attention is All You Need},
  author={Vaswani, Ashish and others},
  booktitle={NeurIPS},
  year={2017}
}

@inproceedings{hoffmann2022training,
  title={Training Compute-Optimal Large Language Models},
  author={Hoffmann, Jordan and others},
  booktitle={NeurIPS},
  year={2022}
}

% Scaling & Efficiency
@inproceedings{hu2022lora,
  title={LoRA: Low-Rank Adaptation of Large Language Models},
  author={Hu, Edward J. and others},
  booktitle={ICLR},
  year={2022}
}

@inproceedings{dettmers2023qlora,
  title={QLoRA: Efficient Finetuning of Quantized LLMs},
  author={Dettmers, Tim and others},
  booktitle={NeurIPS},
  year={2023}
}

% Foundational Agent Papers
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

% Agents & Tool Use
@inproceedings{park2023generative,
  title={Generative Agents: Interactive Simulacra of Human Behavior},
  author={Park, Joon Sung and others},
  booktitle={UIST},
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
| 2026-03-18 | Added AlphaGo, LoRA/QLoRA, and Generative Agents detailed summaries; major PAPERS.md expansion with 32 new papers |
| 2026-03-18 | Added Attention Is All You Need and Chinchilla scaling detailed summaries |
| 2026-03-01 | Initial paper summaries added |

---

*Last Updated: March 18, 2026*
