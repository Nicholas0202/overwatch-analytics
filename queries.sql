-- ============================================
-- Overwatch Personal Performance Analyzer
-- SQL Queries | PostgreSQL
-- Author: Nicholas
-- Database: Overwatch_stats
-- ============================================


-- ============================================
-- TABLE SETUP
-- ============================================

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


-- ============================================
-- QUERY 1: Win Rate by Hero
-- Shows total games, wins, and win rate % per hero
-- Ordered by win rate descending
-- ============================================

SELECT hero, 
       COUNT(*) AS games_played,
       SUM(win) AS wins,
       ROUND(AVG(win) * 100, 1) AS win_rate_pct
FROM matches
GROUP BY hero
ORDER BY win_rate_pct DESC;


-- ============================================
-- QUERY 2: Win Rate and Avg Kills by Map
-- Identifies strongest and weakest maps
-- ============================================

SELECT map,
       COUNT(*) AS games_played,
       ROUND(AVG(win) * 100, 1) AS win_rate_pct,
       ROUND(AVG(kills), 1) AS avg_kills
FROM matches
GROUP BY map
ORDER BY win_rate_pct DESC;


-- ============================================
-- QUERY 3: K/D Ratio, Avg Damage, and Win Rate by Role
-- Compares tank vs support performance
-- ============================================

SELECT role,
       ROUND(AVG(kills::numeric / NULLIF(deaths, 0)), 2) AS avg_kd_ratio,
       ROUND(AVG(damage_dealt), 0) AS avg_damage,
       ROUND(AVG(win) * 100, 1) AS win_rate_pct
FROM matches
GROUP BY role;


-- ============================================
-- QUERY 4: Rolling 5-Game Win Rate Over Time
-- Uses window function to track performance trends
-- ============================================

SELECT match_date, hero, win,
       ROUND(AVG(win) OVER (
           ORDER BY match_date 
           ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
       ) * 100, 1) AS rolling_5game_winrate
FROM matches
ORDER BY match_date;


-- ============================================
-- QUERY 5: Hero Win Rate vs Overall Average (CTE)
-- Shows which heroes perform above/below your average
-- ============================================

WITH overall AS (
    SELECT ROUND(AVG(win) * 100, 1) AS overall_winrate
    FROM matches
)
SELECT hero,
       ROUND(AVG(win) * 100, 1) AS hero_winrate,
       overall.overall_winrate,
       ROUND(AVG(win) * 100 - overall.overall_winrate, 1) AS vs_average
FROM matches, overall
GROUP BY hero, overall.overall_winrate
ORDER BY vs_average DESC;
