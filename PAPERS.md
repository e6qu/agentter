# Important Papers in AI Agents, Context Management, and Benchmarks

*Research compilation - March 1, 2026*

---

## Table of Contents

1. [Foundational Papers](#foundational-papers)
2. [Reasoning & Planning](#reasoning--planning)
3. [Context Management & Engineering](#context-management--engineering)
4. [Multi-Agent Systems](#multi-agent-systems)
5. [Benchmarks & Evaluation](#benchmarks--evaluation)
6. [Long-Horizon Task Execution](#long-horizon-task-execution)
7. [Tool Use & Function Calling](#tool-use--function-calling)
8. [Recent Surveys](#recent-surveys)

---

## Foundational Papers

### ReAct: Synergizing Reasoning and Acting in Language Models
- **Authors**: Shunyu Yao et al. (Princeton, Google)
- **Date**: October 2022
- **Paper**: [arXiv:2210.03629](https://arxiv.org/abs/2210.03629)

**Summary**: Introduces ReAct, a paradigm that interleaves reasoning traces and task-specific actions. Reasoning traces help the model induce, track, and update action plans, while actions allow it to interface with external sources to gather additional information. Outperforms CoT and acting-only methods by 34% on ALFWorld and 10% on WebShop.

**Key Insight**: The synergy between reasoning and acting creates more interpretable, trustworthy, and effective agents than either alone.

---

### Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks
- **Authors**: Patrick Lewis et al. (Facebook AI Research)
- **Date**: 2020
- **Paper**: [arXiv:2005.11401](https://arxiv.org/abs/2005.11401)

**Summary**: Introduces RAG (Retrieval-Augmented Generation), combining parametric and non-parametric memory. The model retrieves relevant documents from a knowledge source and uses them to condition generation. Demonstrates strong performance on knowledge-intensive tasks while being more interpretable and easier to update than pure parametric models.

**Key Insight**: Separating knowledge storage (retrieval) from generation (LLM) allows for more accurate, verifiable, and updatable systems.

---

## Reasoning & Planning

### Chain-of-Thought Prompting Elicits Reasoning in Large Language Models
- **Authors**: Jason Wei et al. (Google)
- **Date**: January 2022
- **Paper**: [arXiv:2201.11903](https://arxiv.org/abs/2201.11903)

**Summary**: Demonstrates that prompting LLMs with chain-of-thought (step-by-step reasoning) examples significantly improves performance on complex reasoning tasks. Shows 40%+ improvements on math word problems and commonsense reasoning.

**Key Insight**: Breaking down problems into intermediate reasoning steps unlocks LLM reasoning capabilities that aren't apparent in single-step generation.

---

### Tree of Thoughts: Deliberate Problem Solving with Large Language Models
- **Authors**: Shunyu Yao et al. (Princeton)
- **Date**: May 2023
- **Paper**: [arXiv:2305.10601](https://arxiv.org/abs/2305.10601)

**Summary**: Extends chain-of-thought by maintaining a tree of reasoning paths. The model can explore multiple reasoning branches, evaluate them, and backtrack. Achieves 74% on Game of 24 vs 4% for CoT. Uses search algorithms (BFS/DFS) over the reasoning tree.

**Key Insight**: Explicit search over reasoning paths enables systematic exploration and deliberate decision-making in LLMs.

---

### Reflexion: Language Agents with Verbal Reinforcement Learning
- **Authors**: Noah Shinn et al. (Northeastern, MIT)
- **Date**: March 2023
- **Paper**: [arXiv:2303.11366](https://arxiv.org/abs/2303.11366)

**Summary**: Introduces Reflexion, where agents reflect on task feedback in natural language and maintain reflective text in episodic memory. Achieves 91% pass@1 on HumanEval coding tasks (up from 62%). Uses self-reflection to improve without parameter updates.

**Key Insight**: Natural language feedback and episodic memory enable effective reinforcement learning for language agents without retraining.

---

## Context Management & Engineering

### A Survey of Context Engineering for Large Language Models
- **Authors**: Lingrui Mei et al. (CAS, Tsinghua)
- **Date**: July 2025
- **Paper**: [arXiv:2507.13334](https://arxiv.org/abs/2507.13334)

**Summary**: Comprehensive survey introducing Context Engineering as a formal discipline. Decomposes it into retrieval, generation, processing, and management components. Analyzes 1400+ papers and identifies a critical gap: models are good at understanding complex contexts but poor at generating sophisticated long-form outputs.

**Key Insight**: Context Engineering transcends prompt design to encompass systematic optimization of information payloads for LLMs.

---

### LLMs Get Lost In Multi-Turn Conversation
- **Authors**: Philippe Laban et al. (Microsoft)
- **Date**: May 2025
- **Paper**: [arXiv:2505.06120](https://arxiv.org/abs/2505.06120)

**Summary**: Large-scale simulation showing all top LLMs exhibit 39% average performance drop in multi-turn vs single-turn conversations. Analysis of 200k+ conversations shows degradation comes from increased unreliability (making assumptions early) rather than lost aptitude. Models don't recover when they take a wrong turn.

**Key Insight**: Multi-turn reliability is a fundamental challenge requiring explicit handling, not just more context.

---

### Effective Harnesses for Long-Running Agents
- **Authors**: Anthropic Research Team
- **Date**: November 2025
- **Paper**: [Blog Post](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)

**Summary**: Presents patterns for agents working across multiple context windows. Key techniques: initializer agent for setup, coding agent for incremental progress, feature checklists, git commits, and progress artifacts. Shows how to enable agents to work on projects spanning hours or days.

**Key Insight**: Long-running agents need explicit state management through files and git, not just context window compaction.

---

## Multi-Agent Systems

### MetaGPT: Meta Programming for Multi-Agent Collaborative Framework
- **Authors**: Sirui Hong et al. (CUHK, DeepWisdom)
- **Date**: August 2023
- **Paper**: [arXiv:2308.00352](https://arxiv.org/abs/2308.00352)

**Summary**: Introduces MetaGPT, encoding Standardized Operating Procedures (SOPs) into prompt sequences. Uses assembly line paradigm with diverse roles (PM, architect, engineer, etc.). Achieves 85%+ on HumanEval and outperforms previous multi-agent systems on software engineering tasks.

**Key Insight**: Structured workflows and role specialization dramatically improve multi-agent collaboration quality.

---

### AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation
- **Authors**: Qingyun Wu et al. (Microsoft)
- **Date**: August 2023
- **Paper**: [arXiv:2308.08155](https://arxiv.org/abs/2308.08155)

**Summary**: Framework for building LLM applications through multi-agent conversations. Supports customizable and conversable agents that can integrate LLMs, tools, and humans. Enables complex workflows through automated chat and built-in conversation patterns.

**Key Insight**: Conversable agents with customizable interaction patterns enable flexible and powerful multi-agent systems.

---

### CAMEL: Communicative Agents for "Mind" Exploration of Large Language Model Society
- **Authors**: Guohao Li et al. (KAUST)
- **Date**: March 2023
- **Paper**: [arXiv:2303.17760](https://arxiv.org/abs/2303.17760)

**Summary**: Proposes role-playing approach where agents communicate autonomously. Uses inception prompting to guide chat agents toward task completion. Demonstrates emergent behaviors and capabilities through agent cooperation.

**Key Insight**: Role-playing and autonomous communication enable scalable exploration of agent capabilities.

---

## Benchmarks & Evaluation

### SWE-bench: Can Language Models Resolve Real-World GitHub Issues?
- **Authors**: Carlos Jimenez et al. (Princeton, OpenAI)
- **Date**: October 2023
- **Paper**: [arXiv:2310.06770](https://arxiv.org/abs/2310.06770)

**Summary**: Benchmark of 2,294 real GitHub issues from 12 Python repositories. Models must generate patches that resolve issues. Current top models achieve ~40-50% on SWE-bench Verified. Has become the standard evaluation for coding agents.

**Key Insight**: Real-world software engineering requires understanding large codebases, not just algorithmic problems.

---

### WebArena: A Realistic Web Environment for Building Autonomous Agents
- **Authors**: Shuyan Zhou et al. (CMU)
- **Date**: July 2023
- **Paper**: [arXiv:2307.13854](https://arxiv.org/abs/2307.13854)

**Summary**: Realistic, standalone web environment with 812 task examples across 5 domains. Tasks require information retrieval, site navigation, and transaction completion. Current best agents achieve ~35% success rate vs ~78% for humans.

**Key Insight**: Web agents need to handle realistic websites with complex navigation, forms, and multi-step workflows.

---

### OSWorld: Benchmarking Multimodal Agents for Open-Ended Tasks in Real Computer Environments
- **Authors**: Tianbao Xie et al. (HKU, UIUC)
- **Date**: April 2024
- **Paper**: [arXiv:2404.07972](https://arxiv.org/abs/2404.07972)

**Summary**: Scalable real computer environment with 369 tasks involving real web and desktop apps, file I/O, and workflows. Requires visual perception and precise mouse/keyboard control. Best models achieve 12-15% vs 72% for humans.

**Key Insight**: Open-ended computer tasks require multimodal understanding and precise interaction with real applications.

---

### AgentBench: Evaluating LLMs as Agents
- **Authors**: Xiao Liu et al. (Tsinghua)
- **Date**: August 2023
- **Paper**: [arXiv:2308.03688](https://arxiv.org/abs/2308.03688)

**Summary**: Multi-dimensional benchmark with 8 environments: OS, Database, Knowledge Graph, Digital Card Game, Lateral Thinking Puzzles, House-Holding, Web Shopping, and Web Browsing. Evaluates reasoning, decision-making, and multi-turn alignment.

**Key Insight**: Agent capabilities vary dramatically across different environments, requiring diverse evaluation.

---

### AgentBoard: An Analytical Evaluation Board of Multi-turn LLM Agents
- **Authors**: Chuyan Xiong et al. (HKUST)
- **Date**: January 2024
- **Paper**: [arXiv:2401.13178](https://arxiv.org/abs/2401.13178)

**Summary**: Benchmark for multi-turn LLM agents with fine-grained progress evaluation. Includes 9 diverse tasks with 1,324 instances. Provides analytical evaluation board for understanding model strengths/weaknesses beyond final success rate.

**Key Insight**: Multi-turn evaluation requires tracking progress, not just binary success/failure.

---

### MLE-bench: Evaluating Machine Learning Agent Engineering
- **Authors**: OpenAI Research Team
- **Date**: October 2024
- **Paper**: [arXiv:2410.07095](https://arxiv.org/abs/2410.07095)

**Summary**: Benchmark of 75 ML engineering competitions from Kaggle. Evaluates agents on real ML engineering tasks including data preprocessing, model training, and submission generation. o1-preview achieved 16.9% bronze medals with AIDE framework.

**Key Insight**: ML engineering requires combining research knowledge with practical implementation skills.

---

## Long-Horizon Task Execution

### Measuring AI Ability to Complete Long Tasks (METR Time Horizons)
- **Authors**: David Rein et al. (METR)
- **Date**: March 2025
- **Paper**: [arXiv:2503.14499](https://arxiv.org/abs/2503.14499)

**Summary**: Proposes measuring AI by task length (human time) it can complete. Shows task horizon doubling every ~7 months for 6 years. Claude 3.7 Sonnet achieves ~1 hour 50% success rate. Predicts models will handle week-long tasks within decade.

**Key Insight**: Task completion length grows exponentially, making it a robust forecasting metric.

---

### The Agent's Marathon: Robust Multisession Autonomous Language Modeling
- **Authors**: Machel Reid et al. (Google DeepMind)
- **Date**: 2025
- **Paper**: [OpenReview](https://openreview.net/pdf?id=dAn82lpLx4)

**Summary**: Evaluates agents on long-horizon tasks requiring multiple sessions. Proposes methods for maintaining coherence across sessions including summarization, memory management, and checkpointing.

**Key Insight**: Long-horizon tasks require explicit session management, not just longer contexts.

---

## Tool Use & Function Calling

### Gorilla: Large Language Model Connected with Massive APIs
- **Authors**: Shishir Patil et al. (UC Berkeley)
- **Date**: May 2023
- **Paper**: [arXiv:2305.15334](https://arxiv.org/abs/2305.15334)

**Summary**: Fine-tuned LLM for API calling. Trained on 1,600+ API documentation. Outperforms GPT-4 on API call accuracy. Introduces APIBench dataset for training and evaluation.

**Key Insight**: Fine-tuning on API documentation enables more accurate tool use than in-context learning alone.

---

### Toolformer: Language Models Can Teach Themselves to Use Tools
- **Authors**: Timo Schick et al. (Meta AI)
- **Date**: February 2023
- **Paper**: [arXiv:2302.04761](https://arxiv.org/abs/2302.04761)

**Summary**: Language model that teaches itself to use external tools (calculator, search, translation, calendar) through simple API calls. Achieves strong performance improvements without losing language modeling ability.

**Key Insight**: Models can learn to use tools self-supervised by predicting which tool calls would be helpful.

---

### Berkeley Function Calling Leaderboard (BFCL)
- **Authors**: Yanjun Shao et al. (UC Berkeley)
- **Date**: 2023
- **Paper**: [Project Site](https://gorilla.cs.berkeley.edu/leaderboard.html)

**Summary**: Comprehensive leaderboard for evaluating function calling capabilities. Tests various scenarios including single function, multiple functions, parallel function calls, and function relevance detection. Updated regularly with new models.

**Key Insight**: Function calling requires handling diverse scenarios including relevance detection and parallel execution.

---

## Recent Surveys

### The Rise and Potential of Large Language Model Based Agents: A Survey
- **Authors**: Wayne Xin Zhao et al. (Renmin University)
- **Date**: September 2023
- **Paper**: [arXiv:2309.07864](https://arxiv.org/abs/2309.07864)

**Summary**: Comprehensive survey of LLM-based agents. Covers agent architecture (brain, perception, action), agent capabilities (reasoning, planning, tool use), and applications (social science, natural science, engineering). Identifies key challenges and future directions.

---

### Large Language Model based Multi-Agents: A Survey of Progress and Challenges
- **Authors**: Weiran Wang et al.
- **Date**: 2024
- **Paper**: [arXiv:2402.16880](https://arxiv.org/abs/2402.16880)

**Summary**: Survey of multi-agent systems based on LLMs. Categorizes by communication patterns, agent roles, and coordination mechanisms. Analyzes applications and open problems.

---

### A Survey on Large Language Model based Autonomous Agents
- **Authors**: Lei Wang et al. (Southeast University)
- **Date**: August 2023
- **Paper**: [arXiv:2308.11432](https://arxiv.org/abs/2308.11432)

**Summary**: Survey focusing on design patterns for autonomous agents. Covers agent architecture, capabilities, and applications. Proposes unified framework for understanding agent systems.

---

## Citation Guide

When citing these papers, use the following format:

```bibtex
% ReAct (Foundational)
@article{yao2022react,
  title={ReAct: Synergizing Reasoning and Acting in Language Models},
  author={Yao, Shunyu and others},
  journal={arXiv preprint arXiv:2210.03629},
  year={2022}
}

% Context Engineering Survey
@article{mei2025context,
  title={A Survey of Context Engineering for Large Language Models},
  author={Mei, Lingrui and others},
  journal={arXiv preprint arXiv:2507.13334},
  year={2025}
}

% METR Time Horizons
@article{rein2025measuring,
  title={Measuring AI Ability to Complete Long Tasks},
  author={Rein, David and others},
  journal={arXiv preprint arXiv:2503.14499},
  year={2025}
}
```

---

*Last Updated: March 1, 2026*
