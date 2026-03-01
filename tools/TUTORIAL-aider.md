# Aider Setup Tutorial

*Reference guide based on official documentation*

---

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Basic Usage](#basic-usage)
4. [Repository Map](#repository-map)
5. [Git Integration](#git-integration)
6. [Slash Commands](#slash-commands)

---

## Installation

### Prerequisites

- Python 3.8+ or uv
- Git repository
- API key for chosen model

### Installation Methods

```bash
# Via uv (recommended)
uv tool install aider-chat

# Via pipx
pipx install aider-chat

# Via pip
python -m pip install aider-install
aider-install
```

---

## Configuration

### Configuration File

Create `.aider.conf.yml`:

```yaml
model: claude-3-5-sonnet-20241022
auto-commits: true
map-tokens: 1024
```

### Environment Variables

```bash
export ANTHROPIC_API_KEY="sk-ant-api-..."
export OPENAI_API_KEY="sk-..."
```

---

## Basic Usage

### Start Aider

```bash
# With specific model
aider --model sonnet --api-key anthropic=$ANTHROPIC_API_KEY

# With DeepSeek
aider --model deepseek --api-key deepseek=$DEEPSEEK_API_KEY

# With OpenAI
aider --model o3-mini --api-key openai=$OPENAI_API_KEY
```

### Add Files

```
/add src/main.py tests/test_main.py
```

### Make Changes

```
Update the main function to handle edge cases
```

---

## Repository Map

Aider constructs a repository map for codebase understanding.

### Configuration

```yaml
# .aider.conf.yml
map-tokens: 1024  # Default token budget
```

### How It Works

1. Tree-sitter parses code for symbol extraction
2. Graph algorithms rank symbol importance
3. Map fits within token budget

---

## Git Integration

### Auto-Commits

Enabled by default:

```yaml
auto-commits: true
```

### Manual Commands

```
/commit Commit message here
```

---

## Slash Commands

| Command | Description |
|---------|-------------|
| `/add` | Add files to chat |
| `/drop` | Remove files from chat |
| `/commit` | Commit pending changes |
| `/lint` | Run linter on changes |
| `/test` | Run test suite |
| `/voice` | Start voice input |
| `/help` | Show command help |
| `/map` | Refresh repository map |

---

## Resources

### Official Documentation

| Resource | URL |
|----------|-----|
| Aider Website | https://aider.chat |
| Documentation | https://aider.chat/docs |
| GitHub | https://github.com/Aider-AI/aider |

### Configuration

| Resource | Description |
|----------|-------------|
| Config Guide | https://aider.chat/docs/config.html |
| Repo Map | https://aider.chat/docs/repomap.html |
| Commands | https://aider.chat/docs/commands.html |

---

*Based on Aider documentation as of March 2026*
