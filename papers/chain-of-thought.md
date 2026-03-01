# Chain-of-Thought Prompting Elicits Reasoning in Large Language Models

**Authors**: Jason Wei, Xuezhi Wang, Dale Schuurmans, Maarten Bosma, Brian Ichter, Fei Xia, Ed Chi, Quoc Le, Denny Zhou  
**Institution**: Google Research  
**Published**: January 2022 (NeurIPS 2022)  
**Paper**: [arXiv:2201.11903](https://arxiv.org/abs/2201.11903)

---

## Abstract Summary

Explores generating **chains of thought**—sequences of intermediate reasoning steps— to significantly improve the ability of large language models to perform complex reasoning. Shows that chain-of-thought (CoT) prompting:
- Elicits reasoning in large models (100B+ parameters)
- Improves performance on math word problems, commonsense, and symbolic reasoning
- Provides interpretability into model reasoning process
- Works with few-shot prompting

---

## The Core Idea

### Standard Prompting

```
Q: Roger has 5 tennis balls. He buys 2 more cans of tennis balls. 
   Each can has 3 tennis balls. How many tennis balls does he have now?
A: 11

Q: The cafeteria had 23 apples. If they used 20 to make lunch and 
   bought 6 more, how many apples do they have?
A: ?
```

Model directly predicts answer: may get it wrong.

### Chain-of-Thought Prompting

```
Q: Roger has 5 tennis balls. He buys 2 more cans of tennis balls. 
   Each can has 3 tennis balls. How many tennis balls does he have now?
A: Roger started with 5 balls. 2 cans of 3 balls each is 6 balls. 
   5 + 6 = 11. The answer is 11.

Q: The cafeteria had 23 apples. If they used 20 to make lunch and 
   bought 6 more, how many apples do they have?
A: ?
```

Model generates reasoning steps, then answer.

---

## Why It Works

### 1. Decomposition

Breaks complex problems into steps:
```
Problem: 23 - 20 + 6
Step 1: 23 - 20 = 3
Step 2: 3 + 6 = 9
Answer: 9
```

### 2. Extra Computation

More tokens = more computation:
```
Direct: Input → Output (1 step)
CoT: Input → Step 1 → Step 2 → ... → Output (N steps)
```

### 3. Knowledge Retrieval

Reasoning steps retrieve relevant knowledge:
```
"23 - 20 = 3" → Activates subtraction knowledge
"3 + 6 = 9" → Activates addition knowledge
```

### 4. Interpretability

Can see where reasoning goes wrong:
```
Correct: 5 + 6 = 11 ✓
Wrong: 5 + 6 = 10 ✗ (found error in reasoning!)
```

---

## Results

### Math Word Problems (GSM8K)

| Model | Standard | CoT | Improvement |
|-------|----------|-----|-------------|
| GPT-3 175B | 10.6% | 46.9% | +36.3% |
| PaLM 540B | 17.9% | 56.9% | +39.0% |
| LaMDA 137B | 14.3% | 42.2% | +27.9% |

**CoT dramatically improves math reasoning.**

### Commonsense Reasoning (StrategyQA)

| Model | Standard | CoT | Improvement |
|-------|----------|-----|-------------|
| PaLM 540B | 69.4% | 75.3% | +5.9% |

**Smaller but consistent gains.**

### Symbolic Reasoning (Last Letter Concatenation)

Task: "Amy Brown" → "yn" (last letters)

| Model | Standard | CoT |
|-------|----------|-----|
| PaLM 540B | 8.6% | 95.4% |

**Massive improvement on structured tasks.**

---

## Key Findings

### Finding 1: Emergence at Scale

CoT only helps large models (100B+ parameters):

```
Model Size vs CoT Benefit:
  8B:  2% → 3%   (minimal)
  62B: 5% → 15%  (some)
  540B: 18% → 57% (large)
```

**Reasoning emerges with scale.**

### Finding 2: Few-Shot is Enough

Don't need fine-tuning:
```
Standard prompting: 8 examples → 10.6%
CoT prompting: 8 examples with reasoning → 46.9%
Fine-tuning: Thousands of examples → similar
```

**Prompt engineering > fine-tuning for reasoning.**

### Finding 3: Robust to Example Choice

Different CoT examples give similar results:
```
Example Set A: 54.2%
Example Set B: 53.8%
Example Set C: 55.1%
```

**Not sensitive to specific examples.**

---

## Variants and Extensions

### Zero-Shot CoT

No examples needed:
```
Q: [Question]
A: Let's think step by step.

→ Model generates reasoning automatically
```

Works surprisingly well for simple tasks.

### Self-Consistency

Generate multiple CoT paths, take majority vote:
```
Generation 1: 23 - 20 = 3, 3 + 6 = 9 ✓
Generation 2: 23 - 20 = 3, 3 + 6 = 10 ✗
Generation 3: 23 - 20 = 3, 3 + 6 = 9 ✓

Majority vote: 9 (correct!)
```

Improves CoT by ~10%.

### Tree of Thoughts

Explore multiple reasoning paths:
```
Step 1:
  - Option A → Step 2A
  - Option B → Step 2B
  - Option C → Step 2C

Evaluate each path, choose best.
```

For complex multi-step problems.

### Automatic CoT

Generate CoT examples automatically:
```
1. Generate many candidate CoTs
2. Filter to high-confidence ones
3. Use as few-shot examples
```

No human annotation needed.

---

## CoT for Agents

### ReAct: CoT + Actions

```
Thought: I need to find X
Action: Search[X]
Observation: Results...

Thought: Now I can do Y
Action: Calculate[...]
Observation: Result...

Thought: The answer is Z
Action: Finish[Z]
```

CoT enables reasoning about actions.

### Agent Planning

```
Goal: Build a web app

CoT Plan:
1. Set up project structure
2. Create HTML/CSS
3. Add JavaScript
4. Test functionality
5. Deploy

Execute each step sequentially.
```

### Debugging with CoT

```
Error: IndexError in line 45

CoT Analysis:
1. Looking at line 45: arr[i]
2. i comes from loop range(len(arr))
3. But arr was modified earlier
4. Now len(arr) is smaller
5. i can exceed new length

Fix: Use while loop or copy arr first
```

---

## Best Practices

### 1. Use for Complex Tasks

```
Good: Math, logic, multi-step reasoning
Bad: Simple classification, factual recall
```

### 2. Provide Good Examples

```
Good example:
  Clear reasoning steps
  Relevant to target task
  Correct answer

Bad example:
  Skips steps
  Wrong answer
  Different problem type
```

### 3. Guide with Instructions

```
"Let's solve this step by step:"
"First think about X, then Y:"
"Explain your reasoning:"
```

### 4. Verify Reasoning

```
Model: "5 + 6 = 10, so answer is 10"
Check: 5 + 6 = 11, not 10!
→ Error in reasoning detected
```

---

## Limitations

### 1. Not Always Correct

CoT can still be wrong:
```
"2 + 2 = 5, so answer is 5"
→ Reasoning looks valid but is wrong
```

### 2. Hallucinated Reasoning

May invent steps:
```
"Using the formula for quantum gravity..."
→ No such formula was provided
```

### 3. Computation Errors

Even with CoT, arithmetic errors:
```
"123 × 456 = 56,088"
→ Actually 56,088 (wait that's correct...)
→ Often wrong for large numbers
```

### 4. Task-Specific

Not all tasks benefit:
```
Translation: CoT doesn't help
Classification: Usually no benefit
Generation: Sometimes hurts
```

---

## OpenCode Integration

### Enabling CoT

```json
{
  "system": "You are a helpful assistant. For complex tasks:\n" +
            "1. Break down the problem into steps\n" +
            "2. Think through each step\n" +
            "3. Show your reasoning\n" +
            "4. Then provide the final answer",
            
  "format": "Always show your reasoning before answering."
}
```

### CoT Examples in Prompts

```markdown
## Example 1
Q: Calculate the factorial of 5
A: Let me work through this:
   5! = 5 × 4 × 3 × 2 × 1
   5 × 4 = 20
   20 × 3 = 60
   60 × 2 = 120
   120 × 1 = 120
   So 5! = 120

## Example 2
Q: [Your question]
A:
```

---

## Key Takeaways

1. **CoT elicits reasoning in large models**
2. **Decomposes complex problems**
3. **Provides interpretability**
4. **Works with few-shot prompting**
5. **Foundation for agent reasoning**

---

## Citation

```bibtex
@article{wei2022chain,
  title={Chain-of-Thought Prompting Elicits Reasoning in Large Language Models},
  author={Wei, Jason and Wang, Xuezhi and Schuurmans, Dale and 
          Bosma, Maarten and Ichter, Brian and Xia, Fei and 
          Chi, Ed and Le, Quoc and Zhou, Denny},
  journal={Advances in Neural Information Processing Systems (NeurIPS)},
  year={2022}
}
```

---

*Last Updated: March 1, 2026*
