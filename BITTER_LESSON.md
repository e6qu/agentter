# The Bitter Lesson: Sutton's Most Influential Essay and Its Reverberations

*A comprehensive analysis of the most cited informal essay in modern AI, the debates it ignited, and its continuing relevance in the age of agents.*

---

## Table of Contents

1. [The Original Essay](#the-original-essay)
2. [The Historical Evidence](#the-historical-evidence)
3. [The Debate](#the-debate)
   - [Supporters: The Scaling Maximalists](#supporters-the-scaling-maximalists)
   - [Critics: The Skeptics and Structuralists](#critics-the-skeptics-and-structuralists)
   - [The Middle Ground: The Bittersweet Lesson](#the-middle-ground-the-bittersweet-lesson)
4. [Impact on AI Agents](#impact-on-ai-agents)
5. [The Lesson in 2026](#the-lesson-in-2026)
6. [Timeline](#timeline)
7. [Key Quotes Collection](#key-quotes-collection)
8. [Cross-References](#cross-references)

---

## The Original Essay

### Who Is Richard Sutton?

Richard S. Sutton (born c. 1957, Ohio) is one of the founding figures of modern reinforcement learning and a 2024 Turing Award recipient (shared with Andrew Barto). He earned his B.A. in psychology from Stanford (1978), then an M.S. (1980) and Ph.D. (1984) in computer science. After positions at GTE Laboratories and AT&T Labs, he joined the University of Alberta in 2003, where he established the Reinforcement Learning and Artificial Intelligence (RLAI) Laboratory.

His contributions span temporal-difference learning, the actor-critic class of policy gradient algorithms, the Dyna architecture (integrating learning, planning, and reacting), and the Horde architecture for parallel value-function learning. His co-authored textbook with Andrew Barto, *Reinforcement Learning: An Introduction* (1998; 2nd edition 2018), has been cited over 88,000 times and remains the standard reference in the field. In 2024, he co-founded Keen Technologies to pursue what he calls "full intelligence" through reinforcement learning, and with John Carmack contributed to *The Alberta Plan for AI Research* — a long-term, curiosity-driven roadmap for AGI.

This is not a peripheral figure offering hot takes. Sutton's essay carries the weight of someone who has spent four decades watching AI approaches rise and fall.

### When and Why He Wrote It

On **March 13, 2019**, Sutton published a short, informal essay titled "The Bitter Lesson" on his personal website (incompleteideas.net). It was not a peer-reviewed paper — just ~1,600 words on a plain HTML page. Yet it became arguably the most influential piece of informal writing in modern AI, cited in keynotes, boardrooms, and funding pitches worldwide.

Sutton wrote it out of frustration. He had watched, over and over across decades of AI research, a recurring pattern: researchers would painstakingly engineer domain-specific knowledge into systems, achieve impressive short-term results, and then be overtaken by simpler systems that just used more computation. The lesson, he argued, was clear — but researchers kept failing to learn it. Hence "bitter": the truth was unpalatable because it undermined the value of human cleverness.

### The Core Argument

Sutton's thesis is crystallized in one sentence:

> "The biggest lesson that can be read from 70 years of AI research is that general methods that leverage computation are ultimately the most effective, and by a large margin."

He identifies **two general-purpose methods** that scale arbitrarily with available compute:

1. **Search** — systematically exploring possibility spaces (game trees, hypothesis spaces, solution landscapes)
2. **Learning** — automatically extracting patterns and structure from data

These two methods, Sutton argues, have consistently outperformed approaches that try to encode human knowledge directly. The lesson is "bitter" because it is less anthropocentric than researchers expected — human insight about problem structure, while helpful in the short term, ultimately "plateaus and even inhibits further progress."

> "One thing that should be learned from the bitter lesson is the great power of general purpose methods, of methods that continue to scale with increased computation even as the available computation becomes very great."

Sutton concludes that time is better invested in finding simple, scalable solutions that can ride the exponential curve of Moore's Law than in introducing ever-more-complex human-designed features.

---

## The Historical Evidence

Sutton draws on multiple domains to make his case. Each tells the same story: domain experts design clever systems, then brute-force computation surpasses them.

### Chess (1997)

The first systems to play chess relied heavily on human knowledge — opening books, endgame databases, piece-square tables tuned by grandmasters. But IBM's **Deep Blue**, which defeated Garry Kasparov in 1997, relied on a relatively simple alpha-beta search algorithm scaled up with massive specialized hardware to evaluate 200 million positions per second. The human knowledge approach was not what won; raw search was. Later, the Stockfish and AlphaZero lineage would reinforce this: AlphaZero (2017) learned chess entirely through self-play with zero human chess knowledge beyond the rules, defeating Stockfish convincingly.

### Go (2016)

Go was supposed to be the domain where human intuition was irreplaceable — the branching factor (~250 vs. ~35 in chess) made brute-force search seem hopeless. For decades, the strongest Go programs used hand-crafted heuristics and pattern libraries compiled by expert players. Then DeepMind's **AlphaGo** defeated Lee Sedol 4-1 in March 2016 using deep neural networks combined with Monte Carlo tree search. Its successor, **AlphaGo Zero** (2017), eliminated all human game knowledge entirely, learning solely from self-play — and was even stronger.

### Speech Recognition

Early speech recognition systems (1970s-2000s) were built around Hidden Markov Models enriched with extensive linguistic knowledge: phoneme models, pronunciation dictionaries, language models hand-tuned by linguists. The modern era replaced all of this with end-to-end deep learning models trained on massive corpora. Systems like DeepSpeech and Whisper use general-purpose neural architectures with no hand-coded linguistic rules, trained on enormous datasets — and they are dramatically better.

### Computer Vision (2012)

Before 2012, computer vision relied on hand-engineered feature extractors — SIFT, HOG, Haar cascades — designed by researchers who understood visual structure. **AlexNet** (Krizhevsky, Sutskever, Hinton, 2012) shattered this paradigm at ImageNet, using a deep convolutional neural network trained on GPUs. It reduced the error rate by nearly half compared to the best hand-engineered systems. The features learned by the network were not designed by humans — they emerged from data and compute. Every subsequent breakthrough in vision (VGG, ResNet, Vision Transformers) followed the same pattern: more parameters, more data, more compute.

### Natural Language Processing

NLP was historically a bastion of human-engineered structure: parse trees, part-of-speech taggers, named entity recognizers, sentiment lexicons, hand-built ontologies. The field was transformed by the Transformer architecture (2017), then by scaling: GPT-2 (2019), GPT-3 (2020), GPT-4 (2023), and their competitors. Systems trained with no linguistic rules whatsoever — just next-token prediction on web-scale text — now outperform all prior hand-engineered NLP systems on virtually every benchmark.

### Game Playing Beyond Chess and Go

Atari (DQN, 2013), StarCraft II (AlphaStar, 2019), Dota 2 (OpenAI Five, 2019), Diplomacy (Cicero, 2022) — in each case, systems that learned from self-play or large-scale imitation with minimal hand-coded strategy outperformed those with extensive domain engineering.

### Protein Folding (2020)

DeepMind's **AlphaFold2** achieved a median GDT score of 92.4 at CASP14, effectively solving the protein structure prediction problem that had stymied biologists for 50 years. While AlphaFold2 did incorporate structural inductive biases (attention mechanisms mimicking spatial relationships), its success was fundamentally driven by scaling a general learning approach to enormous datasets of protein structures. The hand-coded physics-based folding simulations that dominated for decades were rendered obsolete in a single competition.

---

## The Debate

The Bitter Lesson did not go unchallenged. It ignited one of the most productive intellectual disputes in modern AI.

### Supporters: The Scaling Maximalists

#### The Gwern / OpenAI Thesis

Gwern Branwen's influential 2020 essay "The Scaling Hypothesis" provided the theoretical and empirical framework for the scaling maximalist position. He argued that neural networks "absorb data & compute, generalizing and becoming more Bayesian as problems get harder, manifesting new abilities even at trivial-by-global-standards-scale." GPT-3 was the first dramatic proof: over 100x bigger than GPT-2, using the same architecture, it exhibited wholly unexpected emergent abilities — few-shot learning, code generation, chain-of-thought reasoning — that no one had explicitly designed.

#### GPT-3 and GPT-4 as Validation

GPT-3 (2020) was perhaps the single most powerful piece of evidence for the Bitter Lesson since AlphaGo. A general-purpose model, trained with no task-specific engineering, outperformed hand-crafted systems across hundreds of benchmarks. GPT-4 (2023) extended this further: a research team carefully fine-tuned GPT-3.5 to create BloombergGPT for finance-specific tasks, but when GPT-4 arrived — a model using more compute, more data, and more parameters with no finance-specific training — it outperformed BloombergGPT even on finance questions. The lesson was stark: human ingenuity in fine-tuning lost to general scaling.

#### Jensen Huang's Trillion-Dollar Bet

No one has bet more money on the Bitter Lesson than Jensen Huang. NVIDIA's entire strategy — from the A100 to the H100 to the B200 — is predicated on the assumption that AI progress equals more compute. Huang has outlined a vision of $3-4 trillion in total installed AI compute infrastructure over the coming decade, driven by what he calls "structurally infinite" demand across three curves: token economics, agentic AI, and physical AI. As of 2026, NVIDIA's inference-focused strategy (announced at GTC 2026) represents the Bitter Lesson translated into corporate strategy: the next boom belongs to inference-time compute, not just training.

#### Sam Altman and "The Gentle Singularity"

In mid-2025, Altman wrote: "We already know how to build AGI. In 2026, we will see systems that can generate original insights." He firmly believes that scaling laws are far from their ceiling and that the cost of intelligence will approach zero. This is the Bitter Lesson taken to its logical endpoint: intelligence as a commodity produced by compute.

### Critics: The Skeptics and Structuralists

#### Rodney Brooks: "A Better Lesson"

Robotics pioneer Rodney Brooks (co-founder of iRobot, Rethink Robotics) published a direct rebuttal titled **"A Better Lesson"** on his blog. His core arguments:

1. **Human ingenuity is hidden in the compute.** All of Sutton's examples of "general methods" are themselves the product of enormous human ingenuity. Deep neural networks would not perform as well without the translational invariance of convolutional layers — an insight that did not emerge from scaling but from understanding visual structure. The Transformer's attention mechanism was a human invention. You cannot cleanly separate "general methods" from "human knowledge."

2. **The energy argument.** The breakdown of Dennard scaling (2006) means power consumption rises with compute. A self-driving car requires ~2,500 watts for computation; a human brain runs on ~20 watts. Sutton's argument, taken literally, makes AI impractical for many real-world applications.

3. **Total cost matters.** A "better lesson" is that we must account for the total cost of any solution — compute, energy, data collection, human oversight, deployment engineering. Scaling is not free.

#### Francois Chollet and ARC-AGI

Francois Chollet, creator of Keras and the ARC-AGI benchmark, provides perhaps the most empirically grounded critique. His key arguments:

1. **ARC resists scaling.** GPT-3 scored 0% on ARC. GPT-4 scored near 0%. GPT-4o reached only 5%. Even after a 50,000x scale-up of pre-trained base models, ARC performance stayed near zero. This is Chollet's strongest evidence: there exist domains where the Bitter Lesson simply does not apply at the pre-training level.

2. **Memorization is not intelligence.** Chollet distinguishes between "memorized skills" (static, task-specific patterns absorbed during training) and "fluid general intelligence" (the ability to solve novel problems on the fly). LLMs excel at the former but struggle with the latter. Scaling up memorization does not produce genuine reasoning.

3. **The end of the pre-training scaling era.** Chollet argues that the 2020-2024 period was an era where scaling pre-training crushed benchmarks — but this led the community to confuse performance on known tasks with genuine intelligence. The real frontier requires test-time adaptation, not just bigger models.

#### Gary Marcus: Scaling Laws Are "Mere Observations"

Gary Marcus, cognitive scientist and persistent AI critic, has argued since 2019 that scaling laws are empirical generalizations rather than physical laws — "mere observations that might not hold forever, much like Moore's Law, a trend in computer chip production that held for decades but arguably began to slow." He claims that pure scaling of LLMs will not lead to AGI and that the field needs fundamentally new architectures incorporating structured representations, systematic compositionality, and causal reasoning.

In a notable 2025 blog post titled "Game over for pure LLMs," Marcus pointed out that even Turing Award winner Rich Sutton himself had moved beyond pure scaling advocacy — Sutton's Alberta Plan and Keen Technologies both pursue reinforcement learning agents that actually interact with environments, not just larger language models.

#### Yann LeCun: JEPA and World Models

Yann LeCun (Turing Award 2018, Meta Chief AI Scientist) represents a particularly interesting case: a deep learning pioneer who has become one of the strongest critics of the LLM scaling paradigm. His position:

1. **LLMs are a dead end for many problems.** Autoregressive next-token prediction cannot capture the structure of the physical world. "Breakthroughs are not going to come from scaling up LLMs."

2. **JEPA as an alternative.** LeCun's Joint Embedding Predictive Architecture (JEPA) learns to predict outcomes in a compressed representation space rather than generating tokens one at a time. V-JEPA (for video) does not reconstruct pixels but learns abstract representations of visual dynamics — fundamentally different from the generative paradigm.

3. **AMI Labs.** In January 2026, LeCun formally unveiled Advanced Machine Intelligence (AMI Labs), a new startup with a $1.03B seed round at a $3.5B pre-money valuation, focused on building "world models" — AI that understands the dynamics of the physical world. This is a billion-dollar bet *against* the Bitter Lesson's simplest interpretation.

### The Middle Ground: The Bittersweet Lesson

A growing contingent argues that the Bitter Lesson is not wrong but incomplete — and that framing it as "scale vs. structure" is a false dichotomy.

#### Test-Time Compute as Synthesis

The emergence of test-time compute scaling (OpenAI o1, DeepSeek-R1) in 2024-2025 represents a potential synthesis. These systems do not just scale pre-training compute — they scale *inference-time reasoning*, generating 10-100x more tokens per query through extended chain-of-thought. DeepSeek-R1 improved AIME benchmark accuracy from 15.6% to 71% through longer thinking, reaching 86.7% with majority voting. This is neither pure pre-training scale nor hand-engineered reasoning — it is a learned reasoning process that consumes more compute at inference time.

Analysts project inference will claim 75% of total AI compute by 2030. OpenAI's 2024 inference spend reached $2.3 billion — 15x the training cost for GPT-4.5. The Bitter Lesson may be evolving: it is not just training compute that matters, but compute applied at the right time and in the right way.

#### Sutton Himself Noted the Nuance

Sutton's original essay acknowledges that search and learning "need not run counter to" incorporating human knowledge — but notes that "in practice they tend to." The bittersweet reading is that human insights are most valuable when they take the form of *inductive biases* that help general methods scale more efficiently (e.g., the convolution operation, the attention mechanism, the Transformer architecture itself) rather than domain-specific rules that resist scaling.

#### The Chinchilla Correction

DeepMind's **Chinchilla** paper (Hoffmann et al., 2022) showed that existing large language models were significantly *undertrained* — the optimal balance was ~20 tokens per parameter. A 70B-parameter model trained on 1.4 trillion tokens outperformed a 280B model trained on fewer tokens. This was a refinement of the Bitter Lesson: it is not just "more compute" but "compute allocated wisely between model size and data." Human insight about *how* to scale matters, even if scaling itself is the right direction.

---

## Impact on AI Agents

The Bitter Lesson creates a fundamental tension in the AI agent ecosystem: **should you scale the model or build a better harness?**

### The "Just Scale the Model" Camp

If the Bitter Lesson is fully correct, then the optimal strategy for building AI agents is simple: use the biggest, most capable foundation model available and give it minimal scaffolding. Improvements come from the model getting better, not from engineering around the model's limitations. In this view, elaborate agent frameworks, multi-step planning systems, and tool-use orchestration are all temporary scaffolding that will be rendered unnecessary by the next generation of models.

### The "Build Better Harnesses" Camp

Practitioners building real-world agents — the people behind Claude Code, Codex CLI, Aider, and similar tools — operate daily in the gap between what models can do and what users need. Their approach is inherently anti-Bitter-Lesson in spirit: they invest heavily in prompt engineering, context management, tool orchestration, retry logic, output parsing, and multi-agent coordination. These are all forms of human-engineered structure wrapped around general-purpose models.

### How Current Tools Navigate This Tension

- **Claude Code** represents a middle path: it relies on an extremely capable foundation model (Claude) but wraps it in significant engineering — file reading strategies, diff-based editing tools, git integration, permission systems, and hooks. The model does the reasoning; the harness manages the workflow.

- **Codex CLI** (OpenAI) leans more toward the Bitter Lesson side: its bet is that models will become capable enough that minimal scaffolding suffices, with the model itself deciding when and how to use tools.

- **Aider** invests heavily in harness engineering: repository maps, edit formats, linting integration, git automation — all human-designed structure that compensates for model limitations.

The pragmatic conclusion: the Bitter Lesson is probably directionally correct (models will improve and some scaffolding will become unnecessary), but the timeline is uncertain, and in the meantime, thoughtful engineering creates enormous value.

---

## The Lesson in 2026

### Where It Was Right

1. **Large Language Models.** The progression from GPT-2 to GPT-3 to GPT-4 to Claude 3.5/4 to Gemini Ultra is the most dramatic vindication of the Bitter Lesson in history. General-purpose next-token prediction, scaled up with more compute and data, produced capabilities that no amount of hand-engineering could have achieved. Few-shot learning, chain-of-thought reasoning, code generation, multilingual fluency — none were explicitly designed.

2. **Image Generation.** DALL-E, Midjourney, Stable Diffusion — all succeeded by scaling diffusion models on large image-text datasets. Earlier approaches using hand-crafted image priors (GANs with careful architectural engineering) were supplanted by simpler, more scalable approaches.

3. **Protein Folding.** AlphaFold2's success demonstrated that scaling learned representations could solve problems that decades of physics-based simulation could not.

4. **Game Playing.** From Atari to StarCraft to Diplomacy, the pattern held: learned policies from self-play or large-scale imitation outperformed hand-coded strategies.

### Where It Was Incomplete

1. **Robotics.** Physical AI remains stubbornly resistant to the "just scale it" approach. Battery life is the single most critical bottleneck preventing humanoid robots from industrial deployment. No humanoid company has demonstrated sustained months of reliable factory operation. A former Agility Robotics CPO stated in 2025: "AI is not robust enough to meet the requirements of the market." The real world has latency, friction, breakage, and unpredictability that scale alone does not solve.

2. **AI Safety and Alignment.** Sutton's "second bitter lesson" — articulated by others building on his framework — argues that alignment, like capability, may resist hand-engineering. But the stakes are qualitatively different: a chess program that fails degrades gracefully; a misaligned superintelligent agent does not. The safety community argues that "just scale general methods" is exactly the wrong approach for alignment, where we need formal guarantees, interpretability, and carefully designed constraints.

3. **Reliability and Hallucination.** As of 2026, even the most capable LLMs still hallucinate, still make elementary logical errors, and still fail on tasks requiring precise multi-step reasoning. Scaling has dramatically reduced but not eliminated these problems. Jensen Huang himself acknowledged in 2025 that solving hallucination is "several years away" and "requires increasing computation" — an honest admission that more compute is necessary but not sufficient.

4. **Economic and Environmental Cost.** Brooks' energy critique has only gotten sharper. Training frontier models costs hundreds of millions of dollars. Global AI infrastructure spending is projected at $700B+ annually. The Bitter Lesson's implicit assumption — that compute is cheap and getting cheaper — runs into physical limits around power generation, cooling, and chip fabrication.

---

## Timeline

| Year | Event | Bitter Lesson Relevance |
|------|-------|------------------------|
| **1997** | Deep Blue defeats Kasparov | Search at scale beats human chess knowledge |
| **2006** | Dennard scaling breaks down | Power costs begin to complicate "just add compute" |
| **2012** | AlexNet wins ImageNet | Learned features crush hand-engineered vision |
| **2013** | DQN plays Atari | RL + neural nets beat hand-coded game strategies |
| **2016** | AlphaGo defeats Lee Sedol | General learning + search beats Go intuition |
| **2017** | "Attention Is All You Need" | The Transformer: human insight enabling massive scaling |
| **2017** | AlphaGo Zero: zero human knowledge | The purest Bitter Lesson victory in games |
| **2019** | Sutton publishes "The Bitter Lesson" | The observation is named and codified |
| **2020** | GPT-3 (175B parameters) | Emergent abilities from scale shock the field |
| **2020** | AlphaFold2 solves protein folding | 50-year biology problem falls to scaled learning |
| **2022** | Chinchilla scaling laws | Refinement: how to scale matters, not just how much |
| **2022** | ChatGPT launches | Scaled models reach mainstream, billions of users |
| **2023** | GPT-4 | Outperforms domain-specific fine-tuned models on their own domains |
| **2024** | OpenAI o1 / test-time compute | New scaling dimension: inference-time reasoning |
| **2024** | Sutton wins Turing Award | The Bitter Lesson's author receives computing's highest honor |
| **2024** | Sutton co-founds Keen Technologies | Bets on RL agents, not just larger LLMs |
| **2025** | DeepSeek-R1 matches o1 at 70% lower cost | Test-time compute scaling proves robust and transferable |
| **2025** | Chollet's ARC-AGI resists scaling | Evidence that pre-training scale alone has limits |
| **2026** | LeCun launches AMI Labs ($1B) | A billion-dollar bet *against* the LLM scaling paradigm |
| **2026** | The agent era | Scale + structure: the pragmatic synthesis |

---

## Key Quotes Collection

### From the Essay Itself

> "The biggest lesson that can be read from 70 years of AI research is that general methods that leverage computation are ultimately the most effective, and by a large margin."
> — Richard Sutton, "The Bitter Lesson" (2019)

> "One thing that should be learned from the bitter lesson is the great power of general purpose methods, of methods that continue to scale with increased computation even as the available computation becomes very great."
> — Richard Sutton

> "The two methods that seem to scale arbitrarily in this way are search and learning."
> — Richard Sutton

### From the Supporters

> "We already know how to build AGI. In 2026, we will see systems that can generate original insights."
> — Sam Altman, "The Gentle Singularity" (2025)

> "Every year, smart people bet against scaling. Every year, scaling wins."
> — Paraphrased summary of the scaling maximalist position

> "Neural nets absorb data & compute, generalizing and becoming more Bayesian as problems get harder, manifesting new abilities even at trivial-by-global-standards-scale."
> — Gwern Branwen, "The Scaling Hypothesis" (2020)

### From the Critics

> "A better lesson to be learned is that we have to take into account the total cost of any solution, and that so far they have all required substantial amounts of human ingenuity."
> — Rodney Brooks, "A Better Lesson"

> "ARC has completely resisted the pre-training scaling paradigm. Even after a 50,000x scale-up of pre-trained base models, the performance stayed near zero."
> — Francois Chollet, on why scaling alone is insufficient

> "Scaling laws are mere observations that might not hold forever, much like Moore's Law, a trend in computer chip production that held for decades but arguably began to slow."
> — Gary Marcus

> "Breakthroughs are not going to come from scaling up LLMs."
> — Yann LeCun

> "Game over for pure LLMs. Even Turing Award winner Rich Sutton has gotten off the bus."
> — Gary Marcus (2025), noting Sutton's own evolution beyond pure LLM scaling

### From the Middle Ground

> "Solving AI hallucination problems is several years away [and] requires increasing computation."
> — Jensen Huang (2025), acknowledging compute is necessary but not sufficient

> "AI is not robust enough to meet the requirements of the market."
> — Former Agility Robotics CPO (2025), on the limits of scaling in robotics

---

## Cross-References

- **[FAMOUS_SPATS.md](FAMOUS_SPATS.md)** — See "Richard Sutton's Bitter Lesson and Its Discontents" and "Francois Chollet vs. Scaling Maximalists" for detailed accounts of the public debates this essay ignited.
- **[PAPERS.md](PAPERS.md)** — See entries on "Attention Is All You Need" (the Transformer that made scaling possible), Chinchilla scaling laws, and foundational architecture papers.
- **[PROMINENT_PEOPLE.md](PROMINENT_PEOPLE.md)** — Profiles of Richard Sutton, Yann LeCun, Gary Marcus, Francois Chollet, Rodney Brooks, Sam Altman, Jensen Huang, and other figures in this debate.
- **[TERMINOLOGY.md](TERMINOLOGY.md)** — Definitions of scaling laws, emergent abilities, test-time compute, reinforcement learning, and other key concepts referenced throughout this document.
- **[MODELS.md](MODELS.md)** — Specifications and comparisons of GPT-3, GPT-4, Claude, Gemini, and other models that serve as evidence in the scaling debate.
- **[METHODOLOGIES.md](METHODOLOGIES.md)** — How the tension between "scale the model" and "build better harnesses" plays out in practical agent development workflows.

---

*Last Updated: March 18, 2026.*
