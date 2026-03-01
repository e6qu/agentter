# Aider

**Type**: Open Source CLI Tool  
**License**: Apache 2.0  
**Primary Developer**: Paul Gauthier and contributors  
**Repository**: https://github.com/Aider-AI/aider  
**Website**: https://aider.chat/

## Overview

Aider is an AI pair programming tool that runs in the terminal. It edits code in local Git repositories and provides features like automatic Git commits, repository mapping, and voice input.

Source: [Aider Website](https://aider.chat/): "Aider lets you pair program with LLMs to start a new project or build on your existing codebase."

## Key Features

### Repository Map

Aider constructs a "repo map" - a concise representation of the codebase that includes the most important classes and functions along with their types and call signatures.

> "Aider uses a concise map of your whole git repository that includes the most important classes and functions along with their types and call signatures."

The repo map helps Aider:
- Understand code structure without reading every file
- Identify which files to examine for specific tasks
- Generate code that respects existing abstractions

Source: [Aider Repo Map Documentation](https://aider.chat/docs/repomap.html)

#### Technical Implementation

1. **Symbol Extraction**: Uses Tree-sitter parsers to identify definitions
2. **Graph Ranking**: Applies graph algorithms to rank symbol importance
3. **Token Budget**: Fits within configurable token limits (default 1k via `--map-tokens`)

Example output:
```
aider/coders/base_coder.py:
⋮...
│class Coder:
│    abs_fnames = None
⋮...
│    def run(self, with_message=None):
⋮...
```

### Git Integration

Aider provides automatic Git integration:

- **Auto-commits**: Every change is committed with descriptive messages
- **Commit messages**: Automatically generated based on changes
- **Git workflow**: Use familiar Git tools to diff, manage, and undo changes
- **Worktree support**: Works with Git worktrees for isolated branches

Source: [Aider Features](https://aider.chat/): "Aider automatically commits changes with sensible commit messages"

### Voice Input

Aider supports voice-to-code functionality:

> "Speak with aider about your code! Request new features, test cases or bug fixes using your voice"

Source: [Aider Voice Feature](https://aider.chat/)

### Image and Web Page Input

Add visual context to conversations:

> "Add images and web pages to the chat to provide visual context, screenshots, reference docs"

Source: [Aider Images Feature](https://aider.chat/)

## Installation

```bash
# Recommended: isolated install via uv
uv tool install aider-chat
aider

# Or via pip/pipx
pipx install aider-chat

# Or via pip
python -m pip install aider-install
aider-install
```

Source: [Aider Installation](https://aider.chat/docs/install.html)

## Usage

### Basic Usage

```bash
# Change to your project directory
cd /path/to/your/project

# Start with specific models
aider --model sonnet --api-key anthropic=<key>
aider --model deepseek --api-key deepseek=<key>
aider --model o3-mini --api-key openai=<key>
```

### Configuration File

Aider supports configuration via `.aider.conf.yml`:

```yaml
model: claude-3-5-sonnet-20241022
auto-commits: true
map-tokens: 1024
voice-format: wav
```

Source: [Aider Configuration](https://aider.chat/docs/config.html)

## Supported Models

Aider works with most popular LLMs:

- **Claude**: 3.7 Sonnet, 3.5 Sonnet, Opus
- **OpenAI**: GPT-4o, o1, o3-mini
- **DeepSeek**: R1, Chat V3
- **Local models**: Via Ollama
- **And more**: 100+ languages supported

Source: [Aider Models](https://aider.chat/docs/llms.html)

## Slash Commands

Aider provides built-in slash commands:

| Command | Description |
|---------|-------------|
| `/add` | Add files to the chat |
| `/drop` | Remove files from the chat |
| `/commit` | Commit changes |
| `/lint` | Run linter |
| `/test` | Run tests |
| `/voice` | Start voice input |
| `/help` | Show help |

Source: [Aider Commands](https://aider.chat/docs/commands.html)

## IDE Integration

Aider provides IDE watch mode:

> "Use aider from within your favorite IDE or editor. Ask for changes by adding comments to your code and aider will get to work."

Add `# aider:` comments in your code and Aider picks them up automatically.

Source: [Aider IDE Integration](https://aider.chat/)

## API and Customization

### Programmatic Access

Aider is primarily a CLI tool. It does not expose a formal API for external integration, but can be:

- Used as a subprocess via the `opencode run` style commands
- Integrated via the IDE watch mode
- Used with copy/paste to web chat interfaces

Source: [Aider Copy/Paste Mode](https://aider.chat/): "Aider streamlines copy/pasting code context and edits back and forth with a browser"

### Linting and Testing

Configure automatic linting and testing:

> "Automatically lint and test your code every time aider makes changes. Aider can fix problems detected by your linters and test suites."

Source: [Aider Linting](https://aider.chat/)

### Reasoning Control

Aider provides commands for controlling model reasoning:

- `/thinking-tokens` - Control thinking token budget
- `/reasoning-effort` - Set reasoning effort level

## Repository Map Details

### Token Budget

The `--map-tokens` setting controls the repo map size:

> "The token budget is influenced by the `--map-tokens` switch, which defaults to 1k tokens."

Aider adjusts dynamically but may expand significantly when no files have been added to understand the entire repository.

Source: [Aider Repo Map Tokens](https://aider.chat/docs/repomap.html)

### Graph Ranking

Aider uses graph algorithms to optimize the repo map:

> "Aider optimizes the repo map by selecting the most important parts of the codebase which will fit into the active token budget."

Source: [Aider Graph Ranking](https://aider.chat/docs/repomap.html)

## Pricing

- **Base Cost**: Free and open source (Apache 2.0)
- **Model Cost**: BYOK - pay your chosen provider directly
- **Free Tier**: Unlimited (you pay only for API calls to LLM providers)

## Sources and References

1. [Aider Official Website](https://aider.chat/)
2. [Aider Documentation](https://aider.chat/docs/)
3. [Aider GitHub Repository](https://github.com/Aider-AI/aider)
4. [Aider Repo Map Documentation](https://aider.chat/docs/repomap.html)
5. [Aider Configuration Guide](https://aider.chat/docs/config.html)

---

*Last Updated: March 1, 2026*
