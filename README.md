# Overwatch Performance Analyzer

A personal match performance analytics project built with **PostgreSQL**, **SQL**, and **Power BI**. This project demonstrates a full data analytics pipeline — from database design and data ingestion to SQL analysis and interactive dashboard visualization.

---

## Project Overview

As a former top-100 North America Overwatch tank player, I built this project to analyze personal match performance data and surface actionable insights about hero selection, map performance, and win rate trends over time.

---

## Tools & Technologies

- **PostgreSQL** — relational database for storing match history
- **pgAdmin 4** — database management and query execution
- **SQL** — aggregations, window functions, and CTEs for analysis
- **Power BI** — interactive dashboard with two report pages

---

## Database Schema

```sql
CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    match_date DATE,
    hero VARCHAR(50),
    role VARCHAR(20),
    map VARCHAR(50),
    map_type VARCHAR(20),
    kills INT,
    deaths INT,
    assists INT,
    damage_dealt INT,
    damage_taken INT,
    healing_done INT,
    win INT,
    match_duration_minutes NUMERIC(5,2),
    rank_at_time VARCHAR(20)
);
```

---

## SQL Analysis

Five queries were written to answer key performance questions:

| Query | Description |
|-------|-------------|
| Win Rate by Hero | Aggregated win %, games played, and total wins per hero |
| Win Rate by Map | Identified strongest and weakest maps by win rate |
| K/D by Role | Compared tank vs support K/D ratio, damage, and win rate |
| Rolling Win Rate | 5-game rolling average using window functions to track trends |
| Hero vs Average | CTE comparing each hero's win rate against overall average |

See [`queries.sql`](./queries.sql) for all query code.

---

## Key Insights

- **Ana** had the highest win rate at **83.3%**, over 25 points above the overall average
- **Ramattra** was the weakest hero at **40%** win rate, 18 points below average
- **Numbani** was the best map at **100%** win rate across 4 games
- **Tank** role had a significantly higher K/D ratio (**4.04**) vs support (**1.66**), while win rates were nearly identical (~58%)
- Win rate showed strong peaks in **July and October**, with a notable dip in September

---

## Power BI Dashboard

The dashboard contains two interactive pages:

**Page 1 — Hero & Map Breakdown**
- Win rate by hero (bar chart)
- Games played by hero (bar chart)
- Win rate by map (bar chart)

**Page 2 — Win Rate Trends**
- Monthly win rate trend line
- Hero slicer for filtering by individual hero

---

## Files

| File | Description |
|------|-------------|
| `Overwatch_Analytics.pbix` | Power BI dashboard file |
| `queries.sql` | All SQL queries used in analysis |
| `README.md` | Project documentation |

---

## About

Built by Nicholas — Statistics + CS Minor + Data Analytics Certificate @ University of Florida.

Combining domain expertise in competitive Overwatch with data analytics skills to build portfolio projects that demonstrate real-world SQL, database, and BI capabilities.
