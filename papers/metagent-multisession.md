# MetaGPT: Meta Programming for Multi-Agent Collaborative Framework

**Authors**: Sirui Hong, Mingchen Zhuge, Jiaqi Chen, Xiawu Zheng, Yuheng Cheng, Ceyao Zhang, Jinlin Wang, Zili Wang, Steven Ka Shing Yau, Zijuan Lin, Liyang Zhou, Chenyu Ran, Lingfeng Xiao, Chenglin Wu, Jürgen Schmidhuber  
**Institution**: CUHK-Shenzhen, DeepWisdom, AI Initiative, KAUST  
**Published**: August 2023  
**Paper**: [arXiv:2308.00352](https://arxiv.org/abs/2308.00352)  
**Code**: [github.com/geekan/MetaGPT](https://github.com/geekan/MetaGPT)

---

## Abstract Summary

Existing LLM-based multi-agent systems can solve simple dialogue tasks, but struggle with complex tasks due to logic inconsistencies and cascading hallucinations from naively chaining LLMs. MetaGPT encodes **Standardized Operating Procedures (SOPs)** into prompt sequences, allowing agents with human-like domain expertise to verify intermediate results and reduce errors. On collaborative software engineering benchmarks, MetaGPT generates more coherent solutions than previous chat-based multi-agent systems.

---

## The Problem with Naive Multi-Agent

### Simple Multi-Agent (ChatDev-style)
```
CEO → Coder → Tester → [Loop until done]
```

**Issues**:
1. **Cascading hallucinations**: One agent's error propagates
2. **No verification**: No one checks intermediate work
3. **Inconsistent logic**: Different agents have different understandings
4. **Inefficient**: No structured workflow

### Real-World Software Development
```
PM creates PRD → Architect designs → Engineers implement → 
QA tests → (Loop if issues) → Deploy
```

**Has structured workflows, verification, clear roles.**

---

## The MetaGPT Solution

### Core Innovation: SOPs as Prompts

MetaGPT encodes Standardized Operating Procedures into the system:

```python
# SOP for Product Manager
sop_product_manager = """
Role: Product Manager
Responsibilities:
1. Analyze user requirements
2. Create Product Requirement Document (PRD)
3. Define user stories and acceptance criteria

Output Format:
## Original Requirements
{requirements}

## Product Goals
{goals}

## User Stories
{stories}

## Competitive Analysis
{analysis}
"""
```

### The Assembly Line Paradigm

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Product    │───▶│  Architect  │───▶│  Project    │
│  Manager    │    │             │    │  Manager    │
└─────────────┘    └─────────────┘    └──────┬──────┘
                                             │
       ┌─────────────────────────────────────┘
       ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Engineer   │───▶│    QA       │───▶│   Deploy    │
│  (multiple) │    │  Engineer   │    │             │
└─────────────┘    └──────┬──────┘    └─────────────┘
                          │
                    [Issues? Loop back]
```

Each role has:
- **Specific responsibilities**
- **Required inputs**
- **Standardized outputs**
- **Verification criteria**

---

## Key Roles in MetaGPT

### 1. Product Manager
- **Input**: User requirements
- **Output**: PRD (Product Requirements Document)
- **Verification**: Requirements are clear, complete, testable

### 2. Architect
- **Input**: PRD
- **Output**: Design documents, API specs, data models
- **Verification**: Design satisfies requirements, is implementable

### 3. Project Manager
- **Input**: Design documents
- **Output**: Task breakdown, file structure, dependencies
- **Verification**: Tasks are atomic, dependencies are clear

### 4. Engineers
- **Input**: Tasks
- **Output**: Code implementations
- **Verification**: Code passes tests, follows style

### 5. QA Engineer
- **Input**: Code, requirements
- **Output**: Test cases, bug reports
- **Verification**: Coverage is adequate, bugs are caught

---

## Results

### Software Engineering Benchmarks

| Benchmark | Metric | MetaGPT | AutoGPT | GPT-4 |
|-----------|--------|---------|---------|-------|
| HumanEval | Pass@1 | 85.9% | 46.5% | 67.0% |
| MBPP | Pass@1 | 85.5% | 52.9% | 72.4% |

### Collaborative Tasks

MetaGPT vs ChatDev on software projects:
- **Code correctness**: +30%
- **Documentation quality**: +45%
- **Consistency**: +50%

### Ablation Study

| Configuration | Success Rate |
|---------------|--------------|
| Full MetaGPT | 85% |
| Without SOPs | 62% |
| Without role specialization | 55% |
| Single agent | 48% |

**SOPs and role specialization are crucial.**

---

## Why MetaGPT Works

### 1. Structured Communication

```
Instead of free-form chat:
  "Hey, can you check this?"

MetaGPT uses structured messages:
  {
    "from": "Architect",
    "to": "Engineer",
    "type": "API_SPEC",
    "content": {...},
    "verification_required": true
  }
```

### 2. Intermediate Verification

Each step produces verifiable output:
- PRD has acceptance criteria
- Design has interface specs
- Code has tests

### 3. Reduced Context Overhead

Agents only see what's relevant:
- Engineer sees their tasks, not entire PRD
- QA sees requirements and code
- No need to hold entire project in context

### 4. Human-Inspired Workflows

Based on real software engineering practices:
- Separation of concerns
- Clear handoffs
- Verification at each stage

---

## Implementation Details

### The Publish-Subscribe Mechanism

```python
class Environment:
    def __init__(self):
        self.message_queue = []
        self.subscribers = {}
    
    def publish(self, message, role=None):
        """Publish a message to the environment"""
        self.message_queue.append(message)
        # Notify relevant subscribers
        for subscriber in self.subscribers.get(role, []):
            subscriber.receive(message)
    
    def subscribe(self, role, callback):
        """Subscribe to messages for a role"""
        self.subscribers.setdefault(role, []).append(callback)
```

### Role Implementation

```python
class Role:
    def __init__(self, name, profile, goal, constraints):
        self.name = name
        self.profile = profile  # System prompt
        self.goal = goal
        self.constraints = constraints
        self.actions = []
    
    def think(self):
        """Decide next action"""
        prompt = f"{self.profile}\nGoal: {self.goal}\n"
        return llm(prompt)
    
    def act(self, action):
        """Execute action"""
        result = action.run()
        return result
    
    def run(self):
        """Main loop"""
        while not self.is_done():
            action = self.think()
            result = self.act(action)
            self.publish(result)
```

---

## Using MetaGPT Concepts in OpenCode

### Defining Roles

```json
// ~/.opencode/agents/architect.json
{
  "name": "Architect",
  "description": "Designs system architecture and APIs",
  "system": "You are a software architect. Given requirements, you create:\n" +
             "1. System design document\n" +
             "2. API specifications\n" +
             "3. Data models\n" +
             "4. Technology stack recommendations\n\n" +
             "Always output in structured format with clear sections.",
  "constraints": [
    "Verify design satisfies all requirements",
    "Consider scalability and maintainability",
    "Document trade-offs"
  ]
}
```

### Workflow Implementation

```bash
# Step 1: Product Manager creates spec
opencode run --agent product-manager "Create PRD for [feature]"

# Step 2: Architect designs
opencode run --agent architect "Design system for PRD.md"

# Step 3: Engineers implement
opencode run --agent engineer "Implement per design.md"

# Step 4: QA tests
opencode run --agent qa "Create tests for implementation"
```

### Structured Handoffs

```markdown
# handoff-template.md

## From: [Previous Role]
## To: [Next Role]
## Date: [Timestamp]

### Work Completed
- [ ] Item 1
- [ ] Item 2

### Deliverables
- File: [path] - Description
- File: [path] - Description

### Verification
- [ ] Meets acceptance criteria
- [ ] Ready for next phase

### Notes
[Any important context]
```

---

## Best Practices from MetaGPT

### 1. Clear Role Boundaries

Each agent should have:
- Specific, non-overlapping responsibilities
- Clear inputs and outputs
- Authority to reject poor input

### 2. Standardized Interfaces

```python
# Standard output format for each role
class Deliverable:
    role: str
    input_requirements: List[str]
    output_format: str
    verification_checklist: List[str]
```

### 3. Verification at Each Step

Don't assume previous work is correct:
- Review PRD against original requirements
- Review design against PRD
- Test code against requirements

### 4. Incremental Progress

Break work into small, verifiable pieces:
- Not: "Build the app"
- Yes: "Create auth module → test → create API → test → ..."

---

## Limitations

### 1. Setup Overhead

Defining SOPs requires upfront work:
- Role definitions
- Output formats
- Verification criteria

### 2. Inflexibility

Strict workflows may not fit all problems:
- Creative tasks need flexibility
- Research is exploratory
- Some tasks need iteration

### 3. Coordination Costs

More agents = more coordination:
- Communication overhead
- Context synchronization
- Conflict resolution

### 4. Context Window Limits

Long workflows may exceed context:
- Entire PRD + design + code = many tokens
- Need summarization or selective loading

---

## Extensions and Variants

### MetaGPT + ReAct

Each role uses ReAct pattern:
```
PM: Thought → Research → Thought → Write PRD → Verify
```

### MetaGPT + Ralph Loops

Persistent agents for each role:
```
Engineer keeps working until task complete
→ Checkpoint progress
→ Next agent picks up
```

### Adaptive MetaGPT

Dynamic role assignment:
```
Project needs DevOps → Spawn DevOps agent
Project needs Security review → Spawn Security agent
```

---

## Key Takeaways

1. **SOPs matter**: Structured workflows beat free-form chat
2. **Role specialization**: Different agents for different tasks
3. **Verification at each step**: Catch errors early
4. **Standardized interfaces**: Clear handoffs between agents
5. **Human-inspired**: Learn from real-world workflows

---

## Citation

```bibtex
@article{hong2023metagpt,
  title={MetaGPT: Meta Programming for A Multi-Agent Collaborative Framework},
  author={Hong, Sirui and Zhuge, Mingchen and Chen, Jiaqi and Zheng, Xiawu and 
          Cheng, Yuheng and Zhang, Ceyao and Wang, Jinlin and Wang, Zili and 
          Yau, Steven Ka Shing and Lin, Zijuan and Zhou, Liyang and Ran, Chenyu and 
          Xiao, Lingfeng and Wu, Chenglin and Schmidhuber, J{\"u}rgen},
  journal={arXiv preprint arXiv:2308.00352},
  year={2023}
}
```

---

*Last Updated: March 1, 2026*
