# A Survey of Context Engineering for Large Language Models

**Authors**: Lingrui Mei, Jiayu Yao, Yuyao Ge, Yiwei Wang, Baolong Bi, Yujun Cai, Jiazhi Liu, Mingyu Li, Zhong-Zhi Li, Duzhen Zhang, Chenlin Zhou, Jiayi Mao, Tianze Xia, Jiafeng Guo, Shenghua Liu  
**Institution**: Chinese Academy of Sciences, Tsinghua University, etc.  
**Published**: July 2025  
**Paper**: [arXiv:2507.13334](https://arxiv.org/abs/2507.13334)

---

## Abstract Summary

This survey introduces **Context Engineering** as a formal discipline that transcends simple prompt design to encompass the systematic optimization of information payloads for LLMs. Through analysis of 1400+ research papers, the authors establish a comprehensive taxonomy and identify a critical research gap: while models excel at understanding complex contexts, they struggle to generate sophisticated long-form outputs.

---

## The Core Argument

### From Prompt Engineering to Context Engineering

| Era | Focus | Scope |
|-----|-------|-------|
| **Prompt Engineering** | Designing input text | Single prompt optimization |
| **Context Engineering** | Systematic information optimization | Full pipeline: retrieval → processing → management |

**Key Insight**: LLM performance is fundamentally determined by the contextual information provided during inference, not just how you phrase the prompt.

---

## The Context Engineering Taxonomy

```
┌─────────────────────────────────────────────────────────────┐
│                  CONTEXT ENGINEERING                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  FOUNDATIONAL COMPONENTS                                    │
│  ├── Context Retrieval & Generation                         │
│  │   ├── Retrieval-Augmented Generation (RAG)              │
│  │   ├── Context Compression                               │
│  │   └── Synthetic Context Generation                      │
│  │                                                          │
│  ├── Context Processing                                     │
│  │   ├── Context Selection (what to keep)                  │
│  │   ├── Context Organization (how to structure)           │
│  │   └── Context Enhancement (enriching)                   │
│  │                                                          │
│  └── Context Management                                     │
│      ├── Short-term (working memory)                        │
│      └── Long-term (persistent memory)                      │
│                                                             │
│  SYSTEM IMPLEMENTATIONS                                     │
│  ├── RAG Systems                                            │
│  ├── Memory Systems                                         │
│  ├── Tool-Integrated Reasoning                              │
│  └── Multi-Agent Systems                                    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Key Findings

### Finding 1: The Asymmetry Problem

**Models are good at understanding complex contexts but poor at generating sophisticated long-form outputs.**

| Capability | Performance | Gap |
|------------|-------------|-----|
| Context Understanding | Excellent | — |
| Long-form Generation | Poor | Significant |
| Reasoning within Context | Good | — |
| Reasoning across Contexts | Moderate | Moderate |

**Implication**: Future research should focus on improving generation capabilities, not just retrieval.

### Finding 2: Context Retrieval Strategies

| Strategy | Best For | Trade-off |
|----------|----------|-----------|
| Dense Retrieval | Semantic similarity | Computation |
| Sparse Retrieval | Keyword matching | Semantic understanding |
| Hybrid | General use | Complexity |
| Graph-based | Structured relationships | Setup cost |

### Finding 3: Context Processing Techniques

**Context Selection** (what to include):
- Relevance scoring
- Redundancy removal
- Diversity maximization
- Recency weighting

**Context Organization** (how to structure):
- Chronological ordering
- Hierarchical structuring
- Priority-based ranking
- Dependency mapping

---

## Practical Implications

### For Agent Developers

1. **Don't just retrieve - curate**: Quality of context > quantity
2. **Process before presenting**: Raw retrieved context should be processed
3. **Manage across sessions**: Persistent memory is essential
4. **Monitor context window**: Track usage, compact proactively

### For System Architects

```python
# Context Engineering Pipeline
def context_engineering(query):
    # 1. Retrieve candidates
    candidates = retrieve(query, top_k=100)
    
    # 2. Select relevant
    relevant = select(candidates, relevance_threshold=0.7)
    
    # 3. Remove redundancy
    diverse = deduplicate(relevant, similarity_threshold=0.9)
    
    # 4. Organize structure
    organized = structure(diverse, strategy="hierarchical")
    
    # 5. Enhance if needed
    enhanced = enhance(organized, add_metadata=True)
    
    # 6. Fit to budget
    final = budget(enhanced, max_tokens=8000)
    
    return final
```

---

## Context Management in OpenCode

### Configuration

```json
{
  "context": {
    "retrieval": {
      "strategy": "hybrid",
      "top_k": 10,
      "diversity_boost": true
    },
    "processing": {
      "compress": true,
      "summarize_long": true,
      "organize_by": "relevance"
    },
    "management": {
      "auto_compact": true,
      "compact_threshold": 0.7,
      "reserve_tokens": 4000
    }
  }
}
```

### Best Practices

1. **Progressive Disclosure**
   ```
   Load minimal context initially
   → Expand based on triggers
   → Cache for reuse
   ```

2. **Memory Integration**
   ```
   Short-term: Conversation history
   Medium-term: Session memory.md
   Long-term: Project knowledge base
   ```

3. **Context Compaction**
   ```
   Summarize old conversation
   → Archive to file
   → Load summary only
   ```

---

## Research Gaps Identified

### Gap 1: Generation-Understanding Asymmetry
- **Problem**: Great at using context, poor at creating it
- **Opportunity**: Train models specifically for context generation

### Gap 2: Dynamic Context Optimization
- **Problem**: Static retrieval doesn't adapt to conversation flow
- **Opportunity**: Real-time context re-ranking based on conversation state

### Gap 3: Multi-Modal Context
- **Problem**: Text-focused context engineering
- **Opportunity**: Unified handling of text, code, images, structured data

### Gap 4: Evaluation Metrics
- **Problem**: No standard metrics for context quality
- **Opportunity**: Develop context engineering benchmarks

---

## Key Insights for Practitioners

1. **Context is not just retrieval**: It's a full pipeline
2. **Quality over quantity**: 10 relevant docs > 100 mediocre ones
3. **Structure matters**: How you organize context affects understanding
4. **Persistence is key**: Cross-session memory essential for complex tasks
5. **Monitor and adapt**: Context needs change throughout a conversation

---

## Comparison with Related Concepts

| Concept | Focus | Relation to Context Engineering |
|---------|-------|--------------------------------|
| Prompt Engineering | Input phrasing | Subset - just the final step |
| RAG | Retrieval | Component - one of several techniques |
| In-Context Learning | Learning from examples | Application - how to select examples |
| Memory Systems | Storage | Component - persistence layer |

---

## Future Directions

The survey identifies several promising directions:

1. **Context-Aware Training**: Pre-train models to better use structured context
2. **Adaptive Context Windows**: Dynamic sizing based on task complexity
3. **Context Compression**: Learned compression preserving salient information
4. **Cross-Modal Context**: Unified representation for text, code, images

---

## Citation

```bibtex
@article{mei2025context,
  title={A Survey of Context Engineering for Large Language Models},
  author={Mei, Lingrui and Yao, Jiayu and Ge, Yuyao and Wang, Yiwei and 
          Bi, Baolong and Cai, Yujun and Liu, Jiazhi and Li, Mingyu and 
          Li, Zhong-Zhi and Zhang, Duzhen and Zhou, Chenlin and Mao, Jiayi and 
          Xia, Tianze and Guo, Jiafeng and Liu, Shenghua},
  journal={arXiv preprint arXiv:2507.13334},
  year={2025}
}
```

---

*Last Updated: March 1, 2026*
