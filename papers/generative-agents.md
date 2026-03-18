# Generative Agents: Interactive Simulacra of Human Behavior

**Authors**: Joon Sung Park, Joseph C. O'Brien, Carrie J. Cai, Meredith Ringel Morris, Percy Liang, Michael S. Bernstein
**Institution**: Stanford University, Google DeepMind
**Published**: April 2023 (ACM UIST 2023)
**Paper**: [arXiv:2304.03442](https://arxiv.org/abs/2304.03442)
**Code**: [github.com/joonspk-research/generative_agents](https://github.com/joonspk-research/generative_agents)

---

## Abstract Summary

This paper introduces generative agents -- computational software agents that simulate believable human behavior. Twenty-five agents are instantiated in a sandbox environment inspired by The Sims, where they autonomously plan their days, share news, form relationships, and coordinate group activities. The agents' architecture extends a large language model with a memory stream that records experiences, a retrieval mechanism that surfaces relevant memories, and a reflection module that synthesizes observations into higher-level abstractions. Evaluations show that agents produce believable individual and emergent social behaviors, including spreading information, forming new relationships, and self-organizing a Valentine's Day party.

---

## The Core Problem

Creating believable, interactive AI characters has been a longstanding challenge in games, simulations, and social science research:

- **Rule-based NPCs**: Traditional game characters follow scripted behavior trees that produce repetitive, predictable actions
- **Finite state machines**: Even sophisticated FSMs lack the ability to respond naturally to novel situations
- **Memory limitations**: Previous approaches lacked persistent memory that accumulates over time and influences future behavior
- **Social dynamics**: Emergent social phenomena (gossip spreading, relationship formation, group coordination) are extremely difficult to hand-code
- **Believability**: The gap between scripted agents and believable "characters" remained large

The question: Can large language models, combined with the right architecture, produce agents that exhibit believable human-like behavior over extended periods?

---

## The Solution: Generative Agent Architecture

### The Smallville Sandbox

The environment is a small town called "Smallville" with:
- Common spaces: a cafe, bar, park, school, dorm, houses
- 25 agents with unique identities, occupations, and relationships
- A day-night cycle with realistic time progression
- Interactive objects (stoves, beds, desks, etc.)

Each agent has:
- A name and biographical description (e.g., "John Lin is a pharmacy shop keeper who loves to help people")
- An initial set of relationships with other agents
- A starting daily routine

### Component 1: Memory Stream

The memory stream is a comprehensive record of the agent's experience, stored as a list of natural language observations with timestamps:

```
[2023-02-13 07:00] Isabella Rodriguez woke up and started her morning routine
[2023-02-13 07:30] Isabella Rodriguez saw the flyer for the Valentine's Day party at Hobbs Cafe
[2023-02-13 08:15] Isabella Rodriguez talked to Maria Lopez about the party
```

All perceptions (things the agent sees and hears) are recorded. The memory stream grows continuously throughout the simulation.

### Component 2: Retrieval

When an agent needs to act or respond, the system retrieves relevant memories using three factors combined into a single score:

1. **Recency**: More recent memories get higher scores (exponential decay)
2. **Importance**: Memories are rated on a 1-10 scale by the LLM at creation time (e.g., "eating breakfast" = 1, "breaking up with partner" = 10)
3. **Relevance**: Cosine similarity between the memory's embedding and the current situation's embedding

```
score = alpha * recency + beta * importance + gamma * relevance
```

The top-k scoring memories are retrieved and included in the agent's prompt.

### Component 3: Reflection

Periodically (triggered when the sum of importance scores for recent memories exceeds a threshold), the agent generates higher-level reflections:

1. The agent is given its 100 most recent memories
2. It generates questions like "What are the most salient high-level observations about [topic]?"
3. For each question, it retrieves relevant memories and synthesizes them into insight statements

Example reflection chain:
- Observation: "Isabella organized a party at Hobbs Cafe"
- Observation: "Isabella invited Klaus to the party"
- Observation: "Isabella made decorations for the party"
- **Reflection**: "Isabella Rodriguez is dedicated to organizing social events and bringing the community together"

Reflections are stored back in the memory stream and can themselves be reflected upon, creating an abstraction hierarchy.

### Component 4: Planning and Reacting

**Planning**: Each morning, agents create a rough plan for the day:
```
1. Wake up and get ready (6:00 - 7:00)
2. Open the pharmacy (8:00 - 12:00)
3. Lunch break (12:00 - 13:00)
4. Continue working (13:00 - 17:00)
5. Walk in the park (17:00 - 18:00)
6. Dinner (18:00 - 19:00)
7. Read before bed (19:00 - 22:00)
```

Plans are recursively decomposed into finer-grained actions (hourly plans decompose into 5-15 minute actions).

**Reacting**: When agents encounter each other or receive new information, they decide whether to continue their current plan or react:
- Retrieved memories about the other agent inform the decision
- If the agent decides to engage, a conversation is generated using both agents' memories
- Conversations are recorded in both agents' memory streams

---

## Results and Emergent Behaviors

### Information Diffusion

Isabella Rodriguez decides to throw a Valentine's Day party and begins telling others. Over two simulated days:
- Isabella mentions the party to 8 agents directly
- Those agents spread the word to others
- By the morning of the party, 12 of 25 agents know about it (through natural conversation chains)
- 5 agents actually attend (having remembered and prioritized the event)

This information spread was **entirely emergent** -- no explicit gossip mechanism was programmed.

### Relationship Formation

New relationships formed during the simulation:
- Two agents discovered shared interests through conversation and began spending more time together
- An agent developed a crush on another through repeated positive interactions
- Agents formed opinions about others based on accumulated experience

### Coordination Without Central Control

The Valentine's Day party required multiple agents to independently:
1. Remember the party was happening
2. Decide to attend (based on their schedule and interest)
3. Navigate to the correct location
4. Arrive at approximately the right time
5. Engage in party-appropriate behavior

All of this happened through individual agent decision-making with no central coordinator.

### Believability Evaluation

Human evaluators assessed agent believability:
- Generative agents were rated as **more believable** than agents using the same architecture but without memory/reflection
- Ablation studies showed each component (memory, retrieval, reflection, planning) contributed to believability
- The full architecture was rated significantly above the ablated versions

| Configuration | Believability Score |
|--------------|-------------------|
| Full architecture | 4.1 / 5.0 |
| Without reflection | 3.5 / 5.0 |
| Without retrieval | 3.1 / 5.0 |
| Without planning | 3.4 / 5.0 |
| LLM-only (no architecture) | 2.8 / 5.0 |

---

## Architecture Details

### Token Usage and Costs

Running 25 agents for two simulated days required:
- Approximately $1,000 in GPT-3.5-turbo API costs (2023 prices)
- Thousands of LLM calls per agent per simulated day
- The memory stream for each agent grows to hundreds of entries

### Prompt Structure

A typical prompt for an agent's action decision includes:
1. Agent's biographical description (~200 tokens)
2. Summary of current situation (~100 tokens)
3. Retrieved relevant memories (~500 tokens)
4. Recent reflections (~200 tokens)
5. Current plan and time (~100 tokens)
6. The question/decision to make (~50 tokens)

### Limitations Observed

- **Hallucinated memories**: Agents occasionally "remembered" events that did not occur
- **Overly polite interactions**: Agents rarely exhibited conflict or disagreement
- **Embellishment**: Agents sometimes exaggerated the significance of mundane events
- **Limited emotional range**: Agents' emotional responses were relatively flat
- **Computational cost**: Running the simulation is expensive and slow

---

## Why This Paper Changed Everything

### 1. Established the Memory-Retrieval-Reflection Pattern

This three-component architecture (memory stream + retrieval + reflection) has become the standard template for agent memory in virtually every subsequent framework:
- **LangChain**: Memory modules follow this pattern
- **AutoGPT**: Adopted similar memory architectures
- **CrewAI, MetaGPT**: Multi-agent systems use variants of this approach

### 2. Demonstrated Emergent Social Behavior

The paper showed that complex social dynamics (information spread, relationship formation, group coordination) can emerge from simple individual agent rules -- a powerful demonstration of emergent behavior in AI systems.

### 3. Connected LLMs to Interactive Environments

Rather than LLMs operating in a text-only vacuum, this work showed how to ground LLMs in a persistent, interactive environment where actions have consequences and history matters.

### 4. Inspired Simulation-Based Research

The paper sparked a wave of research using LLM-based agents for social science, economics, and policy simulation.

---

## Implications for AI Agents

1. **Memory architecture**: The memory stream + retrieval + reflection pattern is now foundational for any agent that needs to operate over extended periods. Coding agents that remember past debugging sessions, user preferences, and project context use variations of this architecture.

2. **Emergent behavior from simple rules**: Complex agent behavior does not need to be explicitly programmed. Given appropriate memory and reflection capabilities, useful behaviors emerge naturally.

3. **Importance scoring**: The idea of scoring memories by importance, recency, and relevance is directly applicable to context management in coding agents -- deciding what information to keep in the context window.

4. **Reflection for abstraction**: Agents that periodically synthesize observations into higher-level insights can build increasingly sophisticated understanding of their tasks and environment.

5. **Multi-agent interaction**: The natural conversation and information-sharing patterns demonstrated here inform how multi-agent coding systems (MetaGPT, AutoGen) structure inter-agent communication.

6. **Persistent identity**: Each agent maintained a consistent personality and set of goals across the simulation, demonstrating that LLMs can sustain coherent character over extended interactions -- important for agents that need to maintain consistent behavior across sessions.

---

## Key Takeaways

1. **Architecture matters more than model size**: The memory-retrieval-reflection architecture produced believable agents even with GPT-3.5, not the most capable model available
2. **Reflection enables abstraction**: Without reflection, agents are reactive; with it, they develop high-level understanding and long-term goals
3. **Emergent behavior is real**: Complex social dynamics emerge from individual agent decisions without central coordination
4. **Retrieval is the bottleneck**: The quality of retrieved memories directly determines the quality of agent decisions -- a lesson that applies broadly to RAG-based systems
5. **Believability requires memory**: Agents without persistent memory are perceived as significantly less believable, reinforcing the importance of context management

---

## Citation

```bibtex
@inproceedings{park2023generative,
  title={Generative Agents: Interactive Simulacra of Human Behavior},
  author={Park, Joon Sung and O'Brien, Joseph C. and Cai, Carrie J. and
          Morris, Meredith Ringel and Liang, Percy and Bernstein, Michael S.},
  booktitle={Proceedings of the 36th Annual ACM Symposium on User Interface Software and Technology (UIST)},
  year={2023}
}
```

---

*Last Updated: March 18, 2026*
