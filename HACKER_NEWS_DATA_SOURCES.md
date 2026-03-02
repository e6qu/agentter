# Hacker News Data Sources

Complete guide to accessing, downloading, and using Hacker News data locally.

---

## Table of Contents

1. [Quick Overview](#quick-overview)
2. [Google BigQuery (Official)](#google-bigquery-official)
3. [Official HN API](#official-hn-api)
4. [Downloadable Datasets](#downloadable-datasets)
5. [GitHub Repositories for Data Extraction](#github-repositories-for-data-extraction)
6. [Local Database Setup](#local-database-setup)
7. [Data Schema](#data-schema)
8. [Usage Examples](#usage-examples)

---

## Quick Overview

| Source | Size | Update Frequency | Cost | Skill Level |
|--------|------|------------------|------|-------------|
| BigQuery Public Dataset | ~17GB | Daily | Free tier (1TB/mo queries) | SQL |
| Official API | Real-time | Real-time | Free | Programming |
| ClickHouse CSV | ~4.6GB (compressed) | Periodic | Free | SQL |
| Kaggle Dataset | 2006-2017 | Static | Free | Python/R |
| Self-scraped | Variable | Your choice | Free (compute costs) | Programming |

---

## Google BigQuery (Official)

### What It Is
The official Hacker News public dataset hosted on Google BigQuery, maintained by a third party but updated daily from the official HN API.

### Dataset Location
```
bigquery-public-data.hacker_news
```

### Available Tables

| Table | Description | Rows (approx) |
|-------|-------------|---------------|
| `full` | All items (stories, comments, jobs) | 46M+ |
| `stories` | Story submissions only | 6M+ |
| `comments` | Comments only | 40M+ |

### Access Methods

**Web Console:**
```
https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=hacker_news
```

**Command Line:**
```bash
# Requires gcloud CLI installation
bq query --use_legacy_sql=false \
  'SELECT * FROM `bigquery-public-data.hacker_news.full` LIMIT 10'
```

**Python:**
```python
from google.cloud import bigquery

client = bigquery.Client()
query = """
    SELECT title, score, by, time
    FROM `bigquery-public-data.hacker_news.full`
    WHERE type = 'story'
    ORDER BY score DESC
    LIMIT 100
"""
results = client.query(query)
for row in results:
    print(f"{row.title}: {row.score} points")
```

### Exporting to Local Storage

**Export to Google Cloud Storage (then download):**
```bash
# Export full table to GCS
bq extract --destination_format=CSV \
  bigquery-public-data:hacker_news.full \
  gs://your-bucket/hn_full.csv

# Download from GCS
gsutil cp gs://your-bucket/hn_full.csv ./
```

**Web UI Method:**
1. Run your query
2. Click "Save Results"
3. Choose format (CSV, JSON, Avro, Parquet)
4. Download locally or save to GCS

**Size limits:**
- Web UI download: 16,000 rows max
- GCS export: No practical limit
- Compressed exports recommended for full dataset

### Free Tier Limits
- 1TB of query processing per month
- 10GB storage for your own tables
- Exports from public datasets are free

---

## Official HN API

### Base URL
```
https://hacker-news.firebaseio.com/v0/
```

### Endpoints

| Endpoint | Description | Example |
|----------|-------------|---------|
| `/topstories.json` | Top 500 story IDs | [Link](https://hacker-news.firebaseio.com/v0/topstories.json) |
| `/newstories.json` | New 500 story IDs | [Link](https://hacker-news.firebaseio.com/v0/newstories.json) |
| `/beststories.json` | Best 500 story IDs | [Link](https://hacker-news.firebaseio.com/v0/beststories.json) |
| `/item/{id}.json` | Item details | `/item/8863.json` |
| `/user/{id}.json` | User details | `/user/pg.json` |
| `/maxitem.json` | Latest item ID | [Link](https://hacker-news.firebaseio.com/v0/maxitem.json) |
| `/updates.json` | Changed items/users | [Link](https://hacker-news.firebaseio.com/v0/updates.json) |

### Rate Limits
- ~8 concurrent requests before throttling
- Reasonable personal use is fine
- Don't hammer the API

### Python Example
```python
import requests
import json

def get_item(item_id):
    """Fetch a single item by ID"""
    url = f"https://hacker-news.firebaseio.com/v0/item/{item_id}.json"
    response = requests.get(url)
    return response.json()

def get_max_item():
    """Get the latest item ID"""
    url = "https://hacker-news.firebaseio.com/v0/maxitem.json"
    response = requests.get(url)
    return response.json()

# Download recent items
max_id = get_max_item()
for item_id in range(max_id - 100, max_id):
    item = get_item(item_id)
    if item:
        print(f"{item.get('title', 'Comment')}: {item.get('score', 'N/A')}")
```

### Downloading Everything

**Time estimate:** 
- Stories: ~2 hours
- Comments: ~11 hours
- Total: ~46M items

**Sample Python scraper (async):**
```python
import aiohttp
import asyncio

async def fetch_item(session, item_id):
    url = f"https://hacker-news.firebaseio.com/v0/item/{item_id}.json"
    async with session.get(url) as response:
        return await response.json()

async def download_range(start, end):
    async with aiohttp.ClientSession() as session:
        tasks = [fetch_item(session, i) for i in range(start, end)]
        return await asyncio.gather(*tasks)

# Download 1000 items starting from ID 1
results = asyncio.run(download_range(1, 1000))
```

---

## Downloadable Datasets

### 1. ClickHouse Dataset (Recommended for Local Analysis)

**Source:** ClickHouse Documentation
**Size:** 4.6GB compressed (28M rows)
**Format:** CSV.gz or Parquet

**Download:**
```bash
# CSV version
wget https://datasets-documentation.s3.eu-west-3.amazonaws.com/hackernews/hacknernews.csv.gz

# Parquet version (more efficient)
wget https://datasets-documentation.s3.eu-west-3.amazonaws.com/hackernews/hacknernews.parquet
```

**Import to ClickHouse:**
```sql
CREATE TABLE hackernews
(
    id UInt32,
    deleted UInt8,
    type String,
    by String,
    time DateTime,
    text String,
    dead UInt8,
    parent UInt32,
    poll UInt32,
    kids Array(UInt32),
    url String,
    score Int32,
    title String,
    parts Array(UInt32),
    descendants Int32
)
ENGINE = MergeTree
ORDER BY id;

INSERT INTO hackernews SELECT *
FROM file('hacknernews.csv.gz', 'CSVWithNames');
```

### 2. Kaggle Dataset (Historical)

**URL:** https://www.kaggle.com/datasets/hacker-news/hacker-news

**Coverage:** 2006 to late 2017
**Size:** ~8.4M comments, ~2M stories
**Format:** CSV

**Note:** This is a static snapshot, not updated.

### 3. HN Data Dumps (GitHub)

**Repository:** https://github.com/ashish01/hn-data-dumps

**Format:** Sharded Parquet files
**Update:** Daily automated updates
**Size:** ~40M comments, ~6M stories

**Usage with DuckDB:**
```bash
duckdb -c "SELECT json_extract_string(item_json, '$.type') AS type, 
                  COUNT(*) AS count 
           FROM 'data/hn-*.parquet' 
           GROUP BY 1 ORDER BY 2 DESC"
```

### 4. SQLite Archive (Browser-based)

**Project:** HackerBook (22GB SQLite in browser)
**URL:** https://hackerbook.dosaygo.com/
**Innovation:** Uses sharded SQLite files with HTTP range requests

**Technical approach:**
- 1,637 shards of SQLite databases
- Fetches only needed shards via HTTP
- ~8.5GB compressed total
- WASM-based SQLite in browser

**GitHub:** https://github.com/dosaygo/hackerbook

---

## GitHub Repositories for Data Extraction

### 1. minimaxir/get-all-hacker-news-submissions-comments

**URL:** https://github.com/minimaxir/get-all-hacker-news-submissions-comments

**Purpose:** Python scripts to download all HN data to PostgreSQL
**Status:** Legacy (recommends BigQuery now)

### 2. hn2sqlite

**URL:** https://github.com/jesrui/hn2sqlite

**Purpose:** Convert HN JSON dumps to SQLite
**Result:** ~3.8GB SQLite database
**Time:** ~6 minutes for stories+comments

**Usage:**
```bash
./hn2sqlite hn-all-stories+comments.sqlite < HNStoriesAll.json
./hn2sqlite hn-all-stories+comments.sqlite < HNCommentsAll.json
```

### 3. hackernews-dump (Go)

**URL:** https://github.com/iOliverNguyen/hackernews-dump

**Features:**
- Concurrent downloads (30 goroutines)
- Incremental updates
- Chunked storage (1000 items/file)
- Resume support

**Usage:**
```bash
go run . sync --concurrent=30 --update-back=1
```

---

## Local Database Setup

### Option 1: SQLite (Simplest)

**Best for:** Personal analysis, single-user

```bash
# Download and install hn2sqlite
git clone https://github.com/jesrui/hn2sqlite.git
cd hn2sqlite
make

# Get data from BigQuery or API, then:
./hn2sqlite hn.db < stories.json
./hn2sqlite hn.db < comments.json

# Query
sqlite3 hn.db
> SELECT by, COUNT(*) as count FROM stories GROUP BY by ORDER BY count DESC LIMIT 10;
```

**Database size:** ~3.8GB for full dataset

### Option 2: PostgreSQL (Full-featured)

**Best for:** Multi-user, complex queries, production use

```sql
-- Create tables
CREATE TABLE hn_items (
    id BIGINT PRIMARY KEY,
    type VARCHAR(20),
    by VARCHAR(50),
    time TIMESTAMP,
    text TEXT,
    parent BIGINT,
    kids BIGINT[],
    url TEXT,
    score INTEGER,
    title TEXT,
    descendants INTEGER
);

-- Load from CSV
COPY hn_items FROM '/path/to/hn_data.csv' CSV HEADER;

-- Create indexes
CREATE INDEX idx_type ON hn_items(type);
CREATE INDEX idx_by ON hn_items(by);
CREATE INDEX idx_time ON hn_items(time);
```

### Option 3: DuckDB (Analytics)

**Best for:** Analytical queries, Parquet files

```python
import duckdb

con = duckdb.connect()

# Query Parquet directly
result = con.execute("""
    SELECT by, COUNT(*) as stories, AVG(score) as avg_score
    FROM 'hacknernews.parquet'
    WHERE type = 'story'
    GROUP BY by
    ORDER BY stories DESC
    LIMIT 10
""").fetchall()
```

### Option 4: ClickHouse (Performance)

**Best for:** Large-scale analytics, fast aggregations

See [ClickHouse Dataset section above](#1-clickhouse-dataset-recommended-for-local-analysis).

---

## Data Schema

### Item Types

| Type | Description | Fields |
|------|-------------|--------|
| `story` | Submission with URL | title, url, score, descendants |
| `comment` | Comment on item | text, parent |
| `job` | Job posting | title, text, url |
| `poll` | Poll question | title, parts, descendants |
| `pollopt` | Poll option | text, poll, score |

### Common Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | Integer | Unique item ID |
| `type` | String | Item type |
| `by` | String | Username |
| `time` | Unix timestamp | Creation time |
| `text` | String | Comment text (HTML) |
| `title` | String | Story/poll title |
| `url` | String | Story URL |
| `score` | Integer | Upvote count |
| `parent` | Integer | Parent item ID (for comments) |
| `kids` | Array | Child item IDs |
| `descendants` | Integer | Total comments |
| `deleted` | Boolean | Deleted status |
| `dead` | Boolean | Dead (flagged) status |

### Important Limitations

1. **Comment scores hidden:** Since October 2014, comment scores are not public
2. **No downvote data:** Only net scores visible
3. **No flag data:** Flagged status not available via API
4. **Vote counts approximate:** Anti-abuse systems modify visible counts

---

## Usage Examples

### Finding Top Stories by Year

**BigQuery:**
```sql
SELECT 
    EXTRACT(YEAR FROM TIMESTAMP_SECONDS(time)) as year,
    title,
    score,
    by
FROM `bigquery-public-data.hacker_news.full`
WHERE type = 'story'
    AND EXTRACT(YEAR FROM TIMESTAMP_SECONDS(time)) = 2023
ORDER BY score DESC
LIMIT 10;
```

**SQLite:**
```sql
SELECT 
    strftime('%Y', datetime(time, 'unixepoch')) as year,
    title,
    score,
    by
FROM items
WHERE type = 'story' 
    AND year = '2023'
ORDER BY score DESC
LIMIT 10;
```

### User Activity Analysis

**DuckDB:**
```sql
SELECT 
    by as username,
    COUNT(*) as total_posts,
    COUNT(CASE WHEN type = 'story' THEN 1 END) as stories,
    COUNT(CASE WHEN type = 'comment' THEN 1 END) as comments,
    AVG(score) as avg_score
FROM 'hacknernews.parquet'
WHERE by IS NOT NULL
GROUP BY by
HAVING total_posts > 100
ORDER BY total_posts DESC
LIMIT 20;
```

### Thread Reconstruction

**Python with recursive query (PostgreSQL/SQLite 3.8+):**
```python
import sqlite3

def get_thread(conn, story_id):
    """Get all comments in a thread with depth"""
    query = """
    WITH RECURSIVE thread(id, parent, text, by, depth) AS (
        SELECT id, parent, text, by, 0
        FROM items
        WHERE id = ?
        
        UNION ALL
        
        SELECT c.id, c.parent, c.text, c.by, t.depth + 1
        FROM items c
        JOIN thread t ON c.parent = t.id
        WHERE c.type = 'comment'
    )
    SELECT * FROM thread ORDER BY depth, id;
    """
    return conn.execute(query, (story_id,)).fetchall()
```

### Domain Analysis

**ClickHouse:**
```sql
SELECT 
    domain(url) as domain,
    COUNT(*) as submissions,
    AVG(score) as avg_score,
    SUM(score) as total_score
FROM hackernews
WHERE type = 'story' AND url != ''
GROUP BY domain
HAVING submissions > 100
ORDER BY total_score DESC
LIMIT 20;
```

### Temporal Patterns

**BigQuery:**
```sql
SELECT 
    EXTRACT(HOUR FROM TIMESTAMP_SECONDS(time)) as hour,
    EXTRACT(DAYOFWEEK FROM TIMESTAMP_SECONDS(time)) as day_of_week,
    COUNT(*) as posts,
    AVG(score) as avg_score
FROM `bigquery-public-data.hacker_news.full`
WHERE type = 'story'
GROUP BY hour, day_of_week
ORDER BY day_of_week, hour;
```

---

## Cross-References

- [HACKER_NEWS_TECHNICAL.md](./HACKER_NEWS_TECHNICAL.md) - Technical details about HN infrastructure
- [HACKER_NEWS_DEEP_DIVE.md](./HACKER_NEWS_DEEP_DIVE.md) - Community analysis
- [HACKER_NEWS_HISTORY.md](./HACKER_NEWS_HISTORY.md) - Historical timeline

---

## External Resources

**Official:**
- HN API Docs: https://github.com/HackerNews/API
- BigQuery Dataset: https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=hacker_news

**Third-party:**
- Algolia Search API: https://hn.algolia.com/api
- hnrss.org: https://hnrss.org/
- Hacker News Digest: https://jesrui.github.io/hacker-news-digest/

---

*Last updated: March 2026*

**Data licensing:** HN data is public. Respect robots.txt, don't overwhelm servers, and follow the API guidelines.
