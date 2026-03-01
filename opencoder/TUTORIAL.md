# OpenCode Complete Setup Tutorial

*Production-ready development environment with plugins, skills, agents, and security*

---

## Table of Contents

1. [Initial Setup](#initial-setup)
2. [Project Structure](#project-structure)
3. [Credential Protection](#credential-protection)
4. [Proxy Configuration](#proxy-configuration)
5. [Skills Setup](#skills-setup)
6. [Custom Agents](#custom-agents)
7. [Heartbeat Agents](#heartbeat-agents)
8. [Hooks & Plugins](#hooks--plugins)
9. [Sandboxing & Security](#sandboxing--security)
10. [Deterministic Checks](#deterministic-checks)
11. [Multi-Provider Setup](#multi-provider-setup)
12. [Complete Configuration Example](#complete-configuration-example)

---

## Initial Setup

### Step 1: Install OpenCode

```bash
# Install via npm
npm install -g opencode

# Or download binary
curl -fsSL https://opencode.ai/install.sh | sh

# Verify installation
opencode --version
```

### Step 2: Authentication (Multi-Provider)

```bash
# Configure providers
opencode provider add anthropic --api-key $ANTHROPIC_API_KEY
opencode provider add openai --api-key $OPENAI_API_KEY
opencode provider add gemini --api-key $GEMINI_API_KEY

# List configured providers
opencode provider list

# Set default
opencode provider default anthropic
```

### Step 3: Initialize Project

```bash
cd /path/to/your-project
opencode init

# This creates:
# .opencode/
# ├── opencode.json
# ├── agents/
# ├── skills/
# └── plugins/
```

---

## Project Structure

```
your-project/
├── .opencode/
│   ├── opencode.json              # Main configuration
│   ├── opencode.local.json        # Local overrides (gitignored)
│   ├── AGENTS.md                  # Project instructions
│   ├── agents/                    # Custom agents
│   │   ├── code-reviewer.json
│   │   ├── test-writer.json
│   │   └── unstuck-monitor.json   # Heartbeat agent
│   ├── skills/                    # Reusable skills
│   │   ├── onboarding/
│   │   │   └── SKILL.md
│   │   ├── deployment/
│   │   │   └── SKILL.md
│   │   └── refactoring/
│   │       └── SKILL.md
│   ├── plugins/                   # Automation plugins
│   │   ├── credential-guard.js
│   │   ├── unstuck-detector.js    # Heartbeat plugin
│   │   ├── safety-check.js
│   │   └── lib/
│   │       └── deterministic.js
│   └── sandbox/                   # Sandboxing configs
│       └── Dockerfile
├── .opencode.md                   # Alternative: Project instructions
└── .gitignore                     # Exclude .opencode.local.json
```

### Gitignore Setup

```bash
cat >> .gitignore << 'EOF'
# OpenCode local settings
.opencode/opencode.local.json
.opencode/.credentials/
.opencode/.logs/
.opencode/.cache/
.opencode/.heartbeat/
.opencode/.ci-checks/

# State files
.opencode/.deterministic/
.opencode/.code-reviews/

# Plugin temp files
.opencode/plugins/*.tmp
EOF
```

---

## Credential Protection

### Strategy 1: Environment Variables

```bash
# ~/.bashrc or ~/.zshrc
export ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}"
export OPENAI_API_KEY="${OPENAI_API_KEY}"
export GITHUB_TOKEN="${GITHUB_TOKEN}"
export DATABASE_URL="${DATABASE_URL}"
```

### Strategy 2: Local Config (Gitignored)

```json
{
  "providers": {
    "anthropic": {
      "apiKey": "${ANTHROPIC_API_KEY}",
      "defaultModel": "claude-3-5-sonnet-20241022"
    },
    "openai": {
      "apiKey": "${OPENAI_API_KEY}",
      "defaultModel": "gpt-4"
    }
  },
  "env": {
    "DATABASE_URL": "${DATABASE_URL}",
    "REDIS_URL": "${REDIS_URL}"
  }
}
```

### Strategy 3: Credential Guard Plugin

```javascript
// .opencode/plugins/credential-guard.js
const crypto = require('crypto');

module.exports = {
  name: 'credential-guard',
  hooks: {
    'on:file:write:before': async (event) => {
      const { content, path, logger } = event;
      
      // Patterns to detect
      const patterns = [
        { regex: /api[_-]?key\s*[=:]\s*["'][a-zA-Z0-9]{20,}["']/i, name: 'API Key' },
        { regex: /password\s*[=:]\s*["'][^"']{8,}["']/i, name: 'Password' },
        { regex: /secret\s*[=:]\s*["'][a-zA-Z0-9]{20,}["']/i, name: 'Secret' },
        { regex: /sk-[a-zA-Z0-9]{48}/, name: 'OpenAI/Anthropic Key' },
        { regex: /AKIA[0-9A-Z]{16}/, name: 'AWS Access Key' },
        { regex: /gh[pousr]_[A-Za-z0-9_]{36}/, name: 'GitHub Token' }
      ];
      
      for (const { regex, name } of patterns) {
        if (regex.test(content)) {
          logger.error(`CREDENTIAL LEAK DETECTED: ${name} in ${path}`);
          throw new Error(
            `Potential ${name} detected in ${path}. ` +
            `Use environment variables or .opencode/opencode.local.json instead.`
          );
        }
      }
    },
    
    'on:tool:use:before': async (event) => {
      const { tool, input, logger } = event;
      
      if (tool === 'Bash' && input.command) {
        // Check for credential exposure in commands
        const dangerous = /(password|secret|key|token)\s*=\s*\S+/i;
        if (dangerous.test(input.command)) {
          logger.error('Command may expose credentials');
          throw new Error('Use environment variables for credentials');
        }
      }
    }
  }
};
```

### Strategy 4: Encrypted Credential Store

```javascript
// .opencode/plugins/secure-credentials.js
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const CREDENTIALS_FILE = '.opencode/.credentials/encrypted.env';
const KEY_FILE = '.opencode/.credentials/.key';

module.exports = {
  name: 'secure-credentials',
  hooks: {
    'on:session:start': async ({ logger }) => {
      if (fs.existsSync(CREDENTIALS_FILE)) {
        // Load and decrypt credentials
        const key = getOrCreateKey();
        const encrypted = fs.readFileSync(CREDENTIALS_FILE);
        const decrypted = decrypt(encrypted, key);
        
        // Set as environment variables
        const env = parseEnv(decrypted);
        Object.assign(process.env, env);
        
        logger.info('Secure credentials loaded');
      }
    }
  }
};

function getOrCreateKey() {
  if (fs.existsSync(KEY_FILE)) {
    return fs.readFileSync(KEY_FILE);
  }
  const key = crypto.randomBytes(32);
  fs.mkdirSync(path.dirname(KEY_FILE), { recursive: true });
  fs.writeFileSync(KEY_FILE, key, { mode: 0o600 });
  return key;
}

function decrypt(data, key) {
  const iv = data.slice(0, 16);
  const encrypted = data.slice(16);
  const decipher = crypto.createDecipheriv('aes-256-gcm', key, iv);
  return Buffer.concat([decipher.update(encrypted), decipher.final()]);
}

function parseEnv(content) {
  const env = {};
  content.toString().split('\n').forEach(line => {
    const [key, ...valueParts] = line.split('=');
    if (key && valueParts.length > 0) {
      env[key.trim()] = valueParts.join('=').trim();
    }
  });
  return env;
}
```

---

## Proxy Configuration

### Global Proxy Settings

```bash
# Environment variables
export HTTP_PROXY="http://proxy.company.com:8080"
export HTTPS_PROXY="http://proxy.company.com:8080"
export NO_PROXY="localhost,127.0.0.1,.local"

# OpenCode specific
export OPENCODE_PROXY="http://proxy.company.com:8080"
```

### Provider-Specific Proxy

```json
{
  "providers": {
    "anthropic": {
      "apiKey": "${ANTHROPIC_API_KEY}",
      "proxy": {
        "url": "http://proxy.company.com:8080",
        "strictSSL": false
      }
    },
    "openai": {
      "apiKey": "${OPENAI_API_KEY}",
      "proxy": {
        "url": "socks5://localhost:1080"
      }
    }
  }
}
```

### Proxy with Authentication

```javascript
// .opencode/plugins/proxy-auth.js
const fs = require('fs');

module.exports = {
  name: 'proxy-auth',
  hooks: {
    'on:session:start': async ({ config, logger }) => {
      // Load proxy credentials securely
      const proxyCreds = fs.readFileSync(
        '.opencode/.credentials/proxy', 
        'utf8'
      ).trim();
      
      // Set for all providers
      for (const [name, provider] of Object.entries(config.providers)) {
        if (provider.proxy) {
          provider.proxy.auth = proxyCreds;
          logger.info(`Proxy auth configured for ${name}`);
        }
      }
    }
  }
};
```

---

## Skills Setup

### Skill 1: Code Refactoring

```markdown
---
name: refactoring
description: Systematic code refactoring with safety checks
license: MIT
metadata:
  category: development
  tools: [Read, Edit, Grep, Bash]
---

## Pre-Refactoring Checklist

- [ ] Tests exist and pass
- [ ] Git state is clean
- [ ] Scope is well-defined

## Refactoring Process

1. **Analyze current code**
   - Identify code smells
   - Check test coverage
   - Document dependencies

2. **Create safety net**
   - Run existing tests
   - Add characterization tests if needed
   - Commit current state

3. **Refactor incrementally**
   - Small, testable changes
   - Run tests after each change
   - Commit frequently

4. **Verify results**
   - All tests pass
   - No behavior changes
   - Code is cleaner

## Safety Rules

- Never refactor without tests
- One refactoring per commit
- If tests break, revert and reassess
```

### Skill 2: Test Generation

```markdown
---
name: test-generation
description: Generate comprehensive tests for code
tools: [Read, Grep, Edit, Bash]
metadata:
  category: testing
  frameworks: [jest, vitest, pytest]
---

## Test Generation Process

1. **Analyze code under test**
   - Read the implementation
   - Identify public API
   - Find edge cases

2. **Generate test cases**
   - Happy path
   - Error cases
   - Edge cases
   - Boundary conditions

3. **Test structure**
   ```javascript
   describe('functionName', () => {
     it('handles normal case', () => {});
     it('handles error case', () => {});
     it('handles edge case', () => {});
   });
   ```

4. **Verify coverage**
   - Run tests
   - Check coverage report
   - Fill gaps
```

---

## Custom Agents

### Agent 1: Code Reviewer

```json
{
  "name": "code-reviewer",
  "description": "Comprehensive code reviewer",
  "system": "You are an experienced code reviewer.

CHECKS:
1. Correctness - Does it do what it claims?
2. Readability - Is it easy to understand?
3. Maintainability - Will it be easy to change?
4. Performance - Any obvious inefficiencies?
5. Security - Any vulnerabilities?
6. Testing - Are there adequate tests?

OUTPUT:
- APPROVE, REQUEST_CHANGES, or COMMENT
- Specific line comments
- Actionable suggestions",
  "tools": ["Read", "Grep", "Glob"],
  "provider": "anthropic",
  "model": "claude-3-5-sonnet-20241022"
}
```

### Agent 2: Test Writer

```json
{
  "name": "test-writer",
  "description": "Generates comprehensive tests",
  "system": "You write thorough tests.

APPROACH:
1. Read implementation
2. Identify testable behaviors
3. Generate tests covering:
   - Normal cases
   - Error cases
   - Edge cases
   - Boundary conditions

STYLE:
- Descriptive test names
- Arrange-Act-Assert pattern
- One assertion per test (generally)
- Mock external dependencies",
  "tools": ["Read", "Edit", "Grep"],
  "provider": "openai",
  "model": "gpt-4"
}
```

### Agent 3: Unstuck Monitor

```json
{
  "name": "unstuck-monitor",
  "description": "Detects stuck agents and suggests recovery",
  "system": "You monitor agent progress and detect stuck states.

STUCK INDICATORS:
- Repeated error messages
- Circular edits on same file
- No progress markers for 10+ minutes
- Increasingly desperate attempts

INTERVENTION:
1. Analyze the situation
2. Identify the root cause
3. Suggest fresh approaches:
   - Break into smaller steps
   - Try different algorithm
   - Simplify requirements
   - Ask clarifying questions

BE HELPFUL AND ENCOURAGING.",
  "tools": ["Read", "Bash", "Grep"],
  "hooks": ["on:interval:300"]
}
```

---

## Heartbeat Agents

### Unstuck Detection Plugin

```javascript
// .opencode/plugins/unstuck-detector.js
const fs = require('fs');
const path = require('path');

const STATE_DIR = '.opencode/.heartbeat';
const EDIT_LOG = path.join(STATE_DIR, 'edits.jsonl');
const ERROR_LOG = path.join(STATE_DIR, 'errors.jsonl');

module.exports = {
  name: 'unstuck-detector',
  hooks: {
    'on:session:start': async ({ logger, agent }) => {
      fs.mkdirSync(STATE_DIR, { recursive: true });
      
      // Start heartbeat interval
      setInterval(async () => {
        await checkIfStuck(logger, agent);
      }, 300000); // 5 minutes
      
      logger.info('Unstuck detector active');
    },
    
    'on:file:write:after': async (event) => {
      // Log file edits for pattern analysis
      const entry = {
        timestamp: Date.now(),
        path: event.path,
        agent: event.agent
      };
      fs.appendFileSync(EDIT_LOG, JSON.stringify(entry) + '\n');
    },
    
    'on:tool:error': async (event) => {
      // Log errors
      const entry = {
        timestamp: Date.now(),
        error: event.error,
        tool: event.tool
      };
      fs.appendFileSync(ERROR_LOG, JSON.stringify(entry) + '\n');
    }
  }
};

async function checkIfStuck(logger, agent) {
  // Check for edit loops
  if (!fs.existsSync(EDIT_LOG)) return;
  
  const recentEdits = fs.readFileSync(EDIT_LOG, 'utf8')
    .split('\n')
    .filter(Boolean)
    .slice(-50)
    .map(line => JSON.parse(line));
  
  // Count edits per file in last 10 minutes
  const tenMinutesAgo = Date.now() - 600000;
  const recent = recentEdits.filter(e => e.timestamp > tenMinutesAgo);
  
  const fileCounts = {};
  for (const edit of recent) {
    fileCounts[edit.path] = (fileCounts[edit.path] || 0) + 1;
  }
  
  // Check for stuck indicators
  const stuckFiles = Object.entries(fileCounts)
    .filter(([_, count]) => count > 5)
    .map(([file, count]) => ({ file, count }));
  
  if (stuckFiles.length > 0) {
    logger.warn('STUCK DETECTED: High edit frequency', { stuckFiles });
    
    // Trigger intervention
    await agent.run('@unstuck-monitor', {
      prompt: `High edit frequency detected on: ${stuckFiles.map(f => f.file).join(', ')}. ` +
              `Please analyze and suggest alternative approaches.`
    });
  }
  
  // Check for repetitive errors
  if (fs.existsSync(ERROR_LOG)) {
    const recentErrors = fs.readFileSync(ERROR_LOG, 'utf8')
      .split('\n')
      .filter(Boolean)
      .slice(-20)
      .map(line => JSON.parse(line))
      .filter(e => e.timestamp > tenMinutesAgo);
    
    const errorTypes = {};
    for (const err of recentErrors) {
      const key = err.error.substring(0, 50); // First 50 chars
      errorTypes[key] = (errorTypes[key] || 0) + 1;
    }
    
    const repetitiveErrors = Object.entries(errorTypes)
      .filter(([_, count]) => count > 3);
    
    if (repetitiveErrors.length > 0) {
      logger.warn('STUCK DETECTED: Repetitive errors', { repetitiveErrors });
    }
  }
}
```

### Health Check Plugin

```javascript
// .opencode/plugins/health-check.js
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const STATE_DIR = '.opencode/.heartbeat';
const INTERVAL_MS = 30 * 60 * 1000; // 30 minutes

module.exports = {
  name: 'health-check',
  hooks: {
    'on:session:start': async ({ logger }) => {
      fs.mkdirSync(STATE_DIR, { recursive: true });
      
      setInterval(async () => {
        await runHealthCheck(logger);
      }, INTERVAL_MS);
      
      logger.info('Health check scheduled (30min interval)');
    }
  }
};

async function runHealthCheck(logger) {
  const reportFile = path.join(STATE_DIR, `report-${Date.now()}.json`);
  
  const checks = {
    timestamp: Date.now(),
    tests: false,
    lint: false,
    types: false,
    security: false
  };
  
  try {
    execSync('npm test --silent', { timeout: 120000 });
    checks.tests = true;
  } catch (e) {
    logger.error('Health check: Tests failing');
  }
  
  try {
    execSync('npm run lint --silent', { timeout: 60000 });
    checks.lint = true;
  } catch (e) {
    logger.warn('Health check: Lint warnings');
  }
  
  try {
    execSync('npm run typecheck --silent', { timeout: 60000 });
    checks.types = true;
  } catch (e) {
    logger.error('Health check: Type errors');
  }
  
  try {
    const audit = execSync('npm audit --json', { timeout: 60000 });
    const vulnerabilities = JSON.parse(audit).vulnerabilities;
    checks.security = Object.keys(vulnerabilities).length === 0;
    if (!checks.security) {
      logger.warn('Health check: Security vulnerabilities found');
    }
  } catch (e) {
    checks.security = false;
  }
  
  fs.writeFileSync(reportFile, JSON.stringify(checks, null, 2));
  
  const allPassed = Object.values(checks).every(v => v === true);
  if (allPassed) {
    logger.info('Health check: All checks passed');
  } else {
    logger.warn('Health check: Some checks failed', checks);
  }
}
```

---

## Hooks & Plugins

### Safety Check Plugin

```javascript
// .opencode/plugins/safety-check.js
module.exports = {
  name: 'safety-check',
  hooks: {
    'on:tool:use:before': async (event) => {
      const { tool, input, logger, session } = event;
      
      if (tool === 'Bash' && input.command) {
        const dangerous = [
          { pattern: /rm\s+-rf\s+\//, reason: 'Destructive deletion' },
          { pattern: /sudo/, reason: 'Privilege escalation' },
          { pattern: /mkfs/, reason: 'Filesystem formatting' },
          { pattern: /dd\s+if=/, reason: 'Direct disk write' },
          { pattern: />\s*\/[^\/]/, reason: 'Root filesystem overwrite' }
        ];
        
        for (const { pattern, reason } of dangerous) {
          if (pattern.test(input.command)) {
            // Check if in sandbox/worktree
            const isSandbox = process.env.OPENCODE_SANDBOX === 'true';
            
            if (!isSandbox) {
              logger.error(`Blocked: ${reason}`);
              throw new Error(
                `${reason} blocked in main directory. ` +
                `Use ephemeral environment: opencode sandbox --ephemeral`
              );
            }
          }
        }
      }
      
      // Check credential exposure in file writes
      if ((tool === 'Write' || tool === 'Edit') && input.content) {
        const credentialPatterns = [
          /sk-[a-zA-Z0-9]{48}/,
          /AKIA[0-9A-Z]{16}/,
          /gh[pousr]_[A-Za-z0-9_]{36}/
        ];
        
        for (const pattern of credentialPatterns) {
          if (pattern.test(input.content)) {
            logger.error('Credential exposure detected');
            throw new Error('Credentials detected in file content');
          }
        }
      }
    }
  }
};
```

### Session Start Plugin

```javascript
// .opencode/plugins/session-start.js
const fs = require('fs');
const path = require('path');

module.exports = {
  name: 'session-start',
  hooks: {
    'on:session:start': async ({ config, logger }) => {
      logger.info('OpenCode session started');
      
      // Show available agents
      const agentsDir = '.opencode/agents';
      if (fs.existsSync(agentsDir)) {
        const agents = fs.readdirSync(agentsDir)
          .filter(f => f.endsWith('.json'))
          .map(f => {
            const agent = JSON.parse(fs.readFileSync(path.join(agentsDir, f)));
            return `  @${agent.name} - ${agent.description}`;
          });
        
        if (agents.length > 0) {
          logger.info('Available agents:');
          agents.forEach(a => logger.info(a));
        }
      }
      
      // Show available skills
      const skillsDir = '.opencode/skills';
      if (fs.existsSync(skillsDir)) {
        const skills = fs.readdirSync(skillsDir)
          .filter(d => fs.existsSync(path.join(skillsDir, d, 'SKILL.md')))
          .map(d => `  /${d}`);
        
        if (skills.length > 0) {
          logger.info('Available skills:');
          skills.forEach(s => logger.info(s));
        }
      }
      
      // Load local credentials
      const localConfig = '.opencode/opencode.local.json';
      if (fs.existsSync(localConfig)) {
        const local = JSON.parse(fs.readFileSync(localConfig));
        if (local.env) {
          Object.assign(process.env, local.env);
          logger.info('Local credentials loaded');
        }
      }
    }
  }
};
```

---

## Sandboxing & Security

### Docker Sandbox

```dockerfile
# .opencode/sandbox/Dockerfile
FROM node:20-alpine

WORKDIR /workspace

# Install security tools
RUN apk add --no-cache git curl ca-certificates

# Create non-root user
RUN addgroup -g 1000 opencode && \
    adduser -u 1000 -G opencode -s /bin/sh -D opencode

# Set up volume for read-only mount
VOLUME ["/workspace"]

# Run as non-root
USER opencode

# Security: No new privileges
SECURITY_OPT no-new-privileges:true

# Drop all capabilities
CAP_DROP ALL

# Read-only root filesystem
READ_ONLY true
```

```yaml
# docker-compose.yml for sandbox
version: '3.8'
services:
  opencode-sandbox:
    build: .opencode/sandbox
    volumes:
      - type: bind
        source: .
        target: /workspace
        read_only: true
    environment:
      - OPENCODE_SANDBOX=true
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
    network_mode: none
    security_opt:
      - no-new-privileges:true
    cap_drop:
      - ALL
    read_only: true
    tmpfs:
      - /tmp:noexec,nosuid,size=100m
```

### Ephemeral Environment Script

```javascript
// .opencode/plugins/ephemeral.js
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

module.exports = {
  name: 'ephemeral',
  commands: {
    'sandbox:create': async ({ args, logger }) => {
      const projectName = path.basename(process.cwd());
      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const worktreeName = `ephemeral-${projectName}-${timestamp}`;
      const worktreePath = path.join(os.homedir(), '.opencode-worktrees', worktreeName);
      
      logger.info(`Creating ephemeral worktree: ${worktreePath}`);
      
      // Create worktree
      fs.mkdirSync(path.dirname(worktreePath), { recursive: true });
      execSync(`git worktree add -b "ephemeral/${worktreeName}" "${worktreePath}"`);
      
      // Copy OpenCode config
      fs.cpSync('.opencode', path.join(worktreePath, '.opencode'), { recursive: true });
      
      // Create activation script
      const activateScript = path.join(worktreePath, 'activate-opencode.sh');
      fs.writeFileSync(activateScript, `#!/bin/bash
export OPENCODE_SANDBOX=true
cd "${worktreePath}"
echo "Ephemeral environment activated"
echo "Run: opencode"
`);
      fs.chmodSync(activateScript, 0o755);
      
      logger.info('Ephemeral environment ready');
      logger.info(`Start: cd ${worktreePath} && opencode`);
      logger.info(`Cleanup: git worktree remove ${worktreePath}`);
      
      return worktreePath;
    }
  }
};
```

---

## Deterministic Checks

### Deterministic Check Library

```javascript
// .opencode/plugins/lib/deterministic.js
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

class DeterministicChecks {
  constructor(baseDir = '.opencode/.deterministic') {
    this.baseDir = path.join(process.cwd(), baseDir);
    fs.mkdirSync(this.baseDir, { recursive: true });
  }
  
  // Checksum-based: Has this content been processed?
  checksumCheck(content, namespace = 'default') {
    const hash = crypto.createHash('sha256').update(content).digest('hex');
    const marker = path.join(this.baseDir, namespace, `${hash}.checked`);
    
    if (fs.existsSync(marker)) {
      return { shouldRun: false, reason: 'Content already processed' };
    }
    
    return {
      shouldRun: true,
      marker,
      markComplete: () => {
        fs.mkdirSync(path.dirname(marker), { recursive: true });
        fs.writeFileSync(marker, new Date().toISOString());
      }
    };
  }
  
  // Time-based: Has enough time passed?
  timeCheck(intervalMs, namespace = 'default') {
    const marker = path.join(this.baseDir, 'timestamps', `${namespace}.last`);
    const now = Date.now();
    
    if (fs.existsSync(marker)) {
      const last = parseInt(fs.readFileSync(marker, 'utf8'));
      const elapsed = now - last;
      if (elapsed < intervalMs) {
        return {
          shouldRun: false,
          reason: `Last run ${Math.floor(elapsed / 1000)}s ago`,
          remaining: intervalMs - elapsed
        };
      }
    }
    
    return {
      shouldRun: true,
      marker,
      markComplete: () => {
        fs.mkdirSync(path.dirname(marker), { recursive: true });
        fs.writeFileSync(marker, now.toString());
      }
    };
  }
  
  // Git commit-based: Has this commit been processed?
  commitCheck(commit = null, namespace = 'default') {
    const targetCommit = commit || execSync('git rev-parse HEAD').toString().trim();
    const marker = path.join(this.baseDir, 'commits', namespace, `${targetCommit}.done`);
    
    if (fs.existsSync(marker)) {
      return { shouldRun: false, commit: targetCommit };
    }
    
    return {
      shouldRun: true,
      commit: targetCommit,
      marker,
      markComplete: () => {
        fs.mkdirSync(path.dirname(marker), { recursive: true });
        fs.writeFileSync(marker, new Date().toISOString());
      }
    };
  }
  
  // Daily: Has this been run today?
  dailyCheck(namespace = 'default') {
    const today = new Date().toISOString().split('T')[0];
    const marker = path.join(this.baseDir, 'daily', namespace, today);
    
    if (fs.existsSync(marker)) {
      return { shouldRun: false, date: today };
    }
    
    return {
      shouldRun: true,
      date: today,
      marker,
      markComplete: () => {
        fs.mkdirSync(path.dirname(marker), { recursive: true });
        fs.writeFileSync(marker, 'done');
      }
    };
  }
}

module.exports = { DeterministicChecks };
```

### Using Deterministic Checks in Plugins

```javascript
// .opencode/plugins/expensive-check.js
const { DeterministicChecks } = require('./lib/deterministic');

const checks = new DeterministicChecks();

module.exports = {
  name: 'expensive-check',
  hooks: {
    'on:file:write:after': async (event) => {
      const { path, content, logger } = event;
      
      // Checksum check - skip if this exact content was checked
      const check = checks.checksumCheck(content, `file-check:${path}`);
      
      if (!check.shouldRun) {
        logger.debug(`Skipping check for ${path} - already processed`);
        return;
      }
      
      // Run expensive analysis
      logger.info(`Running analysis on ${path}`);
      // ... expensive operation ...
      
      // Mark as complete
      check.markComplete();
    },
    
    'on:session:start': async ({ logger }) => {
      // Time-based check - only run every hour
      const check = checks.timeCheck(3600000, 'session-startup');
      
      if (!check.shouldRun) {
        logger.info(`Startup check skipped: ${check.reason}`);
        return;
      }
      
      // Run startup tasks
      logger.info('Running startup checks');
      // ...
      
      check.markComplete();
    }
  }
};
```

---

## Multi-Provider Setup

### Provider Configuration

```json
{
  "providers": {
    "anthropic": {
      "apiKey": "${ANTHROPIC_API_KEY}",
      "defaultModel": "claude-3-5-sonnet-20241022",
      "models": {
        "fast": "claude-3-haiku-20240307",
        "balanced": "claude-3-5-sonnet-20241022",
        "powerful": "claude-3-opus-20240229"
      }
    },
    "openai": {
      "apiKey": "${OPENAI_API_KEY}",
      "defaultModel": "gpt-4",
      "models": {
        "fast": "gpt-3.5-turbo",
        "balanced": "gpt-4",
        "powerful": "gpt-4-turbo"
      }
    },
    "gemini": {
      "apiKey": "${GEMINI_API_KEY}",
      "defaultModel": "gemini-pro"
    }
  },
  
  "routing": {
    "defaultProvider": "anthropic",
    "rules": [
      {
        "pattern": "test.*generation",
        "provider": "openai",
        "model": "gpt-4"
      },
      {
        "pattern": "security.*review",
        "provider": "anthropic",
        "model": "claude-3-opus-20240229"
      },
      {
        "pattern": "quick.*check",
        "provider": "anthropic",
        "model": "claude-3-haiku-20240307"
      }
    ]
  }
}
```

### Provider Fallback Plugin

```javascript
// .opencode/plugins/provider-fallback.js
module.exports = {
  name: 'provider-fallback',
  hooks: {
    'on:provider:error': async (event) => {
      const { error, provider, config, logger } = event;
      
      logger.warn(`Provider ${provider} failed: ${error.message}`);
      
      // Try fallback providers
      const fallbacks = ['openai', 'gemini', 'anthropic']
        .filter(p => p !== provider && config.providers[p]);
      
      for (const fallback of fallbacks) {
        try {
          logger.info(`Trying fallback: ${fallback}`);
          return { provider: fallback };
        } catch (e) {
          logger.error(`Fallback ${fallback} also failed`);
        }
      }
      
      throw new Error('All providers failed');
    }
  }
};
```

---

## Complete Configuration Example

```json
{
  "name": "your-project",
  "description": "Production-ready OpenCode setup",
  
  "providers": {
    "anthropic": {
      "apiKey": "${ANTHROPIC_API_KEY}",
      "defaultModel": "claude-3-5-sonnet-20241022"
    },
    "openai": {
      "apiKey": "${OPENAI_API_KEY}",
      "defaultModel": "gpt-4"
    }
  },
  
  "agents": {
    "code-reviewer": {
      "description": "Comprehensive code reviewer",
      "system": "You are an experienced code reviewer...",
      "tools": ["Read", "Grep"],
      "provider": "anthropic"
    },
    "unstuck-monitor": {
      "description": "Detects stuck agents",
      "system": "You monitor agent progress...",
      "tools": ["Read", "Bash"],
      "hooks": ["on:interval:300"]
    }
  },
  
  "plugins": [
    ".opencode/plugins/credential-guard.js",
    ".opencode/plugins/safety-check.js",
    ".opencode/plugins/unstuck-detector.js",
    ".opencode/plugins/health-check.js",
    ".opencode/plugins/session-start.js"
  ],
  
  "permissions": {
    "Bash": {
      "allow": ["npm test", "npm run build", "git status", "git diff"],
      "deny": ["rm -rf /*", "sudo*", "mkfs.*"]
    },
    "File": {
      "allow": ["src/**/*", "tests/**/*"],
      "deny": [".env*", "*.key", ".opencode/opencode.local.json"]
    }
  },
  
  "skills": {
    "directories": [".opencode/skills", "~/.opencode/skills"]
  },
  
  "sandbox": {
    "enabled": true,
    "docker": {
      "image": "node:20-alpine",
      "readOnly": true,
      "network": false
    }
  }
}
```

```json
{
  "providers": {
    "anthropic": {
      "apiKey": "sk-ant-api-..."
    },
    "openai": {
      "apiKey": "sk-..."
    }
  },
  "env": {
    "DATABASE_URL": "postgresql://...",
    "REDIS_URL": "redis://..."
  },
  "proxy": {
    "url": "http://proxy.company.com:8080"
  }
}
```

```markdown
# Project Guidelines

## Tech Stack
- Backend: Node.js + Express + TypeScript
- Frontend: React + Vite
- Database: PostgreSQL + Prisma

## Available Agents
- @code-reviewer - Code review
- @test-writer - Test generation
- @unstuck-monitor - Progress monitoring

## Available Skills
- /refactoring - Safe code refactoring
- /test-generation - Generate tests
- /deployment - Production deployment

## Security
- Never commit credentials
- Use .opencode/opencode.local.json
- Run in sandbox for destructive operations

## Git Workflow
- Create feature branches
- Open PRs for review
- Use ephemeral environments for experiments
```

---

*Last Updated: March 1, 2026*
