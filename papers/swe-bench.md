# SWE-bench: Can Language Models Resolve Real-World GitHub Issues?

**Authors**: Carlos E. Jimenez, John Yang, Alexander Wettig, Shunyu Yao, Kexin Pei, Ofir Press, Karthik R. Narasimhan  
**Institution**: Princeton University, University of Pennsylvania  
**Published**: October 2023 (ICLR 2024)  
**Paper**: [arXiv:2310.06770](https://arxiv.org/abs/2310.06770)  
**Code**: [github.com/swe-bench/SWE-bench](https://github.com/swe-bench/SWE-bench)

---

## Abstract Summary

Introduces SWE-bench, an evaluation framework consisting of 2,294 software engineering problems drawn from real GitHub issues and pull requests across 12 popular Python repositories. Models are given a codebase and an issue description, and must generate a patch that resolves the issue. SWE-bench tests whether language models can understand real codebases, reproduce bugs, and implement correct fixes.

---

## The Problem with Existing Code Benchmarks

### Traditional Benchmarks

| Benchmark | Limitation |
|-----------|-----------|
| HumanEval | Algorithmic functions, isolated |
| MBPP | Small programming problems |
| CodeXGlue | Specific tasks, not end-to-end |

**Missing**: Real software engineering with:
- Large, complex codebases
- Ambiguous issue descriptions
- Integration testing requirements
- Multiple file changes

### What Makes Real Software Engineering Hard?

```
Issue: "Bug: IndexError when parsing empty files"

Required skills:
1. Find relevant code (across multiple files)
2. Understand the parsing logic
3. Reproduce the bug
4. Identify root cause
5. Implement fix
6. Ensure no regressions
7. Write tests if needed
```

---

## SWE-bench Construction

### Data Sources

- **12 Python repositories**: django, scikit-learn, matplotlib, etc.
- **Real GitHub issues**: Bug reports, feature requests
- **Verified fixes**: Merged PRs with passing tests

### Dataset Statistics

| Metric | Value |
|--------|-------|
| Total instances | 2,294 |
| Repositories | 12 |
| Avg files changed | 2.3 |
| Avg lines changed | 44 |
| Test coverage | 100% (must pass before/after) |

### Selection Criteria

1. Issue has clear description
2. Fix is in Python code
3. Tests exist and pass after fix
4. Not documentation-only
5. Not too large (≤100 lines changed)

---

## Task Definition

### Input

```python
{
  "repo": "django/django",
  "base_commit": "a1b2c3d...",
  "issue_description": """
    IndexError in forms.py when processing empty file uploads
    
    Traceback:
    File "/django/forms/fields.py", line 123, in to_python
      return data.name
    IndexError: string index out of range
  """,
  "test_patch": "...",  # Test that reproduces bug
  "hint_text": ""  # Optional hints
}
```

### Expected Output

```python
{
  "model_patch": """
    diff --git a/django/forms/fields.py b/django/forms/fields.py
    --- a/django/forms/fields.py
    +++ b/django/forms/fields.py
    @@ -120,7 +120,10 @@ class FileField(Field):
         def to_python(self, data):
             if not data:
                 return None
    -        return data.name
    +        try:
    +            return data.name
    +        except IndexError:
    +            return None
    """
}
```

### Evaluation

1. Apply model's patch
2. Run tests
3. Pass if:
   - Previously failing tests now pass
   - Previously passing tests still pass

---

## Results

### Initial Results (2023)

| Model | Pass Rate |
|-------|-----------|
| GPT-4 | 1.7% |
| Claude 2 | 1.2% |
| Claude 3 | 4.8% |
| GPT-3.5 | 0.2% |

**Real software engineering is hard!**

### Current Results (2025)

| Model/System | SWE-bench Verified |
|--------------|-------------------|
| Claude 3.7 + Agent | ~60% |
| o1 + AIDE | ~50% |
| Claude 3.5 Sonnet + SWE-agent | ~53% |
| GPT-4 + Tools | ~40% |

**Rapid progress with agent frameworks!**

### mini-SWE-agent (100 lines Python)

- Scores up to 74% on SWE-bench Verified
- Demonstrates importance of agent design
- Simple retrieval + edit loop works surprisingly well

---

## What Makes SWE-bench Hard?

### 1. Repository Understanding

Models must:
- Navigate directory structures
- Understand module relationships
- Find relevant files
- Parse unfamiliar code patterns

### 2. Issue Comprehension

Issues are often:
- Ambiguously described
- Missing reproduction steps
- Require domain knowledge
- Have multiple possible interpretations

### 3. Bug Localization

```
Error in file A
Root cause in file B
Fix needed in file C
```

Models must trace through the codebase.

### 4. Fix Implementation

Correct fix requires:
- Understanding existing code patterns
- Following project conventions
- Not breaking other functionality
- Edge case handling

### 5. Testing

Must ensure:
- Bug is actually fixed
- No regressions
- Test coverage adequate

---

## Agent Design Implications

### What Works

1. **Retrieval**: Find relevant code
2. **Reproduction**: Run tests to confirm bug
3. **Planning**: Think before editing
4. **Iterative editing**: Make small changes
5. **Verification**: Test after each change

### Example Agent Loop

```python
# SWE-agent style
while not done:
    # 1. Observe current state
    files = list_files()
    tests = run_tests()
    
    # 2. Think
    thought = llm(f"Given {files} and {tests}, what next?")
    
    # 3. Act
    if "search" in thought:
        results = search_code(thought.query)
    elif "edit" in thought:
        apply_edit(thought.file, thought.edit)
    elif "test" in thought:
        results = run_tests()
    elif "submit" in thought:
        done = True
```

---

## SWE-bench Variants

### SWE-bench Lite
- 300 instances
- Faster evaluation
- For development/iteration

### SWE-bench Verified
- Subset with verified human solutions
- Higher quality annotations
- Preferred for reporting results

### SWE-bench Multimodal
- Includes screenshots for UI issues
- Tests visual understanding

### SWE-bench Java/JavaScript
- Expanded to other languages

---

## For Agentter Users

### Lessons for Real Projects

1. **Retrieval is crucial**
   ```
   Before fixing: Find where the bug is
   Tools: grep, find, code search
   ```

2. **Reproduce first**
   ```
   Don't fix what you can't reproduce
   Write/run tests before editing
   ```

3. **Small changes**
   ```
   One file at a time
   Test after each change
   Git commit frequently
   ```

4. **Follow conventions**
   ```
   Read existing code in the area
   Match style and patterns
   Don't reinvent wheels
   ```

### OpenCode Workflow for Bug Fixing

```bash
# 1. Understand the issue
opencode run "Read issue.md and understand the bug"

# 2. Find relevant code
opencode run "Search codebase for files related to [issue]"

# 3. Reproduce
opencode run "Write a test that reproduces the bug"

# 4. Fix
opencode run "Implement fix in [file]"

# 5. Verify
opencode run "Run tests to verify fix works"

# 6. Check for regressions
opencode run "Run full test suite"
```

---

## Criticisms and Limitations

### 1. Python Only
- Originally Python-focused
- Now expanding to Java/JavaScript

### 2. Test-Driven Bias
- Issues with tests are easier
- Real bugs often lack tests

### 3. Instance Quality
- Some issues are trivial
- Some are too complex
- Quality varies

### 4. Overfitting Concerns
- Models trained on GitHub may have seen issues
- Verified subset helps address this

---

## Key Takeaways

1. **Real software engineering is hard**: Even GPT-4 only gets 1-2% without tools
2. **Agents matter**: Proper agent design improves to 50-60%
3. **Retrieval + Edit loop**: Simple pattern works well
4. **Test-driven**: Verification is essential
5. **Rapid progress**: From 1% to 60%+ in 2 years

---

## Citation

```bibtex
@inproceedings{jimenez2024swe,
  title={SWE-bench: Can Language Models Resolve Real-World GitHub Issues?},
  author={Jimenez, Carlos E and Yang, John and Wettig, Alexander and 
          Yao, Shunyu and Pei, Kexin and Press, Ofir and Narasimhan, Karthik R},
  booktitle={International Conference on Learning Representations (ICLR)},
  year={2024}
}
```

---

*Last Updated: March 1, 2026*
