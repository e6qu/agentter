# Open Source AI Models Reference

*Comprehensive guide to open-source LLMs with quantization sizes, licenses, and hosting providers*

**Last Updated:** March 2, 2026

---

## Table of Contents

- [Legend](#legend)
- [Meta (Llama)](#meta-llama)
- [DeepSeek](#deepseek)
- [Alibaba (Qwen)](#alibaba-qwen)
- [Mistral AI](#mistral-ai)
- [Zhipu AI (GLM)](#zhipu-ai-glm)
- [01.AI (Yi)](#01ai-yi)
- [Google (Gemma)](#google-gemma)
- [Microsoft (Phi)](#microsoft-phi)
- [Cohere (Aya)](#cohere-aya)
- [NVIDIA (Nemotron)](#nvidia-nemotron)
- [Quick VRAM Guide](#quick-vram-guide)
- [Hosting Providers](#hosting-providers)

---

## Legend

### Quantization Formats

| Format | Description | Use Case |
|--------|-------------|----------|
| Q4_0 | Legacy 4-bit | ARM/AVX optimized |
| Q4_K_M | 4-bit K-quant medium | **Recommended default** |
| Q4_K_S | 4-bit K-quant small | Space-constrained |
| Q5_K_M | 5-bit K-quant medium | Higher quality |
| Q6_K | 6-bit K-quant | Near-perfect quality |
| Q8_0 | 8-bit quantization | Maximum quality |
| IQ4_XS | 4-bit I-quant extra small | Low VRAM, good quality |
| IQ3_M | 3-bit I-quant medium | Very low VRAM |
| IQ2_XS | 2-bit I-quant extra small | Extreme compression |
| FP16 | 16-bit floating point | Full precision |
| BF16 | Brain float 16 | Full precision (recommended) |
| AWQ | Activation-aware W4A16 | Inference optimized |
| GPTQ | General-purpose 4-bit | GPU inference |

### Model Architecture

| Abbreviation | Meaning |
|--------------|---------|
| MoE | Mixture of Experts |
| Dense | Standard transformer (all parameters active) |
| Active | Parameters activated per forward pass (MoE) |
| Total | Total parameters in model (MoE) |

---

## Meta (Llama)

### Llama 4 Scout

**HuggingFace:** [meta-llama/Llama-4-Scout-17B-16E](https://huggingface.co/meta-llama/Llama-4-Scout-17B-16E)  
**License:** Llama 4 Community License (Custom Commercial)  
**Architecture:** MoE (16 experts)  
**Parameters:** 17B active / 109B total  
**Context:** 10M tokens  
**Knowledge Cutoff:** August 2024

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~67 GB | ~72 GB | Recommended default |
| Q4_K_S | ~63 GB | ~68 GB | Slightly smaller |
| Q5_K_M | ~79 GB | ~84 GB | Higher quality |
| Q6_K | ~91 GB | ~96 GB | Very high quality |
| Q8_0 | ~118 GB | ~123 GB | Maximum quality |
| BF16 (full) | ~218 GB | ~230 GB | Reference quality |

**GGUF Sources:**
- [unsloth/Llama-4-Scout-17B-16E-Instruct-GGUF](https://huggingface.co/unsloth/Llama-4-Scout-17B-16E-Instruct-GGUF)
- [bartowski/Llama-4-Scout-GGUF](https://huggingface.co/bartowski/meta-llama_Llama-4-Scout-17B-16E-Instruct-GGUF)

**Hosted Providers:**
- **Together AI**: $0.18/1M input
- **Fireworks AI**: $0.15/1M input
- **Groq**: Available (ultra-fast)

---

### Llama 4 Maverick

**HuggingFace:** [meta-llama/Llama-4-Maverick-17B-128E](https://huggingface.co/meta-llama/Llama-4-Maverick-17B-128E)  
**License:** Llama 4 Community License (Custom Commercial)  
**Architecture:** MoE (128 experts)  
**Parameters:** 17B active / 400B total  
**Context:** 1M tokens  
**Knowledge Cutoff:** August 2024

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~240 GB | ~255 GB | Recommended default |
| Q5_K_M | ~285 GB | ~300 GB | Higher quality |
| Q6_K | ~328 GB | ~345 GB | Very high quality |
| BF16 (full) | ~800 GB | ~840 GB | Reference quality |

**Hosted Providers:**
- **Together AI**: $0.27/1M input
- **Fireworks AI**: $0.22/1M input

---

### Llama 3.3 70B

**HuggingFace:** [meta-llama/Llama-3.3-70B-Instruct](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct)  
**License:** Llama 3.3 Community License  
**Architecture:** Dense  
**Parameters:** 70B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| IQ2_XS | ~17 GB | ~20 GB | Very low quality |
| Q3_K_M | ~26 GB | ~30 GB | Low quality |
| Q4_K_M | ~40 GB | ~44 GB | Recommended default |
| Q5_K_M | ~47 GB | ~51 GB | Higher quality |
| Q6_K | ~54 GB | ~58 GB | Very high quality |
| Q8_0 | ~71 GB | ~75 GB | Maximum quality |
| BF16 (full) | ~140 GB | ~148 GB | Reference quality |

**Hosted Providers:**
- **Groq**: $0.59/1M input (ultra-fast)
- **Together AI**: $0.88/1M input
- **Fireworks AI**: $0.90/1M input

---

### Llama 3.3 8B

**HuggingFace:** [meta-llama/Llama-3.3-8B-Instruct](https://huggingface.co/meta-llama/Llama-3.3-8B-Instruct)  
**License:** Llama 3.3 Community License  
**Architecture:** Dense  
**Parameters:** 8B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~4.5 GB | ~6 GB | Recommended default |
| Q5_K_M | ~5.3 GB | ~7 GB | Higher quality |
| Q6_K | ~6.1 GB | ~8 GB | Very high quality |
| Q8_0 | ~8.0 GB | ~10 GB | Maximum quality |

**Hosted Providers:**
- **Groq**: $0.05/1M input
- **Together AI**: $0.20/1M input

---

## DeepSeek

### DeepSeek-V3.2

**HuggingFace:** [deepseek-ai/DeepSeek-V3.2](https://huggingface.co/deepseek-ai/DeepSeek-V3.2)  
**License:** MIT License  
**Architecture:** MoE  
**Parameters:** 37B active / 671B total  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| IQ2_XS | ~132 GB | ~145 GB | Usable quality |
| IQ3_M | ~175 GB | ~190 GB | Medium quality |
| Q3_K_M | ~220 GB | ~240 GB | Low quality |
| Q4_K_M | ~275 GB | ~295 GB | Recommended default |
| Q5_K_M | ~330 GB | ~355 GB | Higher quality |
| Q6_K | ~385 GB | ~410 GB | Very high quality |
| Q8_0 | ~500 GB | ~530 GB | Maximum quality |
| BF16 (full) | ~1.3 TB | ~1.4 TB | Reference quality |

**GGUF Sources:**
- [unsloth/DeepSeek-V3-GGUF](https://huggingface.co/unsloth/DeepSeek-V3-GGUF)
- [bartowski/DeepSeek-V3.1-GGUF](https://huggingface.co/bartowski/deepseek-ai_DeepSeek-V3.1-GGUF)

**Hosted Providers:**
- **DeepSeek API**: $0.28/1M input (cache miss)
- **Together AI**: $1.25/1M input

---

### DeepSeek-R1

**HuggingFace:** [deepseek-ai/DeepSeek-R1](https://huggingface.co/deepseek-ai/DeepSeek-R1)  
**License:** MIT License  
**Architecture:** MoE (reasoning model)  
**Parameters:** 37B active / 671B total  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| IQ1_S | ~134 GB | ~150 GB | Extreme compression |
| IQ2_S | ~197 GB | ~215 GB | Low quality |
| IQ3_M | ~292 GB | ~315 GB | Medium-low quality |
| Q3_K_M | ~319 GB | ~345 GB | Low quality |
| Q4_K_M | ~404 GB | ~430 GB | **Recommended default** |
| Q5_K_M | ~475 GB | ~505 GB | Higher quality |
| Q5_K_S | ~462 GB | ~490 GB | Good balance |
| Q6_K | ~551 GB | ~585 GB | Very high quality |
| Q8_0 | ~713 GB | ~755 GB | Maximum quality |

**GGUF Sources:**
- [bartowski/DeepSeek-R1-GGUF](https://huggingface.co/bartowski/DeepSeek-R1-GGUF) (Most comprehensive)
- [unsloth/DeepSeek-R1-GGUF](https://huggingface.co/unsloth/DeepSeek-R1-GGUF)
- [unsloth/DeepSeek-R1-0528-GGUF](https://huggingface.co/unsloth/DeepSeek-R1-0528-GGUF) (Updated version)

**Hosted Providers:**
- **DeepSeek API**: $0.55/1M input (cache miss)
- **Together AI**: $3.00/1M input

---

### DeepSeek-R1 Distill Qwen 32B

**HuggingFace:** [deepseek-ai/DeepSeek-R1-Distill-Qwen-32B](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B)  
**License:** MIT License  
**Architecture:** Dense (distilled)  
**Parameters:** 32B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~19 GB | ~22 GB | Recommended default |
| Q5_K_M | ~23 GB | ~26 GB | Higher quality |
| Q6_K | ~26 GB | ~29 GB | Very high quality |
| Q8_0 | ~34 GB | ~38 GB | Maximum quality |

**Hosted Providers:**
- **Together AI**: $0.80/1M input

---

## Alibaba (Qwen)

### Qwen3-235B-A22B

**HuggingFace:** [Qwen/Qwen3-235B-A22B](https://huggingface.co/Qwen/Qwen3-235B-A22B)  
**License:** Apache 2.0 / Qwen License  
**Architecture:** MoE (22 experts)  
**Parameters:** 22B active / 235B total  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~155 GB | ~170 GB | Recommended default |
| Q5_K_M | ~183 GB | ~200 GB | Higher quality |
| Q6_K | ~211 GB | ~230 GB | Very high quality |
| Q8_0 | ~275 GB | ~298 GB | Maximum quality |
| FP8 | ~275 GB | ~298 GB | Official format |

**GGUF Sources:**
- [Qwen/Qwen3-235B-A22B-GGUF](https://huggingface.co/Qwen/Qwen3-235B-A22B-GGUF)

**Hosted Providers:**
- **Together AI**: $0.90/1M input
- **Fireworks AI**: Available

---

### Qwen3-32B

**HuggingFace:** [Qwen/Qwen3-32B](https://huggingface.co/Qwen/Qwen3-32B)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 32B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~19 GB | ~22 GB | Recommended default |
| Q5_K_M | ~23 GB | ~26 GB | Higher quality |
| Q6_K | ~26 GB | ~29 GB | Very high quality |
| Q8_0 | ~34 GB | ~38 GB | Maximum quality |

**GGUF Sources:**
- [bartowski/Qwen3-32B-GGUF](https://huggingface.co/bartowski/Qwen_Qwen3-32B-GGUF)
- [Qwen/Qwen3-32B-GGUF](https://huggingface.co/Qwen/Qwen3-32B-GGUF)

**Hosted Providers:**
- **Together AI**: $0.30/1M input
- **Fireworks AI**: Available

---

### Qwen3-14B

**HuggingFace:** [Qwen/Qwen3-14B](https://huggingface.co/Qwen/Qwen3-14B)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 14B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~8.5 GB | ~11 GB | Recommended default |
| Q5_K_M | ~10 GB | ~13 GB | Higher quality |
| Q6_K | ~11.5 GB | ~14.5 GB | Very high quality |
| Q8_0 | ~15 GB | ~18 GB | Maximum quality |

---

### Qwen3-8B

**HuggingFace:** [Qwen/Qwen3-8B](https://huggingface.co/Qwen/Qwen3-8B)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 8B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~4.8 GB | ~6.5 GB | Recommended default |
| Q5_K_M | ~5.7 GB | ~7.5 GB | Higher quality |
| Q6_K | ~6.5 GB | ~8.5 GB | Very high quality |
| Q8_0 | ~8.5 GB | ~10.5 GB | Maximum quality |

---

### Qwen3-4B

**HuggingFace:** [Qwen/Qwen3-4B](https://huggingface.co/Qwen/Qwen3-4B)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 4B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~2.4 GB | ~4 GB | Recommended default |
| Q5_K_M | ~2.9 GB | ~4.5 GB | Higher quality |
| Q6_K | ~3.3 GB | ~5 GB | Very high quality |
| Q8_0 | ~4.3 GB | ~6 GB | Maximum quality |

---

### Qwen3-0.6B

**HuggingFace:** [Qwen/Qwen3-0.6B](https://huggingface.co/Qwen/Qwen3-0.6B)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 0.6B  
**Context:** 32K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~400 MB | ~1.5 GB | Recommended default |
| Q8_0 | ~750 MB | ~2 GB | Maximum quality |

---

## Mistral AI

### Mistral Large 3

**HuggingFace:** [mistralai/Mistral-Large-3.1-24B-Instruct-2503](https://huggingface.co/mistralai/Mistral-Large-3.1-24B-Instruct-2503)  
**License:** Mistral Research License / Commercial License  
**Architecture:** MoE  
**Parameters:** 41B active / 675B total  
**Context:** 256K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~165 GB | ~180 GB | Recommended default |
| Q5_K_M | ~195 GB | ~212 GB | Higher quality |
| Q6_K | ~225 GB | ~245 GB | Very high quality |
| Q8_0 | ~295 GB | ~320 GB | Maximum quality |

**Hosted Providers:**
- **Mistral AI API**: $0.50/1M input
- **AWS Bedrock**: Available

---

### Mistral Small 3.2 (24B)

**HuggingFace:** [mistralai/Mistral-Small-3.2-24B-Instruct-2506](https://huggingface.co/mistralai/Mistral-Small-3.2-24B-Instruct-2506)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 24B  
**Context:** 32K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~14 GB | ~16 GB | Recommended default |
| Q4_K_S | ~13.5 GB | ~15.5 GB | Smaller size |
| Q5_K_M | ~16.5 GB | ~19 GB | Higher quality |
| Q6_K | ~19 GB | ~22 GB | Very high quality |
| Q8_0 | ~25 GB | ~28 GB | Maximum quality |

**GGUF Sources:**
- [bartowski/Mistral-Small-3.2-GGUF](https://huggingface.co/bartowski/mistralai_Mistral-Small-3.2-24B-Instruct-2506-GGUF)
- [unsloth/Mistral-Small-3.2-GGUF](https://huggingface.co/unsloth/Mistral-Small-3.2-24B-Instruct-2506-GGUF)

**Hosted Providers:**
- **Mistral AI API**: $0.06/1M input
- **AWS Bedrock**: Available

---

### Mistral Small 3.1 (24B)

**HuggingFace:** [mistralai/Mistral-Small-24B-Instruct-2501](https://huggingface.co/mistralai/Mistral-Small-24B-Instruct-2501)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 24B  
**Context:** 32K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~14 GB | ~16 GB | Recommended default |
| Q8_0 | ~25 GB | ~28 GB | Maximum quality |

---

### Codestral 22B

**HuggingFace:** [mistralai/Codestral-22B-v0.1](https://huggingface.co/mistralai/Codestral-22B-v0.1)  
**License:** Mistral Non-Production License  
**Architecture:** Dense  
**Parameters:** 22B  
**Context:** 256K tokens (specialized for code)

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~13 GB | ~15 GB | Recommended default |
| Q8_0 | ~23 GB | ~26 GB | Maximum quality |

---

## Zhipu AI (GLM)

### GLM-4.5 / GLM-4

**HuggingFace:** [THUDM/glm-4-9b-chat](https://huggingface.co/THUDM/glm-4-9b-chat)  
**License:** Model License (Custom)  
**Architecture:** Dense  
**Parameters:** 9B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~5 GB | ~7 GB | Recommended default |
| Q5_K_M | ~6 GB | ~8 GB | Higher quality |
| Q8_0 | ~10 GB | ~12 GB | Maximum quality |

**Hosted Providers:**
- **Zhipu AI API**: ¥0.5-5/M tokens ($0.07-0.69)
- **Some free tiers available**

---

## 01.AI (Yi)

### Yi-Coder 9B

**HuggingFace:** [01-ai/Yi-Coder-9B-Chat](https://huggingface.co/01-ai/Yi-Coder-9B-Chat)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 9B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~5 GB | ~7 GB | Recommended default |
| Q5_K_M | ~6 GB | ~8 GB | Higher quality |
| Q8_0 | ~10 GB | ~12 GB | Maximum quality |

---

### Yi-Coder 1.5B

**HuggingFace:** [01-ai/Yi-Coder-1.5B-Chat](https://huggingface.co/01-ai/Yi-Coder-1.5B-Chat)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 1.5B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~900 MB | ~2 GB | Recommended default |
| Q8_0 | ~1.7 GB | ~3 GB | Maximum quality |

---

### Yi-1.5 34B

**HuggingFace:** [01-ai/Yi-1.5-34B-Chat](https://huggingface.co/01-ai/Yi-1.5-34B-Chat)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 34B  
**Context:** 4K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~19 GB | ~22 GB | Recommended default |
| Q8_0 | ~34 GB | ~38 GB | Maximum quality |

---

## Google (Gemma)

### Gemma 3 27B

**HuggingFace:** [google/gemma-3-27b-it](https://huggingface.co/google/gemma-3-27b-it)  
**License:** Gemma Terms of Use  
**Architecture:** Dense  
**Parameters:** 27B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_0 (QAT) | ~14 GB | ~16 GB | Official QAT quantized |
| Q4_K_M | ~15 GB | ~17 GB | Community GGUF |
| Q8_0 | ~28 GB | ~31 GB | Maximum quality |

**GGUF Sources:**
- [google/gemma-3-27b-it-qat-q4_0-gguf](https://huggingface.co/google/gemma-3-27b-it-qat-q4_0-gguf) (Official QAT)
- [Mungert/gemma-3-27b-it-GGUF](https://huggingface.co/Mungert/gemma-3-27b-it-GGUF)

**Hosted Providers:**
- **AWS Bedrock**: Available
- **Google AI Studio**: Free tier available

---

### Gemma 3 12B

**HuggingFace:** [google/gemma-3-12b-it](https://huggingface.co/google/gemma-3-12b-it)  
**License:** Gemma Terms of Use  
**Architecture:** Dense  
**Parameters:** 12B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_0 (QAT) | ~6 GB | ~8 GB | Official QAT quantized |
| Q4_K_M | ~7 GB | ~9 GB | Community GGUF |
| Q8_0 | ~13 GB | ~15 GB | Maximum quality |

---

### Gemma 3 4B

**HuggingFace:** [google/gemma-3-4b-it](https://huggingface.co/google/gemma-3-4b-it)  
**License:** Gemma Terms of Use  
**Architecture:** Dense  
**Parameters:** 4B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_0 (QAT) | ~2 GB | ~4 GB | Official QAT quantized |
| Q4_K_M | ~2.4 GB | ~4 GB | Community GGUF |
| Q8_0 | ~4.3 GB | ~6 GB | Maximum quality |

---

## Microsoft (Phi)

### Phi-4 14B

**HuggingFace:** [microsoft/phi-4](https://huggingface.co/microsoft/phi-4)  
**License:** MIT License  
**Architecture:** Dense  
**Parameters:** 14B  
**Context:** 16K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~8 GB | ~10 GB | Recommended default |
| Q8_0 | ~14 GB | ~16 GB | Maximum quality |

---

### Phi-3 Medium 14B

**HuggingFace:** [microsoft/Phi-3-medium-128k-instruct](https://huggingface.co/microsoft/Phi-3-medium-128k-instruct)  
**License:** MIT License  
**Architecture:** Dense  
**Parameters:** 14B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~8 GB | ~10 GB | Recommended default |
| Q8_0 | ~14 GB | ~16 GB | Maximum quality |

---

### Phi-3 Mini 3.8B

**HuggingFace:** [microsoft/Phi-3-mini-128k-instruct](https://huggingface.co/microsoft/Phi-3-mini-128k-instruct)  
**License:** MIT License  
**Architecture:** Dense  
**Parameters:** 3.8B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~2.2 GB | ~4 GB | Recommended default |
| Q8_0 | ~4 GB | ~6 GB | Maximum quality |

---

## Cohere (Aya)

### Aya Expanse 32B

**HuggingFace:** [CohereForAI/aya-expanse-32b](https://huggingface.co/CohereForAI/aya-expanse-32b)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 32B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~18 GB | ~21 GB | Recommended default |
| Q8_0 | ~32 GB | ~36 GB | Maximum quality |

**Hosted Providers:**
- **Cohere API**: $0.50/1M input

---

### Aya Expanse 8B

**HuggingFace:** [CohereForAI/aya-expanse-8b](https://huggingface.co/CohereForAI/aya-expanse-8b)  
**License:** Apache 2.0  
**Architecture:** Dense  
**Parameters:** 8B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~4.8 GB | ~6.5 GB | Recommended default |
| Q8_0 | ~8.5 GB | ~10.5 GB | Maximum quality |

---

## NVIDIA (Nemotron)

### Nemotron-4 340B

**HuggingFace:** [nvidia/Nemotron-4-340B-Instruct](https://huggingface.co/nvidia/Nemotron-4-340B-Instruct)  
**License:** NVIDIA Open Model License  
**Architecture:** Dense  
**Parameters:** 340B  
**Context:** 4K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~195 GB | ~215 GB | Recommended default |
| Q8_0 | ~340 GB | ~370 GB | Maximum quality |

---

### Llama-3.1-Nemotron-70B-Instruct

**HuggingFace:** [nvidia/Llama-3.1-Nemotron-70B-Instruct](https://huggingface.co/nvidia/Llama-3.1-Nemotron-70B-Instruct)  
**License:** NVIDIA Open Model License  
**Architecture:** Dense (based on Llama 3.1)  
**Parameters:** 70B  
**Context:** 128K tokens

| Quantization | Size | VRAM Required | Notes |
|--------------|------|---------------|-------|
| Q4_K_M | ~40 GB | ~44 GB | Recommended default |
| Q8_0 | ~71 GB | ~76 GB | Maximum quality |

---

## Quick VRAM Guide

### Consumer GPU Tiers

| GPU VRAM | Recommended Models | Quantization |
|----------|-------------------|--------------|
| 8 GB | Qwen3-4B, Yi-Coder-1.5B, Phi-3 Mini | Q4_K_M, Q8_0 |
| 12 GB | Qwen3-8B, Mistral Small 3.2, Yi-Coder 9B | Q4_K_M |
| 16 GB | Qwen3-14B, Llama 3.3 8B, Mistral Small 3.2 | Q8_0 |
| 24 GB | Qwen3-32B, DeepSeek-R1 Distill 32B, Llama 3.3 70B (Q4) | Q4_K_M |
| 48 GB | Llama 3.3 70B (Q8), Qwen3-235B (IQ2/IQ3) | Mixed |
| 80 GB+ | Llama 3.3 70B (BF16), DeepSeek-V3 (IQ2) | FP16/BF16 |

### Rule of Thumb

```
Required VRAM ≈ Model Size (GB) × 1.1 + 2 GB (overhead)
```

For example:
- 70B model at Q4_K_M (~40 GB) needs ~46 GB VRAM
- 8B model at Q4_K_M (~4.5 GB) needs ~7 GB VRAM

---

## Hosting Providers

### Free Tier Providers

| Provider | Free Tier | Models Available |
|----------|-----------|------------------|
| **Google AI Studio** | 1,500 req/day | Gemini, Gemma |
| **Groq** | Limited | Llama, Mixtral, Gemma |
| **Zhipu AI** | Free tier | GLM-4-Flash |
| **HuggingFace** | Limited | Various open models |

### Commercial Providers (Open Source Models)

| Provider | Pricing Model | Notable Models |
|----------|---------------|----------------|
| **Together AI** | Per-token | Llama 4, DeepSeek, Qwen, Nemotron |
| **Fireworks AI** | Per-token | Llama 4, Mixtral, Gemma |
| **Groq** | Per-token | Llama, Mixtral (ultra-fast) |
| **Mistral AI** | Per-token | Mistral Large, Small, Codestral |
| **DeepSeek** | Per-token | DeepSeek-V3, R1 (cheapest) |
| **AWS Bedrock** | Per-token | Llama, Mistral, Cohere, Titan |
| **Google Vertex AI** | Per-token | Gemma, Llama |

### GGUF Conversion Tools

| Tool | Purpose | Link |
|------|---------|------|
| **llama.cpp** | GGUF quantization | [ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp) |
| **unsloth** | Fast fine-tuning + GGUF | [unsloth/unsloth](https://github.com/unsloth/unsloth) |
| **Ollama** | Easy local deployment | [ollama/ollama](https://github.com/ollama/ollama) |
| **LM Studio** | GUI for local models | [lmstudio.ai](https://lmstudio.ai) |
| **text-generation-webui** | Web UI for models | [oobabooga/text-generation-webui](https://github.com/oobabooga/text-generation-webui) |

---

## Notes

- **MoE models** (like DeepSeek-V3, Qwen3-235B, Llama 4) require significantly less VRAM for inference than their total parameter count suggests, as only a subset of experts are active per token.
- **Q4_K_M** is generally the best balance of quality and size for most use cases.
- **I-quants** (IQ2, IQ3, IQ4) offer better quality than equivalent K-quants at very low bit rates but may be slower on some hardware.
- Always verify the license before commercial use - some models have custom licenses despite being "open source."
- Context length can affect VRAM usage significantly - longer context = more KV cache memory required.

## See Also

- [MODELS.md](./MODELS.md) - Complete API pricing comparison
- [AGENT_COMPARISON.md](./AGENT_COMPARISON.md) - AI agent capabilities
- [TOOLS_RESEARCH.md](./TOOLS_RESEARCH.md) - Local deployment tools
