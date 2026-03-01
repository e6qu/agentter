# LLMs Get Lost In Multi-Turn Conversation

**Authors**: Philippe Laban, Chien-Sheng Wu, Lidiya Murakhovs'ka, Paul Bennett, Caiming Xiong, Shafiq Joty, Greg Durrett  
**Institution**: Microsoft Research, Salesforce Research  
**Published**: May 2025  
**Paper**: [arXiv:2505.06120](https://arxiv.org/abs/2505.06120)  
**Code**: [github.com/microsoft/lost_in_conversation](https://github.com/microsoft/lost_in_conversation)

---

## Abstract Summary

While LLMs are conversational interfaces, evaluation has predominantly focused on single-turn, fully-specified instructions. This paper conducts large-scale simulation experiments comparing LLM performance in single- and multi-turn settings across 200,000+ conversations. **All top LLMs exhibit significantly lower performance in multi-turn (39% average drop)**. The degradation comes primarily from increased unreliability—models make assumptions early and don't recover when wrong.

---

## The Multi-Turn Problem

### The Expectation
```
Turn 1: User asks something unclear
Turn 2: LLM asks clarifying question  
Turn 3: User clarifies
Turn 4: LLM provides correct answer
```

### The Reality
```
Turn 1: User asks something unclear
Turn 2: LLM makes assumption, starts working
Turn 3: User tries to correct
Turn 4: LLM doubles down on wrong assumption
Turn 5+: Conversation derails
```

---

## Key Findings

### Finding 1: Universal Performance Drop

| Model | Single-Turn | Multi-Turn | Drop |
|-------|-------------|------------|------|
| GPT-4o | 78% | 52% | -33% |
| Claude 3.5 Sonnet | 76% | 48% | -37% |
| Llama 3.1 405B | 71% | 43% | -39% |
| Gemini Pro | 74% | 45% | -39% |
| **Average** | **75%** | **47%** | **-37%** |

**No model is immune.** All tested models show significant degradation.

### Finding 2: Reliability vs Aptitude

The 39% drop decomposes into:
- **Aptitude loss**: ~8% (genuine capability decrease)
- **Reliability loss**: ~31% (correct capability, wrong application)

**Key insight**: Models still "know" the answer but fail to apply it correctly in multi-turn settings.

### Finding 3: Premature Commitment

Analysis shows models tend to:
1. Make assumptions in early turns
2. Commit to a solution path prematurely
3. Fail to incorporate new information that contradicts assumptions
4. Over-rely on initial (potentially wrong) conclusions

**Quote from paper**: *"When LLMs take a wrong turn in a conversation, they get lost and do not recover."*

---

## Why Multi-Turn is Hard

### 1. Instruction Underspecification

Users naturally give partial information:
```
User: "Fix the bug"
[Missing: which bug, where, what's the expected behavior]
```

Models must infer missing information but often infer incorrectly.

### 2. Context Accumulation

```
Turn 1: Context = Initial request
Turn 2: Context = Request + Response + New input
Turn 3: Context = Request + Response + New input + Response + New input
...
Turn N: Context = Everything above (potentially thousands of tokens)
```

**Problem**: Important details get buried in accumulated context.

### 3. Error Propagation

```
Turn 1: Model makes small wrong assumption
Turn 2: Model builds on that assumption
Turn 3: Compounding errors
...
Turn N: Completely wrong conclusion
```

### 4. Recovery Failure

When users try to correct:
```
User: "Actually, I meant X not Y"
Model: [Already committed to Y, can't pivot effectively]
```

---

## The Simulation Framework

### Design
- **200,000+ simulated conversations**
- **6 generation tasks**: email writing, coding, creative writing, etc.
- **Comparison**: Same task in single-turn vs multi-turn

### Key Innovation
Isolates multi-turn effects by controlling for:
- Task difficulty
- Model capability
- Total information provided

Only variable: single vs multiple turns.

---

## Implications for Agent Design

### For Tool/Agent Developers

#### 1. Prefer Single-Turn When Possible
```python
# Bad: Multi-turn specification
for question in clarifying_questions:
    answer = ask_user(question)
    
# Good: Single-turn with structured input
specification = get_full_spec_upfront()
```

#### 2. Explicit Confirmation Loops
```
Model: "I understand you want X. Is that correct?"
User: "Yes" / "No, I want Y"
Model: [Proceeds with confirmed understanding]
```

#### 3. State Tracking
```python
# Track what has been established
conversation_state = {
    "confirmed": [],  # User explicitly confirmed
    "assumed": [],    # Model inferred, needs verification
    "open": []        # Still unclear
}
```

#### 4. Graceful Recovery
```
When user contradicts earlier assumption:
1. Acknowledge the correction
2. Update state
3. Re-evaluate based on new information
4. Confirm new understanding
```

### For OpenCode Users

```json
{
  "system": "You are a careful assistant. When instructions are unclear:\n" +
            "1. Ask for clarification rather than assume\n" +
            "2. Confirm your understanding before proceeding\n" +
            "3. If corrected, acknowledge and adjust\n" +
            "4. Track what has been established vs assumed",
            
  "behavior": {
    "ask_before_assume": true,
    "confirm_understanding": true,
    "track_assumptions": true
  }
}
```

---

## Mitigation Strategies

### Strategy 1: Full Specification Upfront

Encourage users to provide complete context:
```
Before we start, please tell me:
1. What you're trying to accomplish
2. Any constraints or requirements
3. What you've already tried
4. What success looks like
```

### Strategy 2: Checkpointing

Regularly summarize and confirm:
```
"Let me confirm what I understand so far:
- You want to build X
- It needs to support Y users
- Timeline is Z weeks
Is this correct?"
```

### Strategy 3: Explicit State Management

```python
# In agent implementation
class ConversationState:
    def __init__(self):
        self.confirmed_facts = []
        self.assumptions = []
        self.open_questions = []
    
    def add_fact(self, fact, confirmed=False):
        if confirmed:
            self.confirmed_facts.append(fact)
        else:
            self.assumptions.append(fact)
    
    def verify_assumptions(self):
        # Periodically check assumptions
        return [a for a in self.assumptions 
                if not self._user_confirms(a)]
```

### Strategy 4: Restart on Drift

When conversation gets too confused:
```
"This conversation has gotten complex. Let me summarize what we know:
[Summary]

Should we:
1. Continue with this understanding
2. Start fresh with clearer requirements
3. Break this into separate tasks"
```

---

## Research Implications

### The Evaluation Gap

Current benchmarks focus on single-turn. This paper shows:
- **Single-turn performance ≠ Multi-turn performance**
- **We need multi-turn benchmarks**
- **Multi-turn capability is a distinct skill**

### Training Implications

Models may need:
1. **Multi-turn fine-tuning**: Train on conversational data
2. **Recovery training**: Learn to correct course
3. **Clarification training**: Learn when to ask vs assume
4. **State tracking**: Maintain explicit conversation state

---

## Key Takeaways

1. **Multi-turn is fundamentally harder**: 39% performance drop across all models
2. **Reliability is the issue**: Not lost capability, but lost reliability
3. **Early assumptions dominate**: Models commit prematurely
4. **Recovery is poor**: Wrong turns aren't corrected
5. **Single-turn preferred**: When possible, use single-turn interactions

---

## For Agentter Users

### Practical Recommendations

1. **Write comprehensive prompts**: Don't make the agent guess
2. **Use spec-driven development**: Clear specs reduce multi-turn confusion
3. **Checkpoint frequently**: Confirm understanding at milestones
4. **Start fresh for new topics**: Don't mix topics in one conversation
5. **Monitor for drift**: Watch for wrong assumptions early

### Anti-Patterns to Avoid

```
❌ "Build me a web app"
   → Too vague, agent will assume wrong things

✅ "Build a task management web app with:
    - User authentication
    - CRUD operations on tasks
    - Due dates and priorities
    - React frontend, Node.js backend
    - MongoDB database"

❌ Mixing topics:
   Turn 1: "Fix this bug"
   Turn 5: "Actually, let's add a feature"
   Turn 10: "By the way, refactor this"

✅ Separate conversations for each topic
```

---

## Citation

```bibtex
@article{laban2025lost,
  title={LLMs Get Lost In Multi-Turn Conversation},
  author={Laban, Philippe and Wu, Chien-Sheng and Murakhovs'ka, Lidiya and 
          Bennett, Paul and Xiong, Caiming and Joty, Shafiq and Durrett, Greg},
  journal={arXiv preprint arXiv:2505.06120},
  year={2025}
}
```

---

*Last Updated: March 1, 2026*
