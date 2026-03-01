# Hacker News Opinions on AI Coding Tools

*Aggregated sentiment and discussions from news.ycombinator.com (December 2025 - March 2026)*

---

## Table of Contents

1. [Claude Code vs Codex: The Primary Divide](#claude-code-vs-codex-the-primary-divide)
2. [Cost and Pricing Concerns](#cost-and-pricing-concerns)
3. [Vibe Coding Phenomenon](#vibe-coding-phenomenon)
4. [Tool-Specific Sentiment](#tool-specific-sentiment)
5. [Security and Trust Issues](#security-and-trust-issues)
6. [Skill Atrophy Debate](#skill-atrophy-debate)
7. [Enterprise vs Individual Use](#enterprise-vs-individual-use)
8. [Market and Business Model Concerns](#market-and-business-model-concerns)

---

## Claude Code vs Codex: The Primary Divide

### Preference Patterns

Hacker News discussions reveal a split in preferences between Claude Code (Sonnet 4.5) and Codex (GPT-5 models):

**Pro-Claude Code sentiment:**
- "Claude Code is the current standard all others are measured against"
- Better for "non-coding CLI ops, git ops, writing code with it as a pair programmer"
- "Big new chunks of functionality that are highly conceptual, architectural discussion"
- Faster iteration and feedback
- Superior user experience compared to Codex CLI

**Pro-Codex sentiment:**
- "Codex gives me better results 90% of the time, pretty much across all tasks"
- "Codex gets complex things right more consistently"
- "Doesn't rush into half-baked solutions/dumb approaches as eagerly"
- "Codex PR reviewer to be the best of any tool out there"

### Usage Pattern Differences

From user reports:

| Task Type | Preferred Tool | Reasoning |
|-----------|---------------|-----------|
| Well-articulated plan execution | Codex | Better at following specifications |
| Finding bugs | Codex | More thorough analysis |
| Complex logic tweaks | Codex | Better reasoning |
| Pair programming | Claude Code | Faster feedback |
| Git operations | Claude Code | Better CLI integration |
| OOD tasks | Claude Code | Better conceptual thinking |
| Parallel agent work | Codex | Built-in multi-agent support |

### Reported Usage Ratios

- "I probably use CC 80% of the time with Codex the other 20%"
- "My company pays for CC and I don't even look at the cost"
- "Most of my coworkers use CC over Codex"

---

## Cost and Pricing Concerns

### Subscription Model Anxiety

A recurring theme is concern about pricing sustainability:

> "I hope everyone realizes that the current LLMs are subsidized, like your Seamless and Uber was in the early days."

> "Their pricing models are simply not sustainable."

### Enterprise vs Individual Cost Sensitivity

**Enterprise users:**
- Generally less price-sensitive
- "My company pays for CC and I don't even look at the cost"
- Willing to pay for reliability

**Individual developers:**
- High sensitivity to per-request costs
- "A small change to create a script file (20 LoC) was 10cts, a quick edit to a README was 7ct"
- "I'd easy burn through $10-20 upwards a day"

### Subscription vs Pay-as-you-go Preferences

Debate over business models:

> "I think that tools like this have to operate on a subscription model like Cursor does in order to make any kind of sense for most users. The pay as you go model for agentic code tools makes you responsible for paying for: Whatever context the agent decides to pull in. However many iterations the model decides to run."

> "With Cursor's model of slow and fast queries, they are taking responsibility for ensuring that the agents are as cost efficient as possible."

---

## Vibe Coding Phenomenon

### Definition and Criticism

The term "vibe coding" (coined by Andrej Karpathy) is widely discussed:

> "The defining feature of vibe coding is that the human prompter doesn't know or care what the actual code looks like."

### Skepticism

Many HN users express skepticism:

> "Vibe coding would be catastrophic here. Not because the AI can't write the code - it usually can - but because the failure mode is invisible."

> "A hallucinated edge case in a tax calculation doesn't throw an error. It just produces a slightly wrong number."

> "It turns every new feature into 'implement this in someone else's code base'."

### Defense and Nuance

Others see value in the approach:

> "I know how to get Claude multi-agent mode to write 2,500 lines of deeply gnarly code in 40 minutes, and I know how to get that code _solid_. But doing this absolutely pulls on decades on engineering skill."

> "I read all the core code. I design key architectural constraints. I invest heavily in getting Claude to build extensive automated verification."

### The "AI Korg M1" Prediction

One user offered an analogy:

> "A good analogy might be synthesized music... Once the UI improved (like the release of the Korg M1 sampler), then real artists could enter the fray, and that's when the hockey stick bent. Not exactly sure what AI's Korg M1 will be, but I don't think we're there, yet."

---

## Tool-Specific Sentiment

### OpenCode: Security Crisis

OpenCode faced significant criticism due to a major security vulnerability:

**The vulnerability:**
- Unauthenticated remote code execution via HTTP server
- "Previous versions of OpenCode started a server which allowed any website visited in a web browser to execute arbitrary commands"

**Community reaction:**
- "This is pretty egregious"
- "The disclosure timeline is concerning. Reported 2025-11-17, and multiple 'no responses' after repeated attempts"
- "This short attention would make every adversary look for even more bugs"

**Maintainer response:**
- Acknowledged poor handling of security reports
- "We've done a poor job handling these security reports, usage has grown rapidly and we're overwhelmed with issues"
- Committed to bug bounty program and audits

**Long-term reputational damage:**
- "This is such an egregious lack of respect for users, you can't trust this organisation again"
- "They keep adding features without maintaining the core"

### Aider: The Cost-Conscious Choice

Aider maintains a following among price-sensitive users:

**Comparison with Claude Code:**
- "Aider did this in 1 LLM prompt, or about 15 seconds, with a total cost of $0.07, about 10% of the Claude Code cost"
- "Aider completely missed the files it needed to modify" (requires more manual guidance)

**User profile:**
- Users who prefer explicit file selection
- Cost-conscious developers
- Those with simpler, well-defined tasks

### Gemini CLI: Praised for Free Tier

> "The free tier is the most accessible entry point of any tool on this list: 60 requests per minute and 1,000 requests per day with just a Google account login."

**Limitations noted:**
- "For highly specialized internal codebases, it sometimes reaches for the web when local repository context would be more appropriate"
- No subagent/multi-agent capabilities

### Kimi Code: Unique Fixed Pricing

Noted as "the only major tool offering fixed-price subscriptions":

| Tier | Price | Perception |
|------|-------|------------|
| Basic | ¥49/month (~$7) | Attractive for predictable budgeting |
| Pro | ¥99/month (~$14) | Moderate usage |
| Max | ¥199/month (~$28) | Heavy usage |

---

## Security and Trust Issues

### General Security Concerns

> "Running a non deterministic model in your terminal, allowing it to run whatever commands it wants always seemed like such a fucking stupid thing to do"

> "Many people seem to be running OpenCode and similar tools on their laptop with basically no privilege separation, sandboxing, fine-grained permissions settings"

### Recommended Practices

Community recommendations:
- "Please run at least a dev-container or a VM for the tools"
- "You can use RDP/VNC/Spice or even just the terminal with tmux to work within the confines of the container"
- "If you are super lazy, you can also pay for a VPS $5/month"

### Supply Chain Concerns

> "The first thing I did with claude code is put it in a sandbox. Docker and podman exist, please use them - it isolates you not only from problems like this but supply chain attacks as well."

---

## Skill Atrophy Debate

### Concerns About Dependency

A major recurring theme:

> "Productivity gains decrease exponentially after a few weeks as your engineering skills become rusty very fast"

> "If you don't code yourself - you will lose the ability to properly do it very fast, and you won't realize it until too late"

> "It turns every new feature into 'implement this in someone else's code base'. I imagine you'd very quickly have complete dependency on the AI."

### Counter-Arguments

> "If the LLM writes code that you couldn't have written yourself, you aren't qualified to approve it."

> "I know how to get that code _solid_. But doing this absolutely pulls on decades on engineering skill."

### The "Industrialization" Argument

> "With industrialisation blacksmiths were replaced by assembly lines... I expect that when the dust settles... that most software will be an industrial product. The humans involved in its creation will be engineers and not craftsmen."

---

## Enterprise vs Individual Use

### Enterprise Patterns

> "My company pays for CC and I don't even look at the cost. Most of my coworkers use CC over Codex."

> "Block deployed it to all 12,000 employees by October 2025, with engineers reporting 8–10 hours saved per week."

### Individual/Solo Developer Patterns

> "Codex gets a lot of play on twitter also because a lot of the most prolific voices there are solo devs who are 'building in public'. A greenfield, solo project is the ideal (only?) use case for running 5 agents in parallel."

> "But it's not practical for building in enterprise contexts IMO."

---

## Market and Business Model Concerns

### The Subsidy Question

> "I hope everyone realizes that the current LLMs are subsidized, like your Seamless and Uber was in the early days."

> "The goal is to build huge amounts of hype and demand, get their hooks into everyone, and once they've killed off any competition and built up the walls then they crank up the price."

### Anti-competitive Behavior Concerns

Regarding Anthropic blocking OpenCode:

> "The preferential pricing they're giving to Claude Code (and only Claude Code) is anticompetitive behavior that may be illegal."

> "Predatory pricing is selling something below cost to acquire/maintain market dominance."

### Vendor Lock-in Fears

> "That's a feature, not a bug. At least from OAI/Anthropic's point of view."

> "It really seems like the main focus of the project should be in how to organize the work of the project, rather than on the specs/requirements/development of the codebase itself."

---

## Hallucination and Reliability Issues

### Persistent Problems

> "Also (most) engineers don't hallucinate answers. Claude still does regularly."

> "When it does it in chat mode via a flat rate Pro plan I can laugh it off... if its costing me very real money for the LLM to over-eagerly over-engineer an incorrect implementation... its a lot less funny."

### Training Cutoff Issues

> "I asked one about a potential bug in iOS 26 yesterday and it told me that iOS 26 does not exist and that I must have meant iOS 16. iOS 26 was announced last June and has been live since September."

> "Claude told me that a problem I was having was likely caused by my fedora version 'since fedora 42 is long deprecated'."

---

## Community Recommendations

### Best Practices (from experienced users)

1. **Always review AI-generated code**: "I read all the core code"
2. **Design architectural constraints**: "I design key architectural constraints"
3. **Invest in verification**: "I invest heavily in getting Claude to build extensive automated verification"
4. **Use sandboxes**: "Docker and podman exist, please use them"
5. **Stay in the loop**: "I generally approve every edit and often interrupt it"

### Tools and Workflows

- Claude Code with sub-agents for parallelization
- Aider for cost-sensitive tasks
- Codex for complex, well-defined tasks
- Local models (GPT-OSS-120B) via Claude Code with llama.cpp

---

## Key Quotes Summary

### On Productivity
- "I probably use CC 80% of the time with Codex the other 20%"
- "Block deployed it to all 12,000 employees... 8–10 hours saved per week"

### On Costs
- "Claude Code spent about 60 seconds and $0.73... Aider... $0.07, about 10% of the Claude Code cost"
- "The current LLMs are subsidized, like your Seamless and Uber was in the early days"

### On Skill
- "Productivity gains decrease exponentially after a few weeks as your engineering skills become rusty very fast"
- "If the LLM writes code that you couldn't have written yourself, you aren't qualified to approve it"

### On Vibe Coding
- "The defining feature of vibe coding is that the human prompter doesn't know or care what the actual code looks like"
- "Vibe coding would be catastrophic here... the failure mode is invisible"

---

## Sources

This document aggregates discussions from the following Hacker News threads:

- https://news.ycombinator.com/item?id=45610266 (Claude Code vs Codex sentiment analysis)
- https://news.ycombinator.com/item?id=43315371 (Claude Code cost comparison with Aider)
- https://news.ycombinator.com/item?id=46542036 (AI coding assistants getting worse)
- https://news.ycombinator.com/item?id=46581095 (OpenCode security vulnerability)
- https://news.ycombinator.com/item?id=46625918 (Anthropic blocking OpenCode)
- https://news.ycombinator.com/item?id=47006615 (Breaking the spell of vibe coding)

*Collected: March 2026*
