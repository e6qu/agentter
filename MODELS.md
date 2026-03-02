# AI Model Pricing & Specifications

*Comprehensive comparison of LLM API pricing, context lengths, and capabilities*

**Last Updated:** March 2, 2026 (Updated with Chinese AI Models)

---

## Table of Contents

- [OpenAI](#openai)
- [Anthropic](#anthropic)
- [Google (Gemini)](#google-gemini)
- [Alibaba (Qwen)](#alibaba-qwen)
- [DeepSeek](#deepseek)
- [Zhipu AI (GLM)](#zhipu-ai-glm)
- [Moonshot AI (Kimi)](#moonshot-ai-kimi)
- [MiniMax](#minimax)
- [Mistral AI](#mistral-ai)
- [xAI (Grok)](#xai-grok)
- [Cohere](#cohere)
- [Meta (Llama)](#meta-llama)
- [01.AI (Yi)](#01ai-yi)
- [AI21 Labs](#ai21-labs)
- [Amazon Bedrock](#amazon-bedrock)
- [Other Providers](#other-providers)
- [Quick Comparison](#quick-comparison)

---

## OpenAI

**Source:** [OpenAI API Pricing](https://developers.openai.com/api/docs/pricing/)

### GPT-5 Series (Latest Generation)

| Model | Context | Max Output | Input (1M) | Cached Input | Output (1M) | Notes |
|-------|---------|------------|------------|--------------|-------------|-------|
| GPT-5.2 | 400K | 128K | $1.75 | $0.175 | $14.00 | Flagship frontier model |
| GPT-5.1 | 256K | 64K | $1.25 | $0.125 | $10.00 | Balanced performance |
| GPT-5 | 256K | 64K | $1.25 | $0.125 | $10.00 | Standard version |
| GPT-5-mini | 256K | 64K | $0.25 | $0.025 | $2.00 | Fast, cost-effective |
| GPT-5-nano | 256K | 64K | $0.05 | $0.005 | $0.40 | Smallest, cheapest |
| GPT-5.2-pro | 400K | 128K | $21.00 | - | $168.00 | Premium tier |
| GPT-5-pro | 256K | 64K | $15.00 | - | $120.00 | High-throughput |

### GPT-4.1 Series

| Model | Context | Input (1M) | Cached Input | Output (1M) | Notes |
|-------|---------|------------|--------------|-------------|-------|
| GPT-4.1 | 1M | $2.00 | $0.50 | $8.00 | Long context specialist |
| GPT-4.1-mini | 1M | $0.40 | $0.10 | $1.60 | Balanced cost/performance |
| GPT-4.1-nano | 1M | $0.10 | $0.025 | $0.40 | Ultra-efficient |

### GPT-4o Series

| Model | Context | Input (1M) | Cached Input | Output (1M) | Notes |
|-------|---------|------------|--------------|-------------|-------|
| GPT-4o | 128K | $2.50 | $1.25 | $10.00 | Multimodal flagship |
| GPT-4o-mini | 128K | $0.15 | $0.075 | $0.60 | Fast, affordable |

### Reasoning Models (o-series)

| Model | Context | Input (1M) | Cached Input | Output (1M) | Notes |
|-------|---------|------------|--------------|-------------|-------|
| o3 | 200K | $2.00 | $0.50 | $8.00 | Advanced reasoning |
| o3-pro | 200K | $20.00 | - | $80.00 | Professional tier |
| o4-mini | 200K | $1.10 | $0.275 | $4.40 | Efficient reasoning |
| o1 | 200K | $15.00 | $7.50 | $60.00 | Legacy reasoning |
| o1-pro | 200K | $150.00 | - | $600.00 | Legacy premium |

### Real-time & Audio Models

| Model | Context | Input (1M) | Cached Input | Output (1M) | Notes |
|-------|---------|------------|--------------|-------------|-------|
| GPT-realtime | 128K | $4.00 | $0.40 | $16.00 | Voice-to-voice |
| GPT-realtime-mini | 128K | $0.60 | $0.06 | $2.40 | Fast voice |
| GPT-audio | 128K | $2.50 | - | $10.00 | Audio I/O |
| GPT-audio-mini | 128K | $0.60 | - | $2.40 | Compact audio |

### Batch API Pricing

All models support **Batch API** at **50% discount** for non-time-sensitive workloads.

---

## Anthropic

**Source:** [Anthropic Pricing](https://www.anthropic.com/pricing)

### Claude 4.6 Series (Latest)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Opus 4.6 | 1M (beta) / 200K | $5.00 (≤200K) / $10.00 (>200K) | $25.00 (≤200K) / $37.50 (>200K) | Most intelligent |
| Sonnet 4.6 | 1M (beta) / 200K | $3.00 (≤200K) / $6.00 (>200K) | $15.00 (≤200K) / $22.50 (>200K) | Best balance |
| Haiku 4.5 | 200K | $0.25 | $1.25 | Fastest, cheapest |

### Claude 4.5 Series

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Opus 4.5 | 200K | $5.00 | $25.00 | Previous flagship |
| Sonnet 4.5 | 200K | $3.00 | $15.00 | Previous mid-tier |
| Haiku 3 | 200K | $0.25 | $1.25 | Previous small |

### Prompt Caching

- **Cache Write:** 1.25x standard input price
- **Cache Read:** 10% of standard input price
- **TTL:** 5 minutes (default), extended options available

### Extended Thinking

Sonnet 4.6 and Opus 4.6 support **extended thinking** for complex reasoning tasks (additional tokens billed as output).

---

## Google (Gemini)

**Source:** [Gemini API Pricing](https://ai.google.dev/gemini-api/docs/pricing)

### Gemini 3.x Series (Latest)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Gemini 3 Pro | 1M (2M soon) | $2.00 (≤200K) / $4.00 (>200K) | $12.00 (≤200K) / $18.00 (>200K) | Most capable |
| Gemini 3.1 Pro Preview | 1M | $2.00 (≤200K) / $4.00 (>200K) | $12.00 (≤200K) / $18.00 (>200K) | Preview version |
| Gemini 3 Flash Image | 1M | $0.25 (text/img) | $1.50 (text) / $60.00 (img) | Image generation |
| Gemini 3 Image Gen | 1M | $2.00 (text/img) | $12.00 (text) / $120.00 (img) | Native image gen |

### Gemini 2.5 Series

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Gemini 2.5 Pro | 1M | $1.25 (≤200K) / $2.50 (>200K) | $10.00 (≤200K) / $15.00 (>200K) | Reasoning + search |
| Gemini 2.5 Flash | 1M | $0.30 (text/img/vid) / $1.00 (audio) | $2.50 | Hybrid reasoning |
| Gemini 2.5 Flash-Lite | 1M | $0.10 (text/img/vid) / $0.30 (audio) | $0.40 | Most cost-effective |

### Gemini 2.0 Series

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Gemini 2.0 Flash | 1M | $0.10 (text/img/vid) / $0.30 (audio) | $0.40 | High throughput |
| Gemini 2.0 Flash-Lite | 1M | $0.10 (text/img/vid) / $0.30 (audio) | $0.40 | Ultra-efficient |

### Context Caching

| Model | Cache Price (≤200K) | Cache Price (>200K) | Storage Price |
|-------|---------------------|---------------------|---------------|
| Gemini 3 Pro | $0.20 | $0.40 | $4.50/hour/1M tokens |
| Gemini 2.5 Pro | $0.125 | $0.25 | $4.50/hour/1M tokens |
| Gemini 2.5 Flash | $0.03 | $0.10 | $1.00/hour/1M tokens |
| Gemini 2.0 Flash | $0.01 | $0.03 | $1.00/hour/1M tokens |

### Batch API

**50% discount** on all models for batch processing.

### Free Tier Limits

- **Gemini 2.5 Flash:** 1,500 requests/day
- **Gemini 2.0 Flash:** 1,500 requests/day
- **Google Search Grounding:** 5,000 requests/month free

---

## DeepSeek

**Source:** [DeepSeek API Pricing](https://api-docs.deepseek.com/quick_start/pricing)

| Model | Context | Max Output | Input (1M) Cache Hit | Input (1M) Cache Miss | Output (1M) | Notes |
|-------|---------|------------|---------------------|----------------------|-------------|-------|
| DeepSeek-V3.2 | 128K | 8K (default) / 64K (max) | $0.028 | $0.28 | $0.42 | General purpose |
| DeepSeek-R1 | 128K | 32K (default) / 64K (max) | $0.028 | $0.55 | $2.19 | Reasoning model |

### Features

- **JSON Output:** Supported
- **Tool Calls:** Supported
- **Chat Prefix Completion:** Beta
- **FIM Completion:** Beta (V3.2 only)

### Note

The `deepseek-chat` and `deepseek-reasoner` endpoints correspond to DeepSeek-V3.2 with different modes (non-thinking vs thinking).

---

## Alibaba (Qwen)

**Source:** [Alibaba Cloud Model Studio](https://www.alibabacloud.com/help/en/model-studio/models)

### Qwen Flagship Models (Commercial)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Qwen-Max | 256K | $1.20 | $6.00 | Most powerful |
| Qwen-Plus | 1M | $0.40 | $1.20 | Balanced performance |
| Qwen-Flash | 1M | $0.05 | $0.40 | Fast, cost-effective |
| Qwen-Coder | 1M | $0.30 | $1.50 | Code specialist |

### Qwen3 Series (Open Source)

| Model | Context | Parameters | Notes |
|-------|---------|------------|-------|
| Qwen3-235B-A22B | 128K | 235B total / 22B active | MoE flagship |
| Qwen3-32B | 128K | 32.8B | Dense model |
| Qwen3-14B | 128K | 14B | Mid-size |
| Qwen3-8B | 128K | 8B | Small |
| Qwen3-4B | 32K | 4B | Tiny |
| Qwen3-1.7B | 32K | 1.7B | Edge |
| Qwen3-0.6B | 32K | 0.6B | Minimal |

### Third-Party Pricing (Sample)

| Model | Provider | Input (1M) | Output (1M) |
|-------|----------|------------|-------------|
| Qwen3-235B | Together AI | $0.90 | $0.90 |
| Qwen3-32B | OpenRouter | $0.08 | $0.24 |

### Multimodal Models

| Model | Type | Notes |
|-------|------|-------|
| Qwen-VL | Vision-Language | Visual understanding |
| QVQ | Visual reasoning | Reasoning with vision |
| Qwen-Omni | Omni-modal | All modalities |
| Qwen-Omni-Realtime | Real-time | Real-time multimodal |

---

## Zhipu AI (GLM)

**Source:** [Zhipu AI Pricing](https://bigmodel.cn/pricing)

### GLM-5 Series (Latest)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| GLM-5 | 128K | ¥4-6 ($0.55-0.83) | ¥18-22 ($2.50-3.05) | 744B params, coding/agent SOTA |
| GLM-5-Code | 128K | ¥6-8 ($0.83-1.10) | ¥28-32 ($3.88-4.43) | Code specialist (coming soon) |
| GLM-4.7 | 200K | ¥2-4 ($0.28-0.55) | ¥8-16 ($1.10-2.22) | High performance |
| GLM-4.5-Air | 128K | ¥0.8-1.2 ($0.11-0.17) | ¥2-8 ($0.28-1.10) | Efficient variant |
| GLM-4.7-FlashX | 200K | ¥0.50 ($0.07) | ¥3 ($0.42) | Fast and cheap |
| GLM-4.7-Flash | 200K | Free | Free | Free tier |

### GLM-4 Series

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| GLM-4-Plus | 128K | ¥5 ($0.69) | ¥2.5 ($0.35) | Flagship |
| GLM-4-Air | 128K | ¥0.5 ($0.07) | ¥0.25 ($0.03) | High-performance |
| GLM-4-AirX | 8K | ¥10 ($1.38) | N/A | Fastest |
| GLM-4-FlashX | 128K | ¥0.1 ($0.014) | ¥0.05 ($0.007) | Fast and cheap |
| GLM-4-Long | 1M | ¥1 ($0.14) | ¥0.5 ($0.07) | Long input specialist |
| GLM-4-Assistant | 128K | ¥5 ($0.69) | N/A | Agent model |

### Batch API

**50% discount** on all models for batch processing.

---

## Moonshot AI (Kimi)

**Source:** [Moonshot AI Platform](https://platform.moonshot.cn/docs/pricing/chat)

### Kimi K2.5 Series (Latest)

| Model | Context | Input (1M) Cache Hit | Input (1M) Cache Miss | Output (1M) | Notes |
|-------|---------|---------------------|----------------------|-------------|-------|
| Kimi K2.5 | 256K | ¥0.70 ($0.10) | ¥4.00 ($0.55) | ¥21.00 ($2.90) | Most capable, multimodal |
| Kimi K2-0905-Preview | 256K | ¥1.00 ($0.14) | ¥4.00 ($0.55) | ¥16.00 ($2.22) | Enhanced coding |
| Kimi K2-Turbo-Preview | 256K | ¥1.00 ($0.14) | ¥8.00 ($1.10) | ¥58.00 ($8.03) | High speed (60-100 t/s) |
| Kimi K2-Thinking | 256K | ¥1.00 ($0.14) | ¥4.00 ($0.55) | ¥16.00 ($2.22) | Reasoning model |
| Kimi K2-Thinking-Turbo | 256K | ¥1.00 ($0.14) | ¥8.00 ($1.10) | ¥58.00 ($8.03) | Fast reasoning |

### Kimi K2 Series (Previous)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Kimi K2-0711-Preview | 128K | ¥4.00 ($0.55) | ¥16.00 ($2.22) | Base K2 model |

### Moonshot V1 Series

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| moonshot-v1-8k | 8K | ¥2.00 ($0.28) | ¥10.00 ($1.38) | Legacy small |
| moonshot-v1-32k | 32K | ¥5.00 ($0.69) | ¥20.00 ($2.77) | Legacy medium |
| moonshot-v1-128k | 128K | ¥10.00 ($1.38) | ¥30.00 ($4.15) | Legacy large |

### Features

- **Architecture:** MoE with 1T total / 32B active parameters
- **Vision:** Native multimodal (images, video)
- **Thinking Mode:** Can be disabled for faster responses
- **Context Caching:** Automatic with 70% discount on cache hits
- **Tool Calling:** Full support with JSON Mode

---

## MiniMax

**Source:** [MiniMax GitHub](https://github.com/MiniMax-AI/MiniMax-01)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| MiniMax-Text-01 | 1M (4M extrapolated) | $0.20 | $1.10 | 456B params / 45.9B active |
| MiniMax-M1 | 1M | $0.40 | $2.20 | Coding optimized |
| MiniMax-VL-01 | 1M | Contact | Contact | Vision-language |

### Architecture

- **Lightning Attention:** Replaces traditional Transformer
- **4M Context:** Inference extrapolation capability
- **456B Parameters:** 45.9B activated per token

---

## Mistral AI

**Source:** [Mistral Models](https://mistral.ai/models), [Mistral Docs](https://docs.mistral.ai/)

### Flagship Models

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Mistral Large 3 | 256K | $0.50 | $1.50 | 41B active / 675B total params |
| Mistral Medium 3 | 131K | $0.40 | $2.00 | 8x lower cost alternative |
| Mistral Small 3.2 | 32K | $0.06 | $0.24 | Compact powerhouse |

### Specialized Models

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Magistral | 256K | Contact | Contact | Transparent reasoning |
| Codestral | 256K | $0.30 | $0.90 | Code generation |
| Ministral 3B | 128K | $0.04 | $0.16 | Edge deployment |
| Ministral 8B | 128K | $0.08 | $0.24 | Edge deployment |
| Ministral 14B | 128K | $0.12 | $0.36 | Edge deployment |

### Embedding & Rerank

| Model | Type | Price (1M) | Notes |
|-------|------|------------|-------|
| Mistral Embed | Embedding | $0.10 | Semantic search |
| Mistral Moderation | Moderation | $0.10 | Content safety |

### Open Weight Models (Apache 2.0)

- Devstral
- Mistral Small (self-hosted)
- Magistral (self-hosted)

---

## xAI (Grok)

**Source:** [xAI Models & Pricing](https://docs.x.ai/developers/models)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Grok 4 | 1M | $3.00 | $15.00 | Latest reasoning model |
| Grok 3 | 131K | $3.00 | $15.00 | Previous generation |
| Grok 3-mini | 131K | $0.30 | $0.50 | Efficient version |
| Grok 4.1 Fast | 131K | $0.20 | $0.50 | Budget option |

### Knowledge Cutoff

- **Grok 3 & 4:** November 2024

### Tool Invocation Costs

| Tool | Cost |
|------|------|
| Web Search | $10.00 / 1,000 calls |
| X Search | $10.00 / 1,000 calls |
| Code Interpreter | $0.05 / call |
| File Search | $0.05 / call |

### Batch API

**50% discount** for asynchronous batch processing.

### Voice Agent API

- **Price:** $0.05 / minute ($3.00 / hour)
- **Rate Limit:** 100 concurrent sessions

---

## Cohere

**Source:** [Cohere Pricing](https://cohere.com/pricing)

### Command Series

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Command R+ (08-2024) | 128K | $2.50 | $10.00 | Latest R+ |
| Command R+ (04-2024) | 128K | $3.00 | $15.00 | Previous R+ |
| Command R (03-2024) | 128K | $0.50 | $1.50 | Balanced model |
| Command | 4K | $1.00 | $2.00 | Legacy model |
| Command Light | 4K | $0.30 | $0.60 | Legacy light |

### Aya Expanse (Multilingual)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Aya Expanse 32B | 128K | $0.50 | $1.50 | Multilingual |
| Aya Expanse 8B | 128K | $0.50 | $1.50 | Multilingual |

### Rerank Models

| Model | Price (1K queries) | Notes |
|-------|-------------------|-------|
| Rerank 3.5 | $2.00 | Document ranking |
| Rerank 3 | $1.00 | Document ranking |

### Embed Models

| Model | Price (1M tokens) | Notes |
|-------|-------------------|-------|
| Embed v4 | $0.10 | Embeddings |
| Embed v3 | $0.10 | Embeddings |

---

## Meta (Llama)

Meta's Llama models are available through various providers (AWS Bedrock, Together AI, Groq, etc.) with varying prices.

### Llama 4 Series (Latest)

| Model | Context | Parameters | Notes |
|-------|---------|------------|-------|
| Llama 4 Scout | 10M | 17B active / 109B total | Industry-leading context |
| Llama 4 Maverick | 256K | 17B active / 400B total | Balanced performance |

### Llama 3.3 Series

| Model | Context | Parameters | Notes |
|-------|---------|------------|-------|
| Llama 3.3 70B | 128K | 70B | Instruction-tuned |
| Llama 3.3 8B | 128K | 8B | Compact |

### Sample Third-Party Pricing (Together AI)

| Model | Input (1M) | Output (1M) | Notes |
|-------|------------|-------------|-------|
| Llama 4 Maverick | $0.27 | $0.85 | Via Together AI |
| Llama 4 Scout | $0.18 | $0.60 | Via Together AI |
| Llama 3.3 70B | $0.88 | $0.88 | Via Together AI |
| Llama 3.3 8B | $0.20 | $0.20 | Via Together AI |

---

## 01.AI (Yi)

**Source:** [01.AI](https://github.com/01-ai/Yi)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Yi-Lightning | 16K | $0.14 | $0.14 | Fast, efficient |
| Yi-Large | 32K | $2.00 | $2.00 | High performance |
| Yi-Medium | 16K | $0.30 | $0.30 | Balanced |
| Yi-Spark | 16K | $0.10 | $0.10 | Lightweight |

### Open Source Models

| Model | Context | Parameters | License |
|-------|---------|------------|---------|
| Yi-1.5-34B | 4K | 34B | Apache 2.0 |
| Yi-1.5-9B | 4K | 9B | Apache 2.0 |
| Yi-1.5-6B | 4K | 6B | Apache 2.0 |
| Yi-Coder-9B | 128K | 9B | Apache 2.0 |
| Yi-Coder-1.5B | 128K | 1.5B | Apache 2.0 |

---

## AI21 Labs

**Source:** [Amazon Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Jamba 1.5 Large | 256K | $2.00 | $8.00 | Hybrid SSM-Transformer |
| Jamba 1.5 Mini | 256K | $0.20 | $0.40 | Efficient variant |
| Jurassic-2 Mid | 8K | $12.50 | $12.50 | Legacy mid-size |
| Jurassic-2 Ultra | 8K | $18.80 | $18.80 | Legacy large |

### Rerank Models

| Model | Price (1K queries) | Notes |
|-------|-------------------|-------|
| Rerank English v3 | $0.50 | English documents |
| Rerank Multilingual v3 | $0.50 | Multilingual |

---

## Amazon Bedrock

**Source:** [Amazon Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)

### Amazon Nova Models

| Model | Context | Input (1K) | Output (1K) | Notes |
|-------|---------|-----------|-------------|-------|
| Nova Pro | 300K | $0.80 | $3.20 | Most capable |
| Nova Lite | 300K | $0.06 | $0.24 | Balanced |
| Nova Micro | 128K | $0.035 | $0.14 | Fastest |

### On-Demand Pricing (Sample)

| Provider | Model | Input (1K) | Output (1K) | Notes |
|----------|-------|-----------|-------------|-------|
| Anthropic | Claude 3.5 Sonnet | $0.006 | $0.030 | Extended access |
| Anthropic | Claude 3.5 Sonnet v2 | $0.006 | $0.030 | With caching |
| Cohere | Command R+ | $0.003 | $0.015 | On-demand |
| Cohere | Command R | $0.0005 | $0.0015 | On-demand |
| Mistral | Mistral Large | $0.004 | $0.012 | On-demand |
| Mistral | Mistral Small | $0.0003 | $0.001 | On-demand |

### Batch Inference

**50% discount** on batch processing for supported models.

---

## Other Providers

### Together AI

**Source:** [Together AI Pricing](https://www.together.ai/pricing)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| DeepSeek-R1 | 128K | $3.00 | $7.00 | Reasoning |
| DeepSeek-V3 | 128K | $1.25 | $2.50 | General |
| Llama 4 Maverick | 256K | $0.27 | $0.85 | Latest Llama |
| Llama 4 Scout | 10M | $0.18 | $0.60 | Long context |
| Qwen3-235B | 128K | $0.90 | $0.90 | Alibaba |
| Kimi K2 Thinking | 256K | $0.60 | $2.50 | Moonshot AI |

### Fireworks AI

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Llama 4 Maverick | 256K | $0.22 | $0.88 | Optimized |
| Llama 4 Scout | 10M | $0.15 | $0.60 | Optimized |
| Mixtral 8x22B | 64K | $0.90 | $2.70 | MoE |

### Groq

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Llama 3.3 70B | 128K | $0.59 | $0.79 | Ultra-fast |
| Llama 3.3 8B | 128K | $0.05 | $0.08 | Ultra-fast |
| Mixtral 8x7B | 32K | $0.27 | $0.27 | Fast MoE |

### Perplexity

| Model | Context | Input (1M) | Notes |
|-------|---------|------------|-------|
| Sonar | 128K | $1.00 | Search-augmented |
| Sonar Pro | 200K | $3.00 | Pro search |
| Sonar Reasoning | 128K | $2.00 | With reasoning |

### Baichuan

**Source:** [Baichuan AI Platform](https://platform.baichuan-ai.com/)

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Baichuan 4 | 192K | Contact | Contact | Latest flagship |
| Baichuan 3 | 128K | Contact | Contact | Previous gen |
| Baichuan 2 | 32K | Contact | Contact | Legacy |

### HyperGAI

| Model | Context | Input (1M) | Output (1M) | Notes |
|-------|---------|------------|-------------|-------|
| Hyper-Codex | 128K | $0.30 | $0.90 | Code specialist |

---

## Quick Comparison

### Cheapest Models (per 1M input tokens)

| Model | Provider | Price | Context |
|-------|----------|-------|---------|
| GPT-5-nano | OpenAI | $0.05 | 256K |
| Gemini 2.5 Flash-Lite | Google | $0.10 | 1M |
| GPT-4.1-nano | OpenAI | $0.10 | 1M |
| Gemini 2.0 Flash | Google | $0.10 | 1M |
| Qwen-Flash | Alibaba | $0.05 | 1M |
| GLM-4.7-Flash | Zhipu AI | Free | 200K |
| GLM-4.7-FlashX | Zhipu AI | $0.07 | 200K |
| DeepSeek-V3.2 | DeepSeek | $0.28 | 128K |
| MiniMax-Text-01 | MiniMax | $0.20 | 1M |
| Yi-Lightning | 01.AI | $0.14 | 16K |

### Longest Context Windows

| Model | Provider | Context |
|-------|----------|---------|
| Llama 4 Scout | Meta | 10M |
| MiniMax-Text-01 | MiniMax | 4M (extrapolated) |
| GLM-4-Long | Zhipu AI | 1M |
| Qwen-Plus | Alibaba | 1M |
| Qwen-Flash | Alibaba | 1M |
| Gemini 3 Pro | Google | 1M (2M soon) |
| Gemini 2.5 Pro | Google | 1M |
| Gemini 2.5 Flash | Google | 1M |
| Claude Opus 4.6 | Anthropic | 1M (beta) |
| GPT-4.1 | OpenAI | 1M |

### Best Value for Coding

| Model | Provider | Input (1M) | Context |
|-------|----------|------------|---------|
| Claude Sonnet 4.6 | Anthropic | $3.00 | 200K |
| GPT-5.2 | OpenAI | $1.75 | 400K |
| GLM-5-Code | Zhipu AI | $0.83+ | 128K |
| Kimi K2.5 | Moonshot AI | $0.55+ | 256K |
| Qwen-Coder | Alibaba | $0.30 | 1M |
| DeepSeek-R1 | DeepSeek | $0.55 | 128K |
| MiniMax-M1 | MiniMax | $0.40 | 1M |
| Mistral Large 3 | Mistral AI | $0.50 | 256K |
| Yi-Coder | 01.AI | Free (OSS) | 128K |

### Premium Models (High Intelligence)

| Model | Provider | Input (1M) | Context |
|-------|----------|------------|---------|
| Claude Opus 4.6 | Anthropic | $5.00+ | 1M |
| o3-pro | OpenAI | $20.00 | 200K |
| GPT-5.2-pro | OpenAI | $21.00 | 400K |
| GLM-5 | Zhipu AI | $0.55+ | 128K |
| Gemini 3 Pro | Google | $2.00+ | 1M |
| Qwen-Max | Alibaba | $1.20 | 256K |
| Kimi K2-Thinking-Turbo | Moonshot AI | $1.10+ | 256K |

### Chinese AI Models Quick Reference

| Model | Provider | Input (1M) | Context | Strengths |
|-------|----------|------------|---------|-----------|
| DeepSeek-R1 | DeepSeek | $0.55 | 128K | Reasoning, coding |
| Qwen-Plus | Alibaba | $0.40 | 1M | Balanced, long context |
| Qwen-Flash | Alibaba | $0.05 | 1M | Cheapest 1M context |
| GLM-5 | Zhipu AI | $0.55+ | 128K | Coding, agents |
| Kimi K2.5 | Moonshot AI | $0.55+ | 256K | Coding, vision |
| MiniMax-Text-01 | MiniMax | $0.20 | 1M+ | 4M context extrapolation |
| Yi-Lightning | 01.AI | $0.14 | 16K | Efficient |

---

## Notes

- **Context lengths** represent the maximum combined input + output tokens
- **Cached input** pricing applies when using prompt caching features
- **Batch API** typically offers 50% discounts for asynchronous processing
- Prices are in USD and subject to change; always check official sources
- Some models have tiered pricing based on prompt length (e.g., ≤200K vs >200K)

## See Also

- [AGENT_COMPARISON.md](./AGENT_COMPARISON.md) - Comparison of AI agent capabilities
- [FEATURES.md](./FEATURES.md) - Feature comparison across providers
- [TOOLS_RESEARCH.md](./TOOLS_RESEARCH.md) - Tool ecosystem analysis
