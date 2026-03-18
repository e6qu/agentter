# Recursive Language Models

**Authors**: Alex Zhang, Tim Kraska, Omar Khattab
**Institution**: MIT (OASYS Lab)
**Published**: December 2025
**Paper**: [arXiv:2512.24601](https://arxiv.org/abs/2512.24601)
**Code**: [github.com/alexzhang13/rlm](https://github.com/alexzhang13/rlm)
**Models**: [HuggingFace: mit-oasys/rlm-qwen3-8b-v0.1](https://huggingface.co/mit-oasys/rlm-qwen3-8b-v0.1)

---

## Abstract Summary

Recursive Language Models (RLM) introduce an inference paradigm that enables LLMs to process inputs far exceeding their native context windows by treating prompts as programmable objects. The model operates inside a Python REPL, writing code to slice and decompose its input, then recursively calling itself on smaller snippets. This is not a new architecture -- it is a scaffold/inference strategy that works with any existing LLM. RLM-GPT-5-mini outperforms vanilla GPT-5 by 2x on the OOLONG long-context benchmark, and RLM-Qwen3-8B beats its base model by 28.3%, processing 10M+ tokens with no quality degradation.

---

## The Core Problem

Modern LLMs have finite context windows. Even models with 128K or 1M token limits exhibit degraded performance on inputs that approach or exceed those limits (see [LLMs Get Lost in Multi-Turn](llms-get-lost-multi-turn.md)). The standard approaches to handling long inputs -- truncation, summarization, RAG retrieval -- all lose information. Meanwhile, the real world generates documents, codebases, and datasets that routinely exceed 1M tokens.

The fundamental question: **Can an LLM process arbitrarily long inputs without architectural changes, without fine-tuning on long-context data, and without degradation?**

---

## The Solution: Prompts as Programmable Objects

RLM's core insight is deceptively simple: instead of feeding a massive input directly into a model, let the model write code to decompose the input and recursively process the pieces.

### How It Works

1. **Python REPL Environment**: The model operates inside an interactive Python session where the input is available as a variable
2. **Decomposition**: The model writes Python code to slice, chunk, filter, or restructure the input
3. **Recursive Self-Invocation**: The model calls itself (via an `rlm()` function) on each smaller chunk
4. **Aggregation**: The model writes code to combine the sub-results into a final answer

### Pseudocode

```python
# The model sees the full input as a variable and writes code like:
chunks = split_into_sections(input_text, max_size=4000)

results = []
for chunk in chunks:
    # Recursive call -- the model calls itself on each chunk
    result = rlm(f"Extract key claims from: {chunk}")
    results.append(result)

# Aggregation -- the model synthesizes sub-results
final = rlm(f"Synthesize these findings: {results}")
return final
```

### Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| **Python REPL, not a fixed algorithm** | The model chooses its own decomposition strategy per task |
| **Recursive, not iterative** | Enables hierarchical processing (e.g., summarize sections, then summarize summaries) |
| **No architecture changes** | Works with any LLM as a drop-in inference wrapper |
| **No fine-tuning required** | Base models can use RLM, though fine-tuned variants perform better |

---

## Critical Distinction: Inference Paradigm, Not Architecture

This is the most important thing to understand about RLM. It is **not**:

- A new model architecture (like the Transformer)
- A new training method (like RLHF or DPO)
- A retrieval system (like RAG)

It **is** an inference scaffold -- a way of orchestrating calls to an existing model. In the taxonomy of [TERMINOLOGY.md](/TERMINOLOGY.md), RLM is a **scaffold** or **harness** pattern, comparable to ReAct or Chain-of-Thought but operating at the level of input decomposition rather than reasoning steps.

This distinction matters because it means RLM is:
- **Model-agnostic**: Works with GPT-5, Qwen3, Claude, or any LLM
- **Immediately deployable**: No retraining needed (though fine-tuning helps)
- **Composable**: Can be combined with other inference strategies (CoT, ReAct, etc.)

---

## Results

### OOLONG Long-Context Benchmark

| Model | OOLONG Score | Notes |
|-------|-------------|-------|
| GPT-5 (vanilla) | Baseline | Degrades at extreme lengths |
| RLM-GPT-5-mini | **2x baseline** | Maintains quality at 10M+ tokens |
| Qwen3-8B (vanilla) | Baseline | 128K context limit |
| RLM-Qwen3-8B | **+28.3% over base** | Processes well beyond native context |

### Scale Characteristics

- **100x beyond context window**: RLM enables models to process inputs ~100x larger than their native context
- **No degradation at 10M+ tokens**: Unlike vanilla long-context models, quality remains stable as input grows
- **Sublinear compute scaling**: Hierarchical decomposition means compute grows sublinearly with input size (similar to divide-and-conquer algorithms)

### Why It Works

The key insight parallels divide-and-conquer in computer science:

1. Most tasks are **decomposable** -- you can break "summarize this 10M-token codebase" into "summarize each file" + "synthesize file summaries"
2. LLMs are **good programmers** -- they reliably write correct decomposition and aggregation code
3. **Recursion handles arbitrary depth** -- a 10M-token input might need 3-4 levels of recursion, each within the model's native window

---

## Related Work

RLM sits within a rich lineage of adaptive computation and recursive processing research:

| Work | Year | Relationship to RLM |
|------|------|-------------------|
| **Adaptive Computation Time (ACT)** -- Graves | 2016 | First to allow networks to "think longer" via learned halting; RLM externalizes this as code |
| **Universal Transformer** -- Dehghani et al. | 2019 | Applies Transformer blocks recursively with ACT; architectural recursion vs. RLM's inference recursion |
| **PonderNet** -- DeepMind | 2021 | Learns to ponder (iterate) adaptively; same spirit but operates within the architecture |
| **Ouro / LoopLM** | Oct 2025 | Loop-based inference with self-invocation; concurrent work with similar goals but different mechanism |
| **Mixture-of-Recursions** | NeurIPS 2025 | Routes tokens through recursive depth adaptively; architectural approach vs. RLM's scaffold approach |

The key distinction: prior work mostly embeds recursion **inside** the model architecture. RLM moves recursion **outside** the model, into a programmable scaffold. This is arguably more aligned with the [Bitter Lesson](/BITTER_LESSON.md) -- rather than engineering recursion into architectures, RLM leverages the general-purpose capability (code generation) that scales with compute.

---

## Open Source Artifacts

- **Framework**: [github.com/alexzhang13/rlm](https://github.com/alexzhang13/rlm) -- Python library for wrapping any LLM in the RLM scaffold
- **Fine-tuned Model**: [mit-oasys/rlm-qwen3-8b-v0.1](https://huggingface.co/mit-oasys/rlm-qwen3-8b-v0.1) -- Qwen3-8B fine-tuned for RLM-style decomposition and self-invocation
- **Benchmark**: OOLONG evaluation suite for long-context tasks

---

## Implications for Coding Agents

RLM has direct and significant implications for AI coding agents:

### 1. Codebase-Scale Understanding

Current coding agents struggle with large repositories because they cannot fit the entire codebase in context. RLM provides a principled solution: the agent recursively processes the codebase (by directory, by module, by file) and builds up a hierarchical understanding.

### 2. Natural Fit with Agent Scaffolds

RLM's "write code to decompose, then recurse" pattern is essentially what well-designed coding agents already do informally:
- Claude Code reads a directory listing, identifies relevant files, reads them individually
- RLM formalizes this into a recursive, programmable pattern

### 3. Unbounded Task Complexity

Combined with [Effective Harnesses](anthropic-harnesses.md) patterns for long-running agents, RLM enables tasks that require processing inputs far beyond any single context window -- analyzing entire monorepos, processing years of git history, or reviewing thousands of issues.

### 4. Small Model Amplification

The RLM-Qwen3-8B result (+28.3% over base) is particularly interesting for local/edge deployments. A small model with RLM scaffolding can outperform a much larger model on long-context tasks, enabling powerful coding agents on consumer hardware (see [MODELS_WITHIN_128_GiB_RAM.md](/MODELS_WITHIN_128_GiB_RAM.md)).

---

## Limitations

1. **Latency**: Recursive calls multiply inference time; processing 10M tokens requires many sequential LLM calls
2. **Decomposition quality**: The model must correctly identify how to decompose a task; some tasks are not naturally decomposable
3. **Error propagation**: Mistakes in sub-results can compound through recursion levels
4. **Cost**: Many recursive calls mean higher token consumption and API costs
5. **Task dependency**: Tasks requiring holistic understanding of the full input (e.g., "is there a contradiction between page 1 and page 9,999?") are harder to decompose

---

## Key Takeaways

1. **Recursion as an inference paradigm**: LLMs can recursively call themselves to handle arbitrarily long inputs
2. **Scaffold > Architecture**: Moving recursion outside the model (into a code scaffold) is more flexible than baking it into the architecture
3. **Code generation is the key capability**: RLM works because LLMs can reliably write decomposition and aggregation code
4. **Small models punch above their weight**: RLM-Qwen3-8B (+28.3%) demonstrates that inference strategy can matter more than model size
5. **Natural fit for agents**: The recursive decomposition pattern aligns perfectly with how coding agents already process large codebases

---

## Cross-References

- [PAPERS.md](/PAPERS.md) -- Entry in the Reasoning & Planning section
- [TERMINOLOGY.md](/TERMINOLOGY.md) -- Scaffold, harness, inference paradigm definitions
- [BITTER_LESSON.md](/BITTER_LESSON.md) -- RLM as an example of leveraging general-purpose capabilities over hand-engineered solutions
- [Effective Harnesses](anthropic-harnesses.md) -- Complementary patterns for long-running agent tasks
- [LLMs Get Lost in Multi-Turn](llms-get-lost-multi-turn.md) -- The degradation problem that RLM helps solve
- [Context Engineering Survey](context-engineering-survey.md) -- RLM as a context management strategy

---

## Citation

```bibtex
@article{zhang2025recursive,
  title={Recursive Language Models},
  author={Zhang, Alex and Kraska, Tim and Khattab, Omar},
  journal={arXiv:2512.24601},
  year={2025}
}
```

---

*Last Updated: March 18, 2026*
