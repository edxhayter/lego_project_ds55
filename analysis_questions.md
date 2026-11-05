# LEGO SQL Analysis Questions

Five questions on the LEGO dataset, ordered from beginner to advanced. Each one lists the tables you'll need and the SQL skills it tests.

| # | Level | Question | Tables |
|---|-------|----------|--------|
| 1 | Beginner | [Sets per year](#1-sets-per-year) | 1 |
| 2 | Beginner–Intermediate | [Biggest themes](#2-biggest-themes) | 2 |
| 3 | Intermediate | [Part category coverage](#3-part-category-coverage) | 2 |
| 4 | Upper-Intermediate | [Most-used colour per decade](#4-most-used-colour-per-decade) | 4 |
| 5 | Advanced | [Theme "signature" parts](#5-theme-signature-parts) | 7 |

---

## 1. Sets per year

**Level:** Beginner

How many LEGO sets were released each year from 2000 onwards? Show the most recent year first.

- **Tables:** `lego_sets`
- **Skills tested:** `SELECT`, `WHERE`, `GROUP BY`, `COUNT`, `ORDER BY`

---

## 2. Biggest themes

**Level:** Beginner–Intermediate

What are the 10 themes with the most sets? Show the theme name, the number of sets and the average parts per set (rounded to 1 decimal place). Only include themes with at least 50 sets.

- **Tables:** `lego_sets` → `lego_themes`
- **Skills tested:** `INNER JOIN`, aggregation, `HAVING` versus `WHERE`, `ROUND`, `LIMIT`

---

## 3. Part category coverage

**Level:** Intermediate

For every part category, show how many distinct parts it contains and what percentage of all parts that is. Include categories with zero parts.

- **Tables:** `lego_part_categories` → `lego_parts`
- **Skills tested:**
  - `LEFT JOIN` (and knowing which side to keep)
  - `COUNT(DISTINCT ...)` versus `COUNT(*)`
  - A window aggregate (`SUM(...) OVER ()`) or a scalar subquery to get the percentage
  - Handling `NULL`s

---

## 4. Most-used colour per decade

**Level:** Upper-Intermediate

For each decade, which non-transparent colour was used most, measured by total quantity of non-spare parts? Return the decade, colour name, RGB value and total quantity.

- **Tables:** `lego_sets` → `inventories` → `lego_inventory_parts` → `lego_colors`
- **Skills tested:**
  - Joining four tables
  - Deriving a decade (`FLOOR(year / 10) * 10`)
  - Filtering on the `'t'` / `'f'` flag columns
  - Ranking within groups (`ROW_NUMBER()` / `RANK()` with `QUALIFY`)
  - Deciding how to break ties

---

## 5. Theme "signature" parts

**Level:** Advanced (needs several CTEs)

Use only the latest inventory version of each set, and roll every theme up to its top-level parent theme. For each top-level theme, what percentage of its total non-spare part quantity comes from "signature" parts, meaning parts that don't appear in any other top-level theme?

Return the top 10 top-level themes by that percentage, counting only those with at least 20 sets.

- **Tables:** all except `lego_inventory_sets`
- **Skills tested:**
  - Multiple CTEs and recursive CTEs
  - Deduplicating with window functions
  - Conditional aggregation
  - Spotting a trap in the data: some sets have several inventory versions, which would double-count parts if not handled

**Suggested CTE chain:**

1. **`latest_inventory`**: one inventory per set, the highest version
   ```sql
   QUALIFY ROW_NUMBER() OVER (PARTITION BY set_num ORDER BY version DESC) = 1
   ```
2. **`theme_root`**: a recursive CTE that walks `theme_parent_id` up to the top-level theme
3. **`part_usage`**: part quantities by top-level theme, excluding spares
4. **`signature_parts`**: parts used in exactly one top-level theme
   ```sql
   HAVING COUNT(DISTINCT root_theme_id) = 1
   ```
5. **Final aggregate**: combines the above with conditional aggregation (`SUM(CASE WHEN ... )`) and applies the 20-set minimum
