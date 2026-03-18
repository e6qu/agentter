# Training Compute-Optimal Large Language Models (Chinchilla)

**Authors**: Jordan Hoffmann, Sebastian Borgeaud, Arthur Mensch, Elena Buchatskaya, Trevor Cai, Eliza Rutherford, Diego de Las Casas, Lisa Anne Hendricks, Johannes Welbl, Aidan Clark, Tom Hennigan, Eric Noland, Katie Millican, George van den Driessche, Bogdan Damoc, Aurelia Guy, Simon Osindero, Karen Simonyan, Erich Elsen, Jack W. Rae, Oriol Vinyals, Laurent Sifre
**Institution**: DeepMind
**Published**: March 2022 (NeurIPS 2022)
**Paper**: [arXiv:2203.15556](https://arxiv.org/abs/2203.15556)

---

## Abstract Summary

The paper investigates the optimal allocation of a fixed compute budget between model size and the amount of training data. By training over 400 language models ranging from 70M to 16B parameters on 5 to 500 billion tokens, the authors find that current large language models are significantly undertrained. They demonstrate that for compute-optimal training, model size and training tokens should be scaled equally: for every doubling of model size, the number of training tokens should also be doubled. This finding directly contradicted the prevailing wisdom from Kaplan et al. (2020).

---

## The Core Problem

After the Kaplan et al. (2020) scaling laws paper, the AI field adopted a strategy of making models as large as possible for a given compute budget, while training on a "relatively modest amount of data." This led to a race to scale parameters:

| Model | Parameters | Training Tokens |
|-------|-----------|-----------------|
| GPT-3 | 175B | 300B |
| Gopher | 280B | 300B |
| Jurassic-1 | 178B | 300B |
| MT-NLG | 530B | 270B |

The pattern was clear: enormous models, relatively little data. But was this the right tradeoff?

---

## The Solution: Three Approaches to Scaling Laws

The authors used three complementary approaches to determine optimal model size and training tokens for a given compute budget:

### Approach 1: Fix compute, vary model size
Train models of different sizes on different numbers of tokens, all with the same compute budget. Fit a function to find the optimal model size.

### Approach 2: IsoFLOP profiles
For a fixed set of FLOP budgets, train models of varying sizes and observe loss as a function of model size.

### Approach 3: Parametric loss function
Fit a parametric function L(N, D) to the observed losses across all models, then minimize for a given compute budget.

### The Result

All three approaches converge on the same conclusion:

**For compute-optimal training, model size N and training tokens D should be scaled in roughly equal proportions.** Specifically, for every doubling of compute, both model size and training data should increase by approximately 1.4x.

This means Gopher (280B params, 300B tokens) should have been trained as a ~70B parameter model on ~1.4T tokens for the same compute budget.

---

## Chinchilla: The Proof

To validate their findings, the authors trained Chinchilla:

| Property | Gopher | Chinchilla |
|----------|--------|------------|
| Parameters | 280B | 70B |
| Training Tokens | 300B | 1.4T |
| Training Compute | ~same | ~same |

### Results on Benchmarks

| Benchmark | Gopher (280B) | Chinchilla (70B) | Improvement |
|-----------|--------------|------------------|-------------|
| **MMLU** | 60.0% | **67.5%** | +7.5% |
| **BIG-bench** | — | Significant gains | — |
| **HellaSwag** | 79.2% | **80.8%** | +1.6% |
| **LAMBADA** | 74.5% | **77.4%** | +2.9% |
| **Reading Comprehension** | Strong | **Stronger** | Consistent gains |

Chinchilla uniformly and significantly outperforms Gopher (280B), GPT-3 (175B), Jurassic-1 (178B), and Megatron-Turing NLG (530B) on a large range of downstream evaluation tasks — despite being 4x smaller than Gopher.

---

## Why This Paper Changed Everything

### 1. Ended the "Bigger Is Always Better" Era
Before Chinchilla, the assumption was that larger models were always better for a given compute budget. This paper proved that training data matters as much as model size.

### 2. Redirected the Field
After Chinchilla, the industry shifted strategy:
- **LLaMA (2023)**: 7B-65B models trained on 1-1.4T tokens (Chinchilla-optimal)
- **Llama 2 (2023)**: Trained on 2T tokens
- **Llama 3 (2024)**: 8B-405B models trained on 15T+ tokens (over-training for inference efficiency)
- **Mistral/Mixtral**: Smaller models, extensive training

### 3. Made Open-Source Competitive
By showing that smaller, well-trained models can outperform larger ones, Chinchilla enabled the open-source community to build competitive models without requiring massive GPU clusters.

### 4. Revealed Kaplan Was Wrong
The original Kaplan scaling laws suggested allocating most compute to model size. Chinchilla showed this was a suboptimal strategy, with the correct ratio being roughly 1:1 between model size and data scaling.

---

## Implications for AI Agents

1. **Inference cost matters**: Agents make many API calls. Chinchilla showed you can get the same quality from a 4x smaller model, meaning 4x cheaper inference for agents
2. **Training efficiency**: Compute-optimal training means better models for the same budget, directly improving agent capabilities
3. **Open-weight agents**: Chinchilla's insight enabled LLaMA and its descendants, making powerful open-weight models available for local agent deployments
4. **Over-training for deployment**: Post-Chinchilla, teams deliberately "over-train" smaller models (more tokens than Chinchilla-optimal) to reduce inference costs — crucial for production agent systems

---

## Limitations and Later Developments

1. **Data availability**: Chinchilla scaling assumes unlimited high-quality data, but in practice, high-quality text data is finite
2. **Inference vs. training compute**: Chinchilla optimizes for training compute, but production systems care about inference cost. This led to "over-training" strategies (training smaller models on more data than Chinchilla-optimal)
3. **Repeated data**: The analysis assumes data is seen once; the effect of data repetition was explored in later work
4. **Scaling law instability**: Some researchers have questioned whether the exact exponents generalize across architectures and data distributions

---

## Key Takeaways

1. **Data and model size should scale together**: The 1:1 ratio is the key insight
2. **Undertrained models waste compute**: Most pre-Chinchilla LLMs were significantly undertrained
3. **Smaller + more data = better**: A 70B model trained on 1.4T tokens beats a 280B model trained on 300B tokens
4. **Scaling laws are actionable**: Proper scaling analysis can save millions in compute costs

---

## Citation

```bibtex
@inproceedings{hoffmann2022training,
  title={Training Compute-Optimal Large Language Models},
  author={Hoffmann, Jordan and Borgeaud, Sebastian and Mensch, Arthur and
          Buchatskaya, Elena and Cai, Trevor and Rutherford, Eliza and
          de Las Casas, Diego and Hendricks, Lisa Anne and Welbl, Johannes and
          Clark, Aidan and others},
  booktitle={Advances in Neural Information Processing Systems (NeurIPS)},
  year={2022}
}
```

---

*Last Updated: March 18, 2026*
