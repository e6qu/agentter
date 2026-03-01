# WebArena & OSWorld: Benchmarking Web and Computer Agents

## WebArena: A Realistic Web Environment for Building Autonomous Agents

**Authors**: Shuyan Zhou, Frank F. Xu, Hao Zhu, Xuhui Zhou, Robert Lo, Abishek Sridhar, Xianyi Cheng, Tianyue Ou, Yonatan Bisk, Daniel Fried, Uri Alon, Graham Neubig  
**Institution**: Carnegie Mellon University  
**Published**: July 2023  
**Paper**: [arXiv:2307.13854](https://arxiv.org/abs/2307.13854)

---

## OSWorld: Benchmarking Multimodal Agents for Open-Ended Tasks in Real Computer Environments

**Authors**: Tianbao Xie, Danyang Zhang, Jixuan Chen, Xiaochuan Li, Siheng Zhao, Ruisheng Cao, Toh Jing Hua, Zhoujun Cheng, Dongchan Shin, Fangyu Lei, Yitao Liu, Yiheng Xu, Shuyan Zhou, Silvio Savarese, Caiming Xiong, Victor Zhong, Tao Yu  
**Institution**: University of Hong Kong, Salesforce AI Research, etc.  
**Published**: April 2024  
**Paper**: [arXiv:2404.07972](https://arxiv.org/abs/2404.07972)

---

## Common Motivation

Both benchmarks address a critical gap: existing benchmarks test isolated skills, but real-world agents need to:
- Navigate complex environments
- Use real applications
- Handle failures and recover
- Complete multi-step tasks

---

## WebArena

### Environment

Realistic, standalone web environment with:
- Full websites (GitLab, Reddit, Shopping, etc.)
- Real databases
- Actual functionality
- Reproducible state

### Task Examples

```
Task: "Find the cheapest flight from NYC to LA on May 15"
Actions needed:
1. Navigate to travel website
2. Enter departure location
3. Enter destination
4. Select date
5. Search
6. Compare prices
7. Report result
```

```
Task: "Create a new repository named 'test-repo' on GitLab"
Actions needed:
1. Login to GitLab
2. Navigate to projects
3. Click "New project"
4. Enter name
5. Configure settings
6. Create
7. Verify creation
```

### Statistics

| Metric | Value |
|--------|-------|
| Total tasks | 812 |
| Websites | 5 (GitLab, Maps, Shopping, Reddit, CMS) |
| Avg actions | ~10 |
| Human success | ~78% |
| Best agent | ~35% (GPT-4V) |

### Action Space

```python
{
  "action": "click",
  "target": "button[id='submit']"
}

{
  "action": "type",
  "target": "input[id='search']",
  "value": "query"
}

{
  "action": "scroll",
  "direction": "down"
}
```

---

## OSWorld

### Environment

Real computer environment with:
- Ubuntu desktop
- Real applications (Chrome, VS Code, Terminal, etc.)
- File system access
- Visual interface

### Task Examples

```
Task: "Convert the Excel file to CSV and email it to john@example.com"
Actions needed:
1. Open file manager
2. Find Excel file
3. Open in LibreOffice Calc
4. Export as CSV
5. Open email client
6. Compose new email
7. Attach CSV
8. Send
```

```
Task: "Install Node.js v18 and create a new React project"
Actions needed:
1. Open terminal
2. Run install commands
3. Verify installation
4. Create project directory
5. Run create-react-app
6. Verify project created
```

### Statistics

| Metric | Value |
|--------|-------|
| Total tasks | 369 |
| Applications | 20+ |
| Avg actions | ~15 |
| Human success | ~72% |
| Best agent | ~15% |

### Action Space

More complex than WebArena:
```python
{
  "action": "click",
  "x": 100,
  "y": 200
}

{
  "action": "type",
  "text": "hello world"
}

{
  "action": "hotkey",
  "keys": ["ctrl", "c"]
}

{
  "action": "screenshot"
  # Agent sees visual state
}
```

---

## Key Challenges

### 1. Long Action Sequences

```
Simple task: 5-10 actions
Complex task: 20-50+ actions
Error in step 3 affects steps 4-50
```

### 2. Failure Recovery

```
Step 10: Click wrong button
→ Unexpected page
→ Agent must recognize error
→ Backtrack or recover
```

### 3. Visual Understanding

For OSWorld:
```
- Read text from screenshots
- Identify UI elements
- Understand layouts
- Recognize application states
```

### 4. Open-Endedness

Tasks can have multiple solutions:
```
"Book a flight":
- Multiple airlines
- Different routes
- Price vs time tradeoffs
```

### 5. State Management

```
Task spans multiple applications:
1. Research in browser
2. Write notes in text editor
3. Create presentation
4. Email results
```

---

## Results

### WebArena

| Model | Success Rate |
|-------|--------------|
| Human | ~78% |
| GPT-4 + browse | ~15% |
| GPT-4V + agent | ~35% |

### OSWorld

| Model | Success Rate |
|-------|--------------|
| Human | ~72% |
| GPT-4V | ~12% |
| Claude 3.5 Sonnet | ~15% |

### Gap Analysis

- **Humans**: ~75% average
- **Best AI**: ~15-35%
- **Gap**: 40-60 percentage points

**Significant room for improvement!**

---

## What Makes These Benchmarks Hard?

### 1. Real-World Complexity

Not toy environments:
- Real websites with ads/popups
- Actual application behavior
- Complex state management

### 2. Multi-Modal (OSWorld)

Must process:
- Visual information (screenshots)
- Text (OCR)
- Structured data (HTML)

### 3. Error Accumulation

```
Step 5 error → Wrong state
Step 6-10: Actions in wrong context
Step 11+: Complete failure
```

### 4. No Reset

Can't retry easily:
- State changes persist
- Side effects accumulate
- Must recover from mistakes

---

## For Agentter Users

### Lessons for Building Agents

1. **Visual grounding matters**
   - Use screenshots for UI understanding
   - Element detection
   - State verification

2. **Error recovery is essential**
   - Detect when things go wrong
   - Have rollback strategies
   - Don't assume success

3. **Plan before acting**
   - Long sequences need planning
   - Replan when state changes
   - Verify progress

4. **Test in real environments**
   - Don't rely on mocks
   - Real applications have quirks
   - Handle unexpected states

### OpenCode Integration

```bash
# Web browsing tasks
opencode run "Navigate to example.com and find pricing information"

# Computer use tasks
opencode run "Open VS Code, create a new file, write a Python function"
```

---

## Citation

```bibtex
@article{zhou2023webarena,
  title={WebArena: A Realistic Web Environment for Building Autonomous Agents},
  author={Zhou, Shuyan and Xu, Frank F. and Zhu, Hao and Zhou, Xuhui and 
          Lo, Robert and Sridhar, Abishek and Cheng, Xianyi and Ou, Tianyue and 
          Bisk, Yonatan and Fried, Daniel and Alon, Uri and Neubig, Graham},
  journal={arXiv preprint arXiv:2307.13854},
  year={2023}
}

@article{xie2024osworld,
  title={OSWorld: Benchmarking Multimodal Agents for Open-Ended Tasks in Real Computer Environments},
  author={Xie, Tianbao and Zhang, Danyang and Chen, Jixuan and Li, Xiaochuan and 
          Zhao, Siheng and Cao, Ruisheng and Hua, Toh Jing and Cheng, Zhoujun and 
          Shin, Dongchan and Lei, Fangyu and Liu, Yitao and Xu, Yiheng and 
          Zhou, Shuyan and Savarese, Silvio and Xiong, Caiming and Zhong, Victor and Yu, Tao},
  journal={arXiv preprint arXiv:2404.07972},
  year={2024}
}
```

---

*Last Updated: March 1, 2026*
