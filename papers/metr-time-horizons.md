# Measuring AI Ability to Complete Long Tasks (METR Time Horizons)

**Authors**: David Rein, Júlio C. A. Leitão, Zam K. K. To, James H. Barnes, Joshua C. T. Smith, Stephen V. McLaughlin, Brian Goodrich, Sören Mindermann, Marius Hobbhahn, Meredith Riggs, Beth Barnes  
**Institution**: METR (Model Evaluation and Threat Research)  
**Published**: March 2025  
**Paper**: [arXiv:2503.14499](https://arxiv.org/abs/2503.14499)  
**Blog**: [METR Time Horizons](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/)

---

## Abstract Summary

Proposes measuring AI performance by the **length of tasks** (in human time) that agents can complete. Demonstrates that this metric has been **exponentially increasing with a doubling time of ~7 months** over the past 6 years. Claude 3.7 Sonnet can reliably complete tasks up to ~1 hour (50% success rate). Extrapolating the trend predicts AI agents capable of completing week-long tasks within a decade.

---

## The Time Horizon Framework

### The Core Idea

Instead of measuring accuracy on fixed benchmarks, measure **how long** a task takes humans vs how well AI performs:

```
4 sec ──▶ 36 sec ──▶ 6 min ──▶ 1 hour ──▶ 10 hours
  │         │          │          │           │
 GPT-2    GPT-3    GPT-3.5    Claude    (Future)
                              3.7 Sonnet
```

### Why Task Length?

| Metric | Problem | Time Horizon Solves |
|--------|---------|---------------------|
| Benchmark accuracy | Doesn't translate to real-world utility | Directly measures practical capability |
| Loss curves | Abstract, hard to interpret | Concrete (hours, days) |
| Economic measures | Lagging, noisy | Leading indicator |

**Key insight**: AI agents struggle more with stringing together longer sequences of actions than with lacking individual skills.

---

## Key Findings

### Finding 1: Exponential Growth

Task completion time horizons have been doubling approximately every 7 months for the last 6 years. If this trend continues:
- 2025: 1-4 hours
- 2027: 1-2 days
- 2030: 1-2 weeks
- 2032: 1-2 months

### Finding 2: Strong Correlation with Human Time

| Human Time | AI Success Rate |
|------------|-----------------|
| < 4 minutes | ~100% |
| ~1 hour | ~50% |
| > 4 hours | < 10% |

**Human time is strongly predictive of AI difficulty.**

### Finding 3: Current Capabilities (as of March 2025)

| Model | 50% Time Horizon |
|-------|------------------|
| GPT-4 | ~20 minutes |
| Claude 3.5 Sonnet | ~40 minutes |
| Claude 3.7 Sonnet | ~1 hour |
| o3 (high) | ~2 hours |
| Claude Opus 4.6 | ~14.5 hours |

### Finding 4: Robust Trend

Even with methodological perturbations, the ~7 month doubling time appears robust across different task subsets and human baselines.

---

## Methodology

### Step 1: Task Collection

Collect diverse tasks with:
- Clear success criteria
- Measurable human completion time
- Range of durations (minutes to hours)

Sources:
- HCAST (Human-Calibrated Autonomous Software Tasks)
- RE-Bench (Research Engineering Benchmark)
- SWE-bench Verified

### Step 2: Human Baseline

Measure how long expert humans take, classifying tasks by duration.

### Step 3: AI Evaluation

Run AI agents on tasks, measure success rate.

### Step 4: Curve Fitting

Fit logistic curve to model success vs task length, extract time horizon at 50% success rate.

---

## Implications

### Forecasting

Extrapolating the trend predicts generalist autonomous agents capable of performing week-long tasks within a decade. However, this extrapolation is uncertain - the trend could continue, accelerate, or plateau.

### Economic Impact

When AI can reliably complete:
- **1-hour tasks**: Assistants for focused work
- **1-day tasks**: Autonomous junior employees
- **1-week tasks**: Independent project execution
- **1-month tasks**: Business unit automation

### AI Safety

Longer horizons enable more complex autonomous behavior that is harder to supervise and has greater potential impact.

---

## For Agentter Users

### Practical Implications

1. **Match task length to model capability**
   - GPT-4 class: 10-20 minute tasks
   - Claude 3.7: 30-60 minute tasks
   - o3: 1-2 hour tasks

2. **Break large tasks down**
   - Don't: "Build a SaaS app" (weeks)
   - Do: "Implement authentication" (hours)

3. **Use appropriate harnesses**
   - Short tasks: Simple prompting
   - Long tasks: Ralph loops, checkpointing, progress tracking

---

## Citation

```bibtex
@article{rein2025measuring,
  title={Measuring AI Ability to Complete Long Tasks},
  author={Rein, David and Leitao, Julio C. A. and To, Zam K. K. and others},
  journal={arXiv preprint arXiv:2503.14499},
  year={2025}
}
```

---

*Last Updated: March 1, 2026*
