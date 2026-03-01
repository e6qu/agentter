# Retrieval-Augmented Generation (RAG) for Knowledge-Intensive NLP Tasks

**Authors**: Patrick Lewis, Ethan Perez, Aleksandra Piktus, Fabio Petroni, Vladimir Karpukhin, Naman Goyal, Heinrich Küttler, Mike Lewis, Wen-tau Yih, Tim Rocktäschel, Sebastian Riedel, Douwe Kiela  
**Institution**: Facebook AI Research (FAIR), University College London  
**Published**: 2020 (NeurIPS)  
**Paper**: [arXiv:2005.11401](https://arxiv.org/abs/2005.11401)

---

## Abstract Summary

Large pre-trained language models store factual knowledge in their parameters, but:
1. Can't easily expand or revise knowledge
2. Provide uninterpretable predictions
3. May hallucinate

This paper proposes **Retrieval-Augmented Generation (RAG)**: models combine pre-trained parametric memory with non-parametric memory from external knowledge sources. RAG models retrieve relevant documents, use them to condition generation, and achieve strong performance on knowledge-intensive tasks while being more interpretable and easier to update.

---

## The Core Problem

### Parametric Knowledge (Standard LLMs)

```
Input → [Neural Network with billions of parameters] → Output
                ↑
         Knowledge stored here
```

**Problems**:
1. **Static**: Knowledge frozen at training time
2. **Opaque**: Can't see what model "knows"
3. **Hallucination**: May confidently generate false information
4. **Expensive to update**: Need retraining

### Example

```
Q: "Who is the current CEO of Twitter?"

GPT (2020): "Jack Dorsey"
→ Correct at training time, wrong now
→ No way to update without retraining
```

---

## The RAG Solution

### Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Query     │────▶│  Retriever   │────▶│  Documents  │
│  (Question) │     │  (DPR/BM25)  │     │  (Wikipedia)│
└─────────────┘     └──────────────┘     └──────┬──────┘
                                                │
                       ┌────────────────────────┘
                       ▼
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Answer    │◀────│   Generator  │◀────│  Concatenated│
│  (Output)   │     │   (BART/T5)  │     │  Query+Docs  │
└─────────────┘     └──────────────┘     └─────────────┘
```

### Two RAG Formulations

#### RAG-Sequence
Use same documents for entire generated sequence:
```
Retrieve(K) → p(d|q) → Generate with fixed d
```

#### RAG-Token
Can use different documents per token:
```
For each token:
  Retrieve(K) → p(d|q, previous tokens)
  Generate next token
```

---

## Key Components

### 1. Retriever: Dense Passage Retrieval (DPR)

```python
# Encode query
query_vector = bert(query)

# Encode all documents (pre-computed)
doc_vectors = [bert(doc) for doc in corpus]

# Find nearest neighbors
scores = dot(query_vector, doc_vectors.T)
top_k = argsort(scores)[-K:]
```

**Advantage over BM25**:
- Semantic matching, not just keyword
- "Car" matches "automobile"

### 2. Generator: BART/T5

```python
# Input: query + retrieved documents
input_text = f"Question: {query}\n\n"
for doc in retrieved_docs:
    input_text += f"Document: {doc}\n\n"

# Generate answer
answer = generator.generate(input_text)
```

### 3. End-to-End Training

```python
# Jointly train retriever + generator
loss = -log p(answer | query, retrieved_docs)

# Gradients flow to both components
# Retriever learns to find relevant documents
# Generator learns to use them
```

---

## Results

### Open-Domain QA

| Model | Natural Questions | TriviaQA | WebQuestions |
|-------|------------------|----------|--------------|
| BART | 32.6% | 47.6% | 27.1% |
| RAG | 44.5% | 68.0% | 45.5% |

**RAG improves significantly over parametric-only models.**

### Ablation Study

| Configuration | Accuracy |
|---------------|----------|
| RAG (full) | 44.5% |
| No retrieval | 32.6% |
| Frozen retriever | 41.2% |
| RAG-Token vs RAG-Seq | Similar |

**Training the retriever end-to-end matters.**

---

## Advantages of RAG

### 1. Easy to Update Knowledge

```python
# Add new documents to index
new_docs = load_new_wikipedia_articles()
index.add(new_docs)

# No model retraining needed!
```

### 2. Interpretable

```
Q: "Who invented the telephone?"

Retrieved documents:
1. "Alexander Graham Bell invented the telephone in 1876..."
2. "The telephone was patented by Bell..."

Answer: "Alexander Graham Bell"

→ We can see WHY the model answered this way
```

### 3. Reduced Hallucination

Grounds generation in retrieved text:
```
Without RAG: "John Smith invented the telephone" (hallucination)
With RAG: "Alexander Graham Bell invented the telephone" (grounded)
```

### 4. Handles Out-of-Domain Better

```
Training data: Wikipedia up to 2018
Test question: "Who won the 2020 election?"

Parametric model: May hallucinate or refuse
RAG with updated index: Correct answer
```

---

## RAG Variants and Extensions

### 1. Re-Ranking

```
Retrieve 100 docs (fast, approximate)
→ Re-rank with cross-encoder (slow, accurate)
→ Use top 5 for generation
```

### 2. Iterative RAG

```
For each generation step:
  Generate partial answer
  Retrieve more docs based on partial answer
  Continue generation
```

### 3. Multi-Vector RAG

```
Instead of single vector per document:
- One vector per paragraph
- One vector per sentence
- More granular retrieval
```

### 4. Graph RAG

```
Retrieve not just text, but:
- Knowledge graph triples
- Entity relationships
- Structured information
```

---

## RAG for Agents

### Why Agents Need RAG

```
Agent working on project:
- Needs to know project context
- Can't fit entire codebase in prompt
- Needs to retrieve relevant files
```

### Agent RAG Pattern

```python
def agent_step(query, codebase_index):
    # 1. Retrieve relevant context
    relevant_files = retrieve(query, codebase_index)
    
    # 2. Generate action with context
    action = llm.generate(
        query=query,
        context=relevant_files
    )
    
    # 3. Execute action
    result = execute(action)
    
    return result
```

### OpenCode Context Retrieval

```json
{
  "context": {
    "retrieval": {
      "enabled": true,
      "strategy": "hybrid",
      "top_k": 10,
      "sources": [
        "codebase",
        "documentation",
        "conversation_history"
      ]
    }
  }
}
```

---

## Best Practices

### 1. Chunking Strategy

```python
# Bad: Whole documents
docs = [load_full_file(f) for f in files]

# Good: Meaningful chunks
docs = []
for f in files:
    chunks = chunk_by_function_or_section(f)
    docs.extend(chunks)
```

### 2. Metadata Filtering

```python
# Add metadata for filtering
document = {
    "text": content,
    "metadata": {
        "file_type": "python",
        "last_modified": timestamp,
        "author": git_author
    }
}

# Retrieve with filter
results = retrieve(
    query,
    filter={"file_type": "python"}
)
```

### 3. Query Expansion

```python
# Expand query for better retrieval
original: "fix bug"
expanded: "fix bug error exception traceback debug"
```

### 4. Result Reranking

```python
# Initial retrieval (fast)
candidates = retriever.retrieve(query, k=100)

# Rerank (slow but accurate)
ranked = cross_encoder.rerank(query, candidates, k=5)
```

---

## Limitations

### 1. Retrieval Quality

```
Garbage in, garbage out:
- If retriever finds wrong docs, generation suffers
- Dense retrieval can miss exact matches
```

### 2. Context Window

```
Retrieved docs + query must fit in context window
- Can only use top K documents
- May miss relevant information
```

### 3. Computation Cost

```
- Embedding all documents (one-time)
- Retrieval per query (fast)
- Generation with longer input (slower)
```

### 4. Knowledge Boundaries

```
RAG only knows what's in index:
- If info not in corpus, can't retrieve it
- Real-time information needs live retrieval
```

---

## Modern RAG (2025)

### Evolution

| Year | Development |
|------|-------------|
| 2020 | Original RAG paper |
| 2021 | Dense Passage Retrieval improvements |
| 2022 | ChatGPT, LLMs make RAG more accessible |
| 2023 | Vector databases (Pinecone, Weaviate) |
| 2024 | Multi-modal RAG (images, code) |
| 2025 | Agentic RAG, self-correcting retrieval |

### Current Best Practices

1. **Hybrid retrieval**: Dense + Sparse
2. **Re-ranking**: Cross-encoder for precision
3. **Query rewriting**: LLM improves queries
4. **Iterative retrieval**: Retrieve as needed
5. **Self-RAG**: Model decides when to retrieve

---

## Key Takeaways

1. **RAG combines parametric + non-parametric memory**
2. **Easier to update than fine-tuning**
3. **More interpretable and verifiable**
4. **Reduces hallucination**
5. **Foundation for modern agent context management**

---

## Citation

```bibtex
@article{lewis2020retrieval,
  title={Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks},
  author={Lewis, Patrick and Perez, Ethan and Piktus, Aleksandra and 
          Petroni, Fabio and Karpukhin, Vladimir and Goyal, Naman and 
          Küttler, Heinrich and Lewis, Mike and Yih, Wen-tau and 
          Rocktäschel, Tim and Riedel, Sebastian and Kiela, Douwe},
  journal={Advances in Neural Information Processing Systems (NeurIPS)},
  year={2020}
}
```

---

*Last Updated: March 1, 2026*
