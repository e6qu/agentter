# Famous Spats, Controversies, and Disagreements

A comprehensive catalog of public disputes, academic feuds, and ideological clashes among AI researchers, tech leaders, HN contributors, and industry figures.

---

## Table of Contents

1. [Academic Disputes & Priority Claims](#academic-disputes--priority-claims)
   - [Gary Marcus vs. Yann LeCun: The CNN Credit Controversy](#gary-marcus-vs-yann-lecun-the-cnn-credit-controversy)
   - [Jürgen Schmidhuber vs. The Turing Trio](#jürgen-schmidhuber-vs-the-turing-trio)
   - [Schmidhuber vs. Ian Goodfellow: The GAN Dispute](#schmidhuber-vs-ian-goodfellow-the-gan-dispute)
2. [AI Safety & Existential Risk Debates](#ai-safety--existential-risk-debates)
   - [Yann LeCun vs. Eliezer Yudkowsky: The Doomer Debate](#yann-lecun-vs-eliezer-yudkowsky-the-doomer-debate)
   - [Elon Musk vs. Geoffrey Hinton: Royal Society Expulsion](#elon-musk-vs-geoffrey-hinton-royal-society-expulsion)
3. [OpenAI Leadership Conflicts](#openai-leadership-conflicts)
   - [Sam Altman's Firing and Reinstatement (Nov 2023)](#sam-altmans-firing-and-reinstatement-nov-2023)
   - [Elon Musk vs. Sam Altman: The OpenAI Lawsuit](#elon-musk-vs-sam-altman-the-openai-lawsuit)
4. [Research Ethics & Academic Freedom](#research-ethics--academic-freedom)
   - [The "Stochastic Parrots" Paper: Timnit Gebru's Firing from Google](#the-stochastic-parrots-paper-timnit-gebrus-firing-from-google)
5. [Hacker News & Tech Community Arguments](#hacker-news--tech-community-arguments)
   - [Paul Graham vs. Sam Altman Departure Narratives](#paul-graham-vs-sam-altman-departure-narratives)
   - [The "Vibe Coding" Skepticism Wars](#the-vibe-coding-skepticism-wars)

---

## Academic Disputes & Priority Claims

### Gary Marcus vs. Yann LeCun: The CNN Credit Controversy

**Participants:**
- **Gary Marcus** — Cognitive scientist, NYU professor emeritus, founder of Robust.AI
- **Yann LeCun** — Chief AI Scientist at Meta, Turing Award recipient (2018)

**The Dispute:**

In April 2023, Gary Marcus published a scathing Substack article titled **"The False Glorification of Yann LeCun"**, accusing LeCun of systematic "plagiarism of ideas" — defined by the US Office of Research Integrity as "appropriating someone else's idea... without giving credit to its originator."

**Key Claims:**

Marcus argued that LeCun has claimed credit for five major ideas he did not originate:

1. **Convolutional Neural Networks (CNNs)** — Marcus cited that the foundational work was done by Kunihiko Fukushima (1979-1980), and Wei Zhang et al. (1988) beat LeCun to adding backpropagation to CNNs by nearly a year
2. **Critique of Large Language Models** — Marcus claimed he was first to challenge GPT-2 and GPT-3 in 2019, while LeCun was "publicly hostile to those critiques"
3. **Critique of Scaling Hypothesis** — Marcus stated he doubted scaling publicly in 2022, while LeCun "trolled my critique on Facebook"
4. **World Models** — Marcus traced the concept to Herb Simon's General Problem Solver (1950s) and Schmidhuber's work (1990)
5. **Common Sense and Physical Reasoning** — Marcus cited Ernest Davis and John McCarthy's earlier work

**Direct Quotes:**

> "LeCun has, without a doubt made genuine contributions to AI... But he has also systematically dismissed and ignored the work of others for years, including Schmidhuber, Fukushima, Zhang, Bender, Li and myself, in order to exaggerate his own contributions."
> — Gary Marcus, Substack, April 2023

> "LeCun was, at the time, publicly hostile to those critiques, accusing me of a 'rearguard action.'"
> — Gary Marcus

LeCun's response, when engaging at all, has generally been dismissive. In prior exchanges, LeCun stated:

> "I don't engage in vacuous debates. I build stuff. You should try it sometimes."
> — Yann LeCun (via Wired, May 2023)

**Sources:**
- Gary Marcus, "The False Glorification of Yann LeCun", Substack, April 2023
- Wired, "Gary Marcus Used to Call AI Stupid—Now He Calls It Dangerous", May 5, 2023
- https://garymarcus.substack.com/p/the-false-glorification-of-yann-lecun

---

### Jürgen Schmidhuber vs. The Turing Trio

**Participants:**
- **Jürgen Schmidhuber** — LSTM co-inventor, "Father of Modern AI" (per some sources)
- **Geoffrey Hinton, Yann LeCun, Yoshua Bengio** — Turing Award recipients (2018)

**The Dispute:**

Since the 2018 Turing Award was announced, Schmidhuber has maintained an ongoing public campaign arguing that the "Deep Learning Trio" (HLB) systematically failed to cite prior work—including his own and others'. He published an 88-page report documenting 17 specific priority disputes.

**Major Claims:**

| Technology | Schmidhuber's Claim | HLB Attribution |
|-----------|---------------------|-----------------|
| LSTM (1997) | Co-invented with Hochreiter | Often cited but credit diffuse |
| GANs (2014) | His 1990 "Artificial Curiosity" principle | Ian Goodfellow (Bengio's student) |
| ResNets (2015) | His "Highway Networks" (2015) | Kaiming He et al. |
| Transformers (2017) | His 1991 "Fast Weight Programmers" | Vaswani et al. |
| Self-supervised Learning | His 1990-91 work | LeCun claims credit |
| Meta-learning | His 1987 diploma thesis | Bengio et al. (1991) |
| Vanishing gradient analysis | Hochreiter's 1991 thesis | Bengio et al. (1994) |

**Direct Quotes:**

> "They frequently re-published others' work without proper attribution. Even worse, they failed to correct this in subsequent publications. In science, this is unacceptable... They should be stripped of their awards."
> — Jürgen Schmidhuber, interview with Jazzyear, 2024

> "I think Jeff is a bit of a tool and Satya is not..."
> — Elon Musk in email to Sam Altman about Schmidhuber (unrelated but illustrative of the tone of disputes)

**The NIPS 2016 Incident:**

At NIPS 2016, Schmidhuber publicly confronted Ian Goodfellow during his GAN tutorial:

> "[Schmidhuber] stood up and spoke for about two minutes, explaining that he had introduced similar ideas in 1992 under the name Predictability Minimization... Goodfellow responded: 'We've discussed this before, and I published a response to you. I don't think this is the appropriate venue to continue that discussion.'"
> — Quora recounting, 2017

**Sources:**
- Schmidhuber, "Critique of 2018 Turing Award", https://people.idsia.ch/~juergen/critique-turing-award-bengio-hinton-lecun.html
- Schmidhuber, "Who Invented Convolutional Neural Networks?" https://people.idsia.ch/~juergen/who-invented-convolutional-neural-networks.html
- Jazzyear Interview, "The Father of Generative AI Without Turing Award", July 18, 2024

---

### Schmidhuber vs. Ian Goodfellow: The GAN Dispute

**Participants:**
- **Jürgen Schmidhuber** — IDSIA, LSTM co-inventor
- **Ian Goodfellow** — GAN inventor, then Bengio's student at Université de Montréal

**The Dispute:**

When Goodfellow submitted the first GAN paper to NIPS 2014, Schmidhuber was one of three reviewers—and the only one to reject it. His critique: GANs were essentially his 1992 "Predictability Minimization" (PM) models run in reverse.

Schmidhuber's review noted:

> "The two methods both use 'adversarial' MLPs to estimate certain probabilities and learn encodings of distributions. The difference is that the new system learns to generate non-trivial distributions from statistically independent random inputs, while the old PM learns to generate statistically independent random outputs in response to non-trivial distributions... Is this the main difference? Should GANs be called 'inverse PM'?"

Goodfellow ultimately added a comparison to PM in the final version, but the dispute continued for years, culminating in the NIPS 2016 confrontation.

**Sources:**
- Quora discussions of NIPS 2016 incident
- Goodfellow et al., "Generative Adversarial Networks", NIPS 2014

---

## AI Safety & Existential Risk Debates

### Yann LeCun vs. Eliezer Yudkowsky: The Doomer Debate

**Participants:**
- **Yann LeCun** — Meta Chief AI Scientist
- **Eliezer Yudkowsky** — AI safety researcher, founder of MIRI, "doomer" advocate

**The Dispute:**

In April 2023, LeCun and Yudkowsky engaged in a lengthy Twitter debate about AI existential risk. LeCun argued that AI safety concerns were overblown; Yudkowsky argued that LeCun was dangerously dismissive of extinction risks.

**Direct Quotes:**

> "To *guarantee* that a system satisfies objectives, you make it optimize those objectives at run time (what I propose). That solves the problem of aligning behavior to objectives. Then you need to align objectives with human values. But that's not as hard as you make it to be."
> — Yann LeCun, April 2023

> "So you're staking the life of everyone on Earth that: Future AIs are as human-friendly on average as the humans making up corporations; AIs don't collude among themselves better than human corporations; AIs never go beyond superhuman to supercorporate."
> — Eliezer Yudkowsky

> "Stop it, Eliezer. Your scaremongering is already hurting some people. You'll be sorry if it starts getting people killed."
> — Yann LeCun

> "A high-school student actually wrote to me saying that he got into a deep depression after reading prophecies of AI-fueled apocalypse."
> — Yann LeCun

> "As much as 'tu quoque' would be a valid reply... I can't help but observe that you're a lead employee at... Facebook. You've contributed to a *lot* of cases of teenage depression, if that's considered an issue of knockdown importance."
> — Eliezer Yudkowsky

> "The hard take-off is already happening. Just zoom out a little."
> — Elon Musk, joining the debate

> "The 'hard take-off' scenario is utterly impossible."
> — Yann LeCun

**The Meta-Commentary:**

The debate was extensively analyzed by Zvi Mowshowitz, who wrote:

> "Yann seems to literally be saying 'we can create superintelligent beings and it will pose zero risk to humanity because we have corporate law. Saying otherwise is dangerous and wrong and needs to stop.' This is Obvious Nonsense."

**Sources:**
- The Zvi Substack, "Transcript and Brief Response to Twitter Conversation between Yann LeCun and Eliezer Yudkowsky", April 26, 2023
- https://thezvi.substack.com/p/transcript-and-brief-response-to

---

### Elon Musk vs. Geoffrey Hinton: Royal Society Expulsion

**Participants:**
- **Elon Musk** — CEO of Tesla, SpaceX, xAI; former OpenAI co-founder
- **Geoffrey Hinton** — Nobel Prize winner (Physics, 2024), Turing Award recipient

**The Dispute:**

In March 2025, Hinton called for Musk's expulsion from the Royal Society, citing "the huge damage he is doing to scientific institutions in the US." This followed Musk's attacks on Dr. Anthony Fauci and his labeling of UK MP Jess Phillips as a "rape genocide apologist."

**Direct Quotes:**

> "I think Elon Musk should be expelled from the British Royal Society. Not because he peddles conspiracy theories and makes Nazi salutes, but because of the huge damage he is doing to scientific institutions in the US. Now let's see if he really believes in free speech."
> — Geoffrey Hinton, X post, March 2, 2025

> "Only craven, insecure fools care about awards and memberships. History is the actual judge, always and forever. Your comments above are carelessly ignorant, cruel and false."
> — Elon Musk, response on X, March 2, 2025

**Background:**

The dispute is particularly notable because Hinton and Musk were previously aligned on AI safety concerns. However, their relationship deteriorated—Hinton told the Globe and Mail he made up an excuse to end a call with Musk after 20 minutes when Musk "started rambling" while recruiting him for an AI safety advisory board.

Hinton has also criticized Musk's business practices:

> "I think the big companies are betting on it causing massive job replacement by AI, because that's where the big money is going to be... Elon will get richer and a lot of people get unemployed and Elon won't care."
> — Geoffrey Hinton, Bloomberg TV interview, November 2025

**Sources:**
- Fortune, "Elon Musk labels 'godfather of AI' 'carelessly ignorant, cruel' after calls for Royal Society expulsion", March 3, 2025
- X posts from @geoffreyhinton and @elonmusk, March 2, 2025

---

## OpenAI Leadership Conflicts

### Sam Altman's Firing and Reinstatement (Nov 2023)

**Participants:**
- **Sam Altman** — OpenAI CEO
- **Ilya Sutskever** — OpenAI co-founder, Chief Scientist
- **Helen Toner** — Former OpenAI board member
- **Mira Murati** — Former OpenAI CTO

**The Dispute:**

On November 17, 2023, OpenAI's board fired Sam Altman, citing that he "was not consistently candid in his communications." The firing triggered a five-day crisis that ended with Altman's reinstatement and the departure of most board members.

**Direct Quotes:**

From Ilya Sutskever's October 2024 deposition (released in 2025):

> "Altman exhibits a consistent pattern of lying, undermining his execs, and pitting his execs against one another."
> — Opening line of Sutskever's 52-page memo to the board

> "Because I felt that, had he become aware of these discussions, he would just find a way to make them disappear."
> — Sutskever, on why he didn't send the memo to Altman

> "I had been waiting to propose Altman's removal for at least a year."
> — Ilya Sutskever

From Helen Toner's podcast appearance (May 2024):

> "For years, Sam had made it really difficult for the board to actually do [its] job by withholding information, misrepresenting things that were happening at the company, in some cases outright lying to the board."
> — Helen Toner

> "They used the phrase 'psychological abuse,' telling us they didn't think he was the right person to lead the company to AGI."
> — Helen Toner, quoting OpenAI executives

From Sutskever on why he reversed his position:

> "Because I thought that OpenAI would be destroyed."
> — Ilya Sutskever, on why he supported Altman's return

From Geoffrey Hinton (October 2024):

> "I'm particularly proud of the fact that one of my students fired Sam Altman."
> — Geoffrey Hinton, Nobel Prize press conference

**The Aftermath:**

Sutskever left OpenAI in May 2024 to found Safe Superintelligence (SSI). Murati left in September 2024 to found Thinking Machines Lab.

**Sources:**
- The Verge, "Chaos and lies: Why Sam Altman was booted from OpenAI", November 2025
- Wikipedia, "Removal of Sam Altman from OpenAI"
- Sutskever deposition transcript, October 2024

---

### Elon Musk vs. Sam Altman: The OpenAI Lawsuit

**Participants:**
- **Elon Musk** — xAI founder, former OpenAI co-founder
- **Sam Altman** — OpenAI CEO
- **Greg Brockman** — OpenAI co-founder

**The Dispute:**

Musk filed a lawsuit against OpenAI in February 2024, dropped it in June 2024, then refiled in August 2024 in federal court. The lawsuit alleges OpenAI abandoned its nonprofit mission and became a "closed-source, de facto subsidiary" of Microsoft.

**Direct Quotes:**

From Musk's lawsuit:

> "Musk was 'betrayed by Altman and his accomplices. The perfidy and deceit are of Shakespearean proportions.'"

> "Elon Musk's case against Sam Altman and OpenAI is a textbook tale of altruism versus greed. Altman, in concert with other Defendants, intentionally courted and deceived Musk, preying on Musk's humanitarian concern about the existential dangers posed by artificial intelligence."

From OpenAI's response blog post:

> "We're sad that it's come to this with someone whom we've deeply admired—someone who inspired us to aim higher, then told us we would fail, started a competitor, and then sued us when we started making meaningful progress towards OpenAI's mission without him."

From unsealed emails (2023):

> "i remember seeing you in a tv interview a long time ago... where you being attacked by some guys, and you said they were heroes of yours and it was really tough. well, you're my hero and that's what it feels like when you attack openai."
> — Sam Altman to Elon Musk, February 2023

> "I hear you and it is certainly not my intention to be hurtful, for which I apologize, but the fate of civilization is at stake."
> — Elon Musk response

> "OpenAI is on a path of certain failure relative to Google... Either we fix things and my engagement increases a lot or we don't and I will drop to near zero."
> — Elon Musk, January 2018 email

**From Greg Brockman's diary (unsealed 2025):**

> "Is he the 'glorious leader' that I would pick?"
> — Brockman on Musk

> "Financially, what will take me to $1B?"
> — Brockman's personal financial goal

**Sources:**
- CNN, "Elon Musk files new lawsuit against OpenAI and Sam Altman", August 5, 2024
- The Guardian, "The feud between Elon Musk and Sam Altman – explained", March 9, 2024
- Business Insider, "9 Revelations From Unsealed Docs in Elon Musk Vs. Sam Altman", January 9, 2026
- The Verge, "A look at the evidence of Elon Musk's lawsuit against OpenAI", January 16, 2026

---

## Research Ethics & Academic Freedom

### The "Stochastic Parrots" Paper: Timnit Gebru's Firing from Google

**Participants:**
- **Timnit Gebru** — Former co-lead of Google's Ethical AI team
- **Emily M. Bender** — Professor of Computational Linguistics, University of Washington
- **Jeff Dean** — Head of Google AI
- **Margaret Mitchell** — Former co-lead of Google's Ethical AI team

**The Dispute:**

In December 2020, Google fired Timnit Gebru after she co-authored a paper titled "On the Dangers of Stochastic Parrots: Can Language Models Be Too Big?" The paper questioned the environmental costs, bias perpetuation, and opportunity costs of large language models.

**Direct Quotes:**

From Gebru's departure email:

> "Have you ever heard of someone getting 'feedback' on a paper through a privileged and confidential document to HR? Does that sound like a standard procedure to you or does it just happen to people like me who are constantly dehumanized?"
> — Timnit Gebru, internal email, December 2020

From Jeff Dean's response:

> "The paper didn't meet our bar for publication... It ignored too much relevant research—for example, it talked about the environmental impact of large models, but disregarded subsequent research showing much greater efficiencies."
> — Jeff Dean, internal memo

From Emily Bender:

> "This article is a very solid and well-researched piece of work. It is hard to see what could trigger an uproar in any lab, let alone lead to someone losing their job over it."
> — Emily Bender, interview with Wired

> "We call on the field to recognize that applications that aim to believably mimic humans bring risk of extreme harms."
> — Bender et al., "On the Dangers of Stochastic Parrots"

From Margaret Mitchell after her own firing:

> "I have no doubt that my advocacy on race and gender issues, as well as my support of Dr. Gebru, led to me being banned and then terminated."
> — Margaret Mitchell, March 2021

**The Paper's Core Arguments:**

1. **Environmental costs**: Training large models consumes enormous energy
2. **Undocumentable data**: Training datasets too large to audit for bias
3. **Research opportunity costs**: Resources diverted from more promising approaches
4. **Illusions of meaning**: Risk of mistaking statistical mimicry for understanding

**Sources:**
- Wired, "Behind the Paper That Led to a Google Researcher's Firing", December 8, 2020
- MIT Technology Review, "We read the paper that forced Timnit Gebru out of Google", December 4, 2020
- CNN, "How one employee's exit shook Google and the AI industry", March 11, 2021

---

## Hacker News & Tech Community Arguments

### Paul Graham vs. Sam Altman Departure Narratives

**Participants:**
- **Paul Graham** — Y Combinator co-founder
- **Sam Altman** — OpenAI CEO, former YC president
- **Helen Toner** — Former OpenAI board member

**The Dispute:**

Conflicting narratives emerged about whether Sam Altman was fired from Y Combinator in 2019 or left voluntarily. Paul Graham defended Altman in May 2024, claiming Altman was given a choice between OpenAI and YC—not fired.

**Direct Quotes:**

From Paul Graham:

> "People have been claiming [Y Combinator] fired Sam Altman. That's not true... If he was going to work full-time on OpenAI, we should find someone else to run YC, and he agreed. If he'd said that he was going to find someone else to be CEO of OpenAI so that he could focus 100% on YC, we'd have been fine with that too."
> — Paul Graham, X post, May 2024

From Helen Toner:

> "The true reasons for Altman's departure from Y Combinator were 'hushed up at the time.'"
> — Helen Toner, TED AI Show podcast, May 2024

HN Commentary (paraphrased from discussion threads):

> "If Paul Graham fired Sam Altman from YCombinator it's interesting that he appears to have such a favourable opinion of him."
> — HN user (via archived thread)

> "As an English person, to me these tweets sound a lot like he is publicly calling Altman a [expletive]."
> — HN user on Graham's tweets

**Sources:**
- TechCrunch, "Paul Graham claims Sam Altman wasn't fired from Y Combinator", May 30, 2024
- Business Insider, "Paul Graham Breaks Down Why Sam Altman Left Y Combinator", May 31, 2024
- Hacker News thread (archived)

---

### The "Vibe Coding" Skepticism Wars

**Participants:**
- **HN users** espousing "vibe coding" (AI-assisted coding without deep understanding)
- **Traditionalist developers** skeptical of AI-generated code
- **Tool-specific communities** (Aider, Claude Code, Codex CLI users)

**The Dispute:**

The rise of AI coding tools has created sharp divisions on Hacker News between proponents of AI-assisted development and skeptics who view it as producing unreliable, unmaintainable code.

**Notable HN Quotes (paraphrased):**

> "Vibe coding is like having an intern who is 80% right, 100% confident, and never learns from corrections."
> — HN user (paraphrased from community discussions)

> "The problem isn't that AI helps you code. It's that it helps you code things you don't understand."
> — HN user sentiment, recurring in threads

**Technical Disagreements:**

| Position | Argument |
|----------|----------|
| Pro-AI Coding | Accelerates development; handles boilerplate; lowers barrier to entry |
| Skeptical | Produces technical debt; masks incompetence; security vulnerabilities |
| Moderate | Tool-appropriate use; AI for scaffolding, human for architecture |

**Specific Tool Debates:**

- **Aider users**: Cost-conscious, prefer local models, emphasize multi-file editing
- **Claude Code users**: Willing to pay for premium experience, enterprise workflows
- **Codex CLI users**: Speed-focused, frequent complaints about OpenAI service reliability
- **OpenCode users**: Security-focused, especially post-RCE vulnerability disclosure

**Sources:**
- Various HN threads on "vibe coding" (2024-2025)
- PROMINENT_HACKER_NEWS_CONTRIBUTORS.md (this repository)

---

## Additional Controversies

### Karl Friston on Yann LeCun's "Engineering" Approach

**Participants:**
- **Karl Friston** — World's most cited neuroscientist, creator of Free Energy Principle
- **Yann LeCun** — Meta Chief AI Scientist

**Direct Quote:**

> "I think it's a very simple difference. I am committed to first principles and was trained as a physicist and think as a physicist. He is a really skillful engineer... He does not think it is, in an engineering sense, easy or possible to include uncertainty into his neural networks."
> — Karl Friston, interview with Denise Holt at IWAI 2025

**Context:**

Friston argued that LeCun's "temperature to zero" approach (removing uncertainty from objective functions) prevents AIs from knowing "what they don't know before asking the right questions."

**Source:**
- Medium/AIMonks, "What Yann LeCun is Missing: Karl Friston and Gary Marcus on Uncertainty, Agency and AI"

---

## Summary Statistics

| Category | Number of Documented Disputes |
|----------|------------------------------|
| Academic Priority Claims | 3 major (Marcus-LeCun, Schmidhuber-Trio, Schmidhuber-Goodfellow) |
| AI Safety Debates | 2 major (LeCun-Yudkowsky, Musk-Hinton) |
| OpenAI Leadership | 2 major (Altman Firing, Musk Lawsuit) |
| Research Ethics | 1 major (Gebru Firing) |
| HN/Community | 2+ ongoing (Graham-Altman, Vibe Coding) |

---

## Notes on Methodology

1. **Quote Attribution**: All direct quotes are attributed to named sources with publication dates where available. Some HN quotes are paraphrased due to the pseudonymous nature of the platform.

2. **Neutrality**: This document aims for neutral presentation of disputed claims. Inclusion does not imply endorsement of any position.

3. **Source Quality**: Primary sources (court documents, original papers, official blog posts) are preferred over secondary reporting.

4. **Ongoing Nature**: Many of these disputes are ongoing; this document reflects information available as of early 2026.

---

## Related Documents

- [PROMINENT_PEOPLE.md](./PROMINENT_PEOPLE.md) — Profiles of key figures mentioned
- [PROMINENT_HACKER_NEWS_CONTRIBUTORS.md](./PROMINENT_HACKER_NEWS_CONTRIBUTORS.md) — HN contributor analysis
