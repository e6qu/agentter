# Hacker News Technical Deep Dive

The algorithms, infrastructure, and hidden mechanisms that power Hacker News.

---

## Table of Contents

1. [The Ranking Algorithm](#the-ranking-algorithm)
2. [The Penalty System](#the-penalty-system)
3. [Dead, Flagged, and Hidden Posts](#dead-flagged-and-hidden-posts)
4. [Infrastructure & Architecture](#infrastructure--architecture)
5. [The Arc Language](#the-arc-language)
6. [Anti-Abuse Systems](#anti-abuse-systems)
7. [Data & APIs](#data--apis)

---

## The Ranking Algorithm

### The Basic Formula

HN's ranking algorithm was revealed by Paul Graham in 2010 and confirmed through analysis:

```python
def calculate_score(votes, item_hour_age, gravity=1.8):
    return (votes - 1) / pow((item_hour_age + 2), gravity)
```

**In plain English:**
- `(votes - 1)`: Subtract submitter's automatic upvote
- `item_hour_age + 2`: Add 2 hours to prevent division by zero
- `gravity (1.8)`: Higher = faster decay

### The Actual Arc Code

The real production algorithm (as revealed in 2010):

```arc
(= gravity* 1.8 
   timebase* 120 
   front-threshold* 1
   nourl-factor* .4 
   lightweight-factor* .17 
   gag-factor* .1)

(def frontpage-rank (s (o scorefn realscore) (o gravity gravity*))
  (* (/ (let base (- (scorefn s) 1)
          (if (> base 0) (expt base .8) base))
        (expt (/ (+ (item-age s) timebase*) 60) gravity))
     (if (no (in s!type 'story 'poll))  .8
         (blank s!url)                  nourl-factor*
         (mem 'bury s!keys)             .001
                                        (* (contro-factor s)
                                           (if (mem 'gag s!keys)
                                                gag-factor*
                                               (lightweight s)
                                                lightweight-factor*
                                               1)))))
```

### Key Parameters

| Parameter | Value | Purpose |
|-----------|-------|---------|
| `gravity*` | 1.8 | Controls how fast posts decay |
| `timebase*` | 120 (minutes) | Prevents zero-division, smooths early scores |
| `nourl-factor*` | 0.4 | Penalty for text posts (Ask HN) |
| `lightweight-factor*` | 0.17 | Penalty for "lightweight" content |
| `gag-factor*` | 0.1 | Heavy penalty for jokes/memes |

### The "Contro-factor" (Controversy Detector)

Hidden function that detects flamewars:

> "Its purpose is to recognize flamewars."
> — dang

**How it works:**
- Activates when comments > votes AND comments > 40
- Formula: `(votes/comments)^3` (estimated from data)
- Can drop a #1 post to oblivion instantly

**Real example from 2013 analysis:**
- "Why the Chromebook pundits are out of touch with reality"
- Dropped from #5 to #22 the moment it hit 40 comments
- Post had many more comments than votes (flamewar indicator)

### Ranking in Practice

**Efficiency optimization:**
- Posts aren't constantly re-sorted
- Only re-ranked when:
  1. Someone upvotes
  2. A random top-50 post is selected every 30 seconds
- This can cause temporary "wrong" rankings

**Caching:**
- Pages cached for 90 seconds
- Stale data is normal

---

## The Penalty System

### Types of Penalties

| Penalty | Factor | Trigger |
|---------|--------|---------|
| No URL | 0.4 | Text posts (Ask HN) |
| Lightweight | 0.17 | Images, memes, certain domains |
| Gag | 0.1 | Jokes, memes marked as `gag` |
| Controversy | Variable | >40 comments, comments > votes |
| Bury | 0.001 | Moderator/manual bury |
| Domain penalties | 0.25-0.8 | Various sites (see below) |

### Domain-Specific Penalties

**Sites observed with automatic penalties (0.25-0.8):**
- arstechnica.com
- businessinsider.com
- github.com
- imgur.com
- medium.com
- quora.com
- reddit.com
- theguardian.com
- theverge.com
- youtube.com

**Theory:** Popular sites get submitted multiple times simultaneously, getting more upvotes than "merited." Penalties counteract this effect.

### The NSA Penalty (Historical)

**2013 analysis revealed:**
- Any article with "NSA" in title got 0.4 penalty
- Automatically dropped from front page faster
- Later removed (dang confirmed in 2013)

### Impact of Penalties

| Penalty Factor | Vote Effect | Speed of Drop |
|----------------|-------------|---------------|
| 0.8 | Each vote counts as 0.7 | 25% faster |
| 0.4 | Each vote counts as 0.3 | 66% faster |
| 0.1 | Each vote counts as 0.05 | 3.6x faster |

**Real-world impact:**
- 20% of front-page stories are penalized at any time
- 38% of second-page stories are penalized

---

## Dead, Flagged, and Hidden Posts

### The Lifecycle of a Problem Post

```
Normal Post → Flagged → [Dead] → Vouched → Restored
                    ↓
               Banned/Killed
```

### [flagged] vs [dead]

| Tag | Meaning | Visibility |
|-----|---------|------------|
| `[flagged]` | Users flagged as guideline violation | Visible, but marked |
| `[dead]` | Killed by system, flags, or mods | Hidden by default |
| `[flagged][dead]` | Both (flagged to death) | Hidden by default |

### How Posts Die

**1. Automatic (Software):**
- Spam filter triggers
- Banned domain/account
- Vote ring detection
- Bayesian content filtering

**2. User Flags:**
- Available at 31+ karma
- Multiple flags trigger `[dead]`
- dang: "Mods is the least common reason"

**3. Moderator Action:**
- Manual kill
- Usually for severe violations

### The Vouch System

**Requirements:**
- Small karma threshold (exact number unpublished)
- Click timestamp → "vouch" link
- Enough vouches restore post

**Limitations:**
- Can be re-flagged to death
- Can't vouch twice on same post
- Only works on `[dead]`, not `[deleted]`

### showdead Setting

Users can enable `showdead` in profile to see:
- All dead posts
- Full conversation threads
- Shadowbanned user comments

**Why it exists:**
- Transparency
- Community oversight
- Research purposes

---

## Infrastructure & Architecture

### Current Hardware (as of 2025)

**Just two servers:**
- Quad-core Intel Xeon E5-2637 v4
- FreeBSD
- Minimal specs for the traffic

**Why so minimal?**
- Text-only = tiny bandwidth
- Efficient Arc/Lisp code
- No images/media hosting
- Aggressive caching

### Software Stack

| Component | Technology |
|-----------|------------|
| Language | Arc (Lisp dialect) |
| OS | FreeBSD |
| Database | Custom (file-based) |
| Web Server | Built into Arc |
| Caching | Application-level |
| Search | Algolia (external) |

### The Arc Runtime

**Created by:** Paul Graham and Robert Morris
**Purpose:** HN is the primary/only major Arc application
**Status:** Open source but not widely adopted

**Key characteristics:**
- Minimalist Lisp
- Designed for web apps
- REPL-driven development
- Dynamic typing

---

## Anti-Abuse Systems

### Vote Ring Detection

**Problem:** Coordinated voting to game rankings

**Detection methods (inferred):**
- Referrer analysis
- Account age patterns
- Operation frequency
- IP/cluster analysis

**Response:**
- Votes dropped silently
- Accounts penalized
- Posts buried

### Shadowbanning

**What it is:**
- User can post/vote normally
- No one else sees their content
- Often used on spammers (wastes their time)

**Detection:**
- Check with "showdead" enabled
- Log out and view own profile
- Third-party tools

### Rate Limiting

**"You're posting too fast!"**
- Triggered by:
  - Rapid submissions
  - Rapid comments
  - Rapid votes
- Cooldown period increases with violations

### Bayesian Filtering

**Based on:** Paul Graham's "A Plan for Spam" (2002)
- Content-based spam detection
- Trained on historical data
- Runs automatically
- Updated continuously

---

## Data & APIs

### Official API

**Base URL:** `https://hacker-news.firebaseio.com/v0/`

**Endpoints:**
```
/topstories.json     - Top 500 story IDs
/newstories.json     - New 500 story IDs
/beststories.json    - Best 500 story IDs
/item/{id}.json      - Item details
/user/{id}.json      - User details
/maxitem.json        - Latest item ID
/updates.json        - Changed items
```

**Limitations:**
- Read-only
- One item per request (no batching)
- No downvote data
- No flag data
- Rate limited

### Algolia Search API

**URL:** `https://hn.algolia.com/api/v1/`

**Advantages over official API:**
- Full-text search
- Date ranges
- Author filtering
- Real-time indexing
- Complex queries

**Example queries:**
```
search?query=python&tags=story
search_by_date?query=startup&numericFilters=points>100
```

### BigQuery Dataset

**Public dataset:** `bigquery-public-data.hacker_news`

**Tables:**
- `full` - All items (stories, comments, jobs)
- `stories` - Story submissions only
- `comments` - Comments only

**Sample query:**
```sql
SELECT * FROM `bigquery-public-data.hacker_news.full`
WHERE type = 'story' 
  AND score > 100
ORDER BY time DESC
LIMIT 100
```

### hnrss.org

**Third-party RSS feeds:**
- Filtered by score, domain, keyword
- "Best comments" feed
- User-specific feeds
- Real-time updates

---

## Notable Statistics

### Traffic (2024-2025)

- **Monthly visits:** 15M+
- **Daily active users:** ~500K
- **Comments per year:** ~4 million
- **Submissions per year:** ~400K
- **Active members:** ~150K

### Content Distribution

| Type | Percentage |
|------|------------|
| Programming | 25% |
| Startups/Business | 20% |
| AI/ML | 15% |
| Science | 15% |
| Other tech | 15% |
| Miscellaneous | 10% |

### Karma Distribution

| Range | Users | Description |
|-------|-------|-------------|
| 0-100 | Majority | Lurkers, new accounts |
| 100-1000 | Regular | Occasional contributors |
| 1000-10000 | Established | Frequent commenters |
| 10000+ | Legendary | patio11 (127K+), etc. |

### Most Favorited Posts (All Time)

Top 5 Ask HN posts:
1. "What books changed the way you think?" (836 favorites)
2. "What are the best MOOCs?" (783 favorites)
3. "How to self-learn electronics?" (685 favorites)
4. "Successful one-person online businesses?" (581 favorites)
5. "What's the most valuable thing to learn in an hour?" (554 favorites)

**Pattern:** Ask HN posts dominate favorites (no external link = favorite the discussion).

---

## Cross-References

- [HACKER_NEWS_DEEP_DIVE.md](./HACKER_NEWS_DEEP_DIVE.md) - Community and culture
- [HACKER_NEWS_HISTORY.md](./HACKER_NEWS_HISTORY.md) - Historical timeline
- [PROMINENT_HACKER_NEWS_CONTRIBUTORS.md](./PROMINENT_HACKER_NEWS_CONTRIBUTORS.md) - User analysis

---

*Document compiled from public HN posts, source code analysis, and community research. Last updated: March 2026*
