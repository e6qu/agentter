# AI Models That Fit Within 128 GiB RAM

*Practical guide for running large language models on high-end Macs and workstations*

**Target Hardware**: MacBook Pro M3/M4 Max 128GB, or equivalent workstations

**Last Updated**: March 2, 2026

---

## Quick Reference

| Model | Quant | Size | Context | Speed (M3 Max) | Best For |
|-------|-------|------|---------|----------------|----------|
| **Llama 4 Scout** | Q4_K_M | 67 GB | 10M | 10-20 t/s | Long context, general use |
| **Llama 3.3 70B** | Q8_0 | 71 GB | 128K | 15-25 t/s | Maximum quality |
| **Qwen3-32B** | Q8_0 | 34 GB | 128K | 30-50 t/s | Coding, fast responses |
| **DeepSeek-R1 Distill 32B** | Q8_0 | 34 GB | 128K | 25-40 t/s | Reasoning tasks |
| **Mistral Small 3.2** | Q8_0 | 25 GB | 32K | 40-60 t/s | Speed, efficiency |
| **Llama 3.3 8B** | Q8_0 | 8 GB | 128K | 80+ t/s | Low latency |

---

## 🏆 Top Recommendations

### 1. Llama 4 Scout (17B/109B MoE)

**The 10 Million Token Context Beast**

| Quantization | Size | VRAM | Context (Practical) | Quality |
|--------------|------|------|---------------------|---------|
| Q4_K_M | 67 GB | 72 GB | ~1M tokens | ⭐⭐⭐⭐ |
| Q5_K_M | 79 GB | 84 GB | ~500K tokens | ⭐⭐⭐⭐⭐ |
| Q6_K | 91 GB | 96 GB | ~300K tokens | ⭐⭐⭐⭐⭐ |

**Why it's great**:
- Largest context window of any open model (10M tokens)
- MoE architecture: 17B active parameters out of 109B total
- Excellent for document analysis, codebases, long conversations

**Real-world usage** (from r/LocalLLaMA):
> "Llama 4 Scout fits comfortably on 128GB with Q4_K_M. I can process entire codebases in one go."

**Download**:
```bash
# Using Ollama
ollama pull llama4:scout-q4

# Using llama.cpp ( GGUF from unsloth)
huggingface-cli download unsloth/Llama-4-Scout-17B-16E-Instruct-GGUF \
  --include "*Q4_K_M*" --local-dir ./models
```

---

### 2. Llama 3.3 70B

**The Quality King**

| Quantization | Size | VRAM | Speed | Quality |
|--------------|------|------|-------|---------|
| Q4_K_M | 40 GB | 44 GB | 35-50 t/s | ⭐⭐⭐⭐ |
| Q5_K_M | 47 GB | 51 GB | 25-35 t/s | ⭐⭐⭐⭐⭐ |
| Q6_K | 54 GB | 58 GB | 20-30 t/s | ⭐⭐⭐⭐⭐ |
| Q8_0 | 71 GB | 76 GB | 15-25 t/s | ⭐⭐⭐⭐⭐ |

**Why it's great**:
- Best quality for general-purpose tasks under 128GB
- 128K context handles most use cases
- Proven, widely-tested model

**Best quant for 128GB**: Q8_0 (maximum quality with headroom)

---

### 3. Qwen3-32B

**The Efficient Performer**

| Quantization | Size | VRAM | Speed | Quality |
|--------------|------|------|-------|---------|
| Q4_K_M | 19 GB | 22 GB | 60-80 t/s | ⭐⭐⭐⭐ |
| Q5_K_M | 23 GB | 26 GB | 50-65 t/s | ⭐⭐⭐⭐⭐ |
| Q8_0 | 34 GB | 38 GB | 30-50 t/s | ⭐⭐⭐⭐⭐ |

**Why it's great**:
- Apache 2.0 license (fully commercial)
- Excellent coding performance
- Community reports Q4 ≈ Q8 quality
- Fast enough for interactive use

**Community insight** (from HN):
> "I run Qwen3-32B in both Q4 and Q8 and can barely tell the difference."

---

### 4. DeepSeek-R1 Distill Qwen 32B

**The Reasoning Specialist**

| Quantization | Size | VRAM | Speed | Reasoning |
|--------------|------|------|-------|-----------|
| Q4_K_M | 20 GB | 23 GB | 50-70 t/s | ⭐⭐⭐⭐ |
| Q8_0 | 34 GB | 38 GB | 25-40 t/s | ⭐⭐⭐⭐⭐ |

**Why it's great**:
- Distilled from 671B DeepSeek-R1
- Shows thinking/reasoning process
- Excellent for math, logic, coding
- Fits easily in 128GB with room to spare

---

### 5. Mistral Small 3.2 (24B)

**The Speed Demon**

| Quantization | Size | VRAM | Speed | Quality |
|--------------|------|------|-------|---------|
| Q4_K_M | 14 GB | 16 GB | 80+ t/s | ⭐⭐⭐⭐ |
| Q6_K | 19 GB | 22 GB | 60-75 t/s | ⭐⭐⭐⭐⭐ |
| Q8_0 | 25 GB | 28 GB | 40-60 t/s | ⭐⭐⭐⭐⭐ |

**Why it's great**:
- Surprisingly capable for its size
- Excellent for real-time applications
- Apache 2.0 license
- Community favorite for local deployment

---

## 📊 Size Tiers

### Tier 1: Under 40 GB (Room for Multiple Models)

| Model | Quant | Size | Use Case |
|-------|-------|------|----------|
| Phi-4 14B | Q8_0 | 14 GB | Fast coding assistant |
| Mistral Small 3.2 | Q8_0 | 25 GB | General purpose, fast |
| Qwen3-32B | Q8_0 | 34 GB | Coding, reasoning |
| DeepSeek-R1 Distill 32B | Q8_0 | 34 GB | Math, logic |
| Llama 3.3 70B | Q4_K_M | 40 GB | Quality on budget |

**Benefits**:
- Run multiple models simultaneously
- Fast context switching
- Room for LoRA adapters
- Can run with other apps open

---

### Tier 2: 40-80 GB (Single Large Model)

| Model | Quant | Size | Use Case |
|-------|-------|------|----------|
| Llama 3.3 70B | Q8_0 | 71 GB | Maximum quality |
| Llama 4 Scout | Q4_K_M | 67 GB | Long context |
| Aya Expanse 32B | Q8_0 | 32 GB | Multilingual |
| Gemma 3 27B | Q8_0 | 28 GB | Multimodal |

**Benefits**:
- Best quality within 128GB
- Still room for OS and apps
- Can use larger context windows

---

### Tier 3: 80-120 GB (Pushing the Limit)

| Model | Quant | Size | Notes |
|-------|-------|------|-------|
| Llama 4 Scout | Q6_K | 91 GB | Higher quality, less context |
| Llama 3.3 70B | Q8_0 + larger context | ~90 GB | With extended context |

**Caution**: Leaves little room for OS and other apps

---

## 🍎 macOS-Specific Tips

### Metal GPU Acceleration

All these models support Metal on Apple Silicon:

```bash
# llama.cpp with Metal
./main -m model.gguf -ngl 99  # offload all layers to GPU

# Ollama (automatic)
ollama run llama3.3:70b

# LM Studio (GUI, Metal enabled by default)
```

### Memory Pressure

Monitor with Activity Monitor:
- **Green**: < 100GB used - good performance
- **Yellow**: 100-120GB used - some swapping
- **Red**: > 120GB used - significant slowdown

### Unified Memory Advantage

M3/M4 Max's unified memory means:
- No CPU↔GPU transfer overhead
- Entire model stays in fast memory
- Better performance than discrete GPU setups with same VRAM

---

## 🔧 Recommended Tools

### For Beginners

**LM Studio** (https://lmstudio.ai)
- GUI for model management
- One-click downloads
- Built-in chat interface
- Automatic Metal support

```bash
# Download and run
brew install --cask lm-studio
```

### For Power Users

**Ollama** (https://ollama.com)
- Command-line interface
- Simple model management
- API server built-in
- Docker support

```bash
# Install
brew install ollama

# Run a model
ollama run llama3.3:70b

# List available models
ollama list
```

### For Maximum Control

**llama.cpp** (https://github.com/ggerganov/llama.cpp)
- Fastest inference
- Most quantization options
- Metal GPU support
- Server mode

```bash
# Build with Metal support
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
LLAMA_METAL=1 make

# Run model
./main -m model.gguf -ngl 99 -c 32768
```

---

## 📈 Performance Benchmarks

### M3 Max 128GB (Community Reported)

| Model | Quant | Tokens/sec | Notes |
|-------|-------|------------|-------|
| Llama 3.3 70B | Q4_K_M | 35-50 | Fast, good quality |
| Llama 3.3 70B | Q8_0 | 15-25 | Maximum quality |
| Qwen3-32B | Q8_0 | 30-50 | Excellent for coding |
| Mistral Small 3.2 | Q8_0 | 40-60 | Very responsive |
| DeepSeek-R1 671B | Q4_K_M | 8-22 | Via memory compression |

### M4 Max 128GB (for comparison)

| Model | Quant | Tokens/sec |
|-------|-------|------------|
| DeepSeek-R1 671B | Q4_K_M | 8-22 |
| Llama 4 Scout | Q4_K_M | 12-25 |

---

## 🎯 Use Case Recommendations

### For Coding

1. **Qwen3-32B Q8_0** (34 GB) - Fast, great code completion
2. **DeepSeek-R1 Distill 32B Q8_0** (34 GB) - Shows reasoning
3. **Llama 3.3 70B Q4_K_M** (40 GB) - Best overall quality

### For Long Documents

1. **Llama 4 Scout Q4_K_M** (67 GB) - 10M context, process books
2. **Llama 3.3 70B Q8_0** (71 GB) - 128K context, high quality
3. **Qwen3-32B Q8_0** (34 GB) - 128K context, fast

### For Multilingual

1. **Aya Expanse 32B Q8_0** (32 GB) - 23 languages
2. **Llama 4 Scout Q4_K_M** (67 GB) - 12 languages

### For Speed

1. **Mistral Small 3.2 Q8_0** (25 GB) - 40-60 t/s
2. **Phi-4 14B Q8_0** (14 GB) - 60+ t/s
3. **Qwen3-8B Q8_0** (8.5 GB) - 100+ t/s

### For Maximum Quality

1. **Llama 3.3 70B Q8_0** (71 GB) - Best dense model
2. **Llama 4 Scout Q5_K_M** (79 GB) - Best MoE model
3. **Qwen3-32B Q8_0** (34 GB) - Best quality/speed ratio

---

## 💾 Storage Requirements

| Model | GGUF Files | Download Size |
|-------|------------|---------------|
| Llama 4 Scout Q4_K_M | 2 files (split) | ~67 GB |
| Llama 3.3 70B Q8_0 | 1 file | ~71 GB |
| Qwen3-32B Q8_0 | 1 file | ~34 GB |
| DeepSeek-R1 Distill 32B | 1 file | ~34 GB |
| Mistral Small 3.2 Q8_0 | 1 file | ~25 GB |

**Recommendation**: Keep 2x the model size free for downloads and temporary files.

---

## ⚠️ What DOESN'T Fit

These models require more than 128GB:

| Model | Smallest Quant | Size | Why It Doesn't Fit |
|-------|----------------|------|-------------------|
| DeepSeek-R1 (671B) | IQ2_XS | ~195 GB | Even with 2-bit, too large |
| Qwen3-235B (MoE) | Q4_K_M | ~155 GB | 22B active, but weights are large |
| Mistral Large 3 | Q4_K_M | ~165 GB | 675B MoE, 41B active |
| Llama 4 Maverick | Q4_K_M | ~240 GB | 400B total parameters |

**Note**: Some users report running DeepSeek-R1 671B Q4 on 128GB M4 Max with memory compression, achieving 8-22 t/s. This requires specific settings and may impact stability.

---

## 🔗 Quick Links

### Download Models

- **HuggingFace GGUF**: https://huggingface.co/models?library=gguf
- **Ollama Library**: https://ollama.com/library
- **unsloth GGUFs**: https://huggingface.co/unsloth (highly optimized)
- **bartowski GGUFs**: https://huggingface.co/bartowski (comprehensive quants)

### Community Resources

- r/LocalLLaMA: https://reddit.com/r/LocalLLaMA
- llama.cpp Discord: https://discord.gg/llama-cpp
- Ollama Discord: https://discord.gg/ollama

---

## See Also

- [MODELS.md](./MODELS.md) - API pricing for hosted models
- [MODELS_OPEN_SOURCE.md](./MODELS_OPEN_SOURCE.md) - Complete self-hosting guide
- [TOOLS_RESEARCH.md](./TOOLS_RESEARCH.md) - Deployment tools comparison
