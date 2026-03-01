# ReAct: Synergizing Reasoning and Acting in Language Models

**Authors**: Shunyu Yao, Jeffrey Zhao, Dian Yu, Nan Du, Izhak Shafran, Karthik Narasimhan, Yuan Cao  
**Institution**: Princeton University, Google Research  
**Published**: October 2022 (ICLR 2023)  
**Paper**: [arXiv:2210.03629](https://arxiv.org/abs/2210.03629)  
**Code**: [github.com/ysymyth/ReAct](https://github.com/ysymyth/ReAct)

---

## Abstract Summary

While LLMs have demonstrated impressive capabilities in language understanding and interactive decision making, their abilities for reasoning and acting have primarily been studied separately. This paper explores using LLMs to generate both reasoning traces and task-specific actions in an interleaved manner, allowing for greater synergy between the two.

---

## The Core Problem

Traditional approaches treat reasoning and action as separate:
- **Chain-of-Thought (CoT)**: Reasoning only, no external interaction
- **Acting-only**: Action sequences without explicit reasoning

Both approaches have limitations:
- CoT can hallucinate facts and propagate errors
- Acting-only lacks interpretability and can't course-correct

---

## The ReAct Pattern

ReAct interleaves **Reasoning** and **Acting**:

```
Thought 1: I need to find the temperature in New York
Action 1: Search[New York weather today]
Observation 1: It is 72°F and sunny in New York
Thought 2: Now I have the temperature. I need to convert to Celsius
Action 2: Calculate[(72 - 32) × 5/9]
Observation 2: 22.2
Thought 3: The temperature in New York is 22.2°C
Action 3: Finish[22.2°C]
```

### Key Components

| Component | Purpose | Example |
|-----------|---------|---------|
| **Thought** | Reasoning about current state and next action | "I need to find X before I can do Y" |
| **Action** | External interaction | Search, Calculate, Navigate |
| **Observation** | Feedback from environment | Search results, API response |

---

## Results

### Question Answering (HotpotQA)
- **CoT**: 29.4% F1 (hallucinates facts)
- **Act-only**: 25.6% F1 (no reasoning)
- **ReAct**: 34.2% F1 (+4.8% over CoT)

Key finding: ReAct overcomes hallucination and error propagation by interacting with Wikipedia API.

### Fact Verification (Fever)
- **CoT**: 86.2% accuracy
- **Act-only**: 85.8% accuracy
- **ReAct**: 90.1% accuracy

### Interactive Decision Making (ALFWorld)
- **Imitation Learning**: 37.3% success
- **RL Method**: 49.1% success
- **ReAct**: 71.0% success (+21.9% over RL)

With only 1-2 in-context examples!

### WebShop
- **Imitation Learning**: 27.0% success
- **RL Method**: 29.1% success
- **ReAct**: 39.2% success (+10.1% over RL)

---

## Why ReAct Works

1. **Grounding**: Actions ground reasoning in external reality
2. **Interpretability**: Reasoning traces make agent behavior understandable
3. **Controllability**: Can steer agent through reasoning guidance
4. **Robustness**: Can recover from errors through observation feedback

---

## Implementation in OpenCode

ReAct is the foundation of most modern agent frameworks:

```json
// OpenCode agent configuration
{
  "system": "You are a helpful assistant that thinks step by step. " +
            "For each step, first think about what you need to do, " +
            "then take an action using available tools.",
  
  "format": "Always format your response as:\n" +
            "Thought: [your reasoning]\n" +
            "Action: [tool name] [parameters]"
}
```

### Example Session

```
User: What's the weather in Paris?

Assistant:
Thought: The user wants to know the weather in Paris. 
I should use the weather tool to get current conditions.

Action: get_weather {"location": "Paris"}

[Tool returns: {"temp": 18, "condition": "cloudy"}]

Thought: I now have the weather data. I'll present it clearly.

Action: respond {"message": "It's 18°C and cloudy in Paris."}
```

---

## Extensions of ReAct

### Reflexion (Self-Reflection)
Adds explicit reflection step when errors occur:
```
Thought → Action → Observation → [Error detected] → Reflection → Retry
```

### ReAct + Planning
Combine with tree search for complex multi-step tasks.

### Multi-Agent ReAct
Each agent follows ReAct pattern, agents communicate via shared observations.

---

## Limitations

1. **Context Window**: Long ReAct traces can exceed context limits
2. **Error Propagation**: One wrong action can derail entire trace
3. **Tool Dependency**: Requires well-designed tools/actions
4. **Latency**: Multiple turns slower than single-shot

---

## Key Takeaways

1. **Interleaving matters**: Reasoning + Acting > Reasoning or Acting alone
2. **Observations ground reasoning**: External feedback prevents hallucination
3. **Interpretability**: Reasoning traces make agents debuggable
4. **Simplicity**: Works with 1-2 examples, no fine-tuning needed

---

## Citation

```bibtex
@inproceedings{yao2023react,
  title={ReAct: Synergizing Reasoning and Acting in Language Models},
  author={Yao, Shunyu and Zhao, Jeffrey and Yu, Dian and Du, Nan and 
          Shafran, Izhak and Narasimhan, Karthik and Cao, Yuan},
  booktitle={International Conference on Learning Representations (ICLR)},
  year={2023}
}
```

---

*Last Updated: March 1, 2026*
