# Netflix Titles Analytics Models

This directory contains dbt models for analyzing Netflix titles data.

## Models Overview

### Staging Layer

#### `stg_netflix_titles`
- **Type**: View
- **Description**: Staging model that cleans and transforms the raw Netflix titles data from the `public.netflix_titles` table
- **Key Transformations**:
  - Parses duration into numeric values (minutes for movies, seasons for TV shows)
  - Parses date_added into a proper date format
  - Renames `listed_in` to `genres` for clarity
  - Maintains all original fields for downstream use

### Analytics Models

All analytics models are materialized as tables for better query performance.

#### `content_by_type`
- **Description**: Statistics broken down by content type (Movie vs TV Show)
- **Metrics**:
  - Total count and unique titles
  - Release year range
  - Average duration (movies) and seasons (TV shows)
  - Recent additions (last year, last 6 months)

#### `content_by_year`
- **Description**: Statistics grouped by release year
- **Metrics**:
  - Total content count by year
  - Movies vs TV shows breakdown
  - Number of countries and ratings represented
  - Average durations and seasons

#### `content_by_rating`
- **Description**: Statistics grouped by content rating (PG-13, TV-MA, etc.)
- **Metrics**:
  - Total count and percentage of total
  - Movies vs TV shows breakdown
  - Release year range
  - Average durations

#### `content_by_country`
- **Description**: Statistics grouped by country (expands comma-separated countries)
- **Metrics**:
  - Total content per country
  - Movies vs TV shows breakdown
  - Years spanned and release year range
  - Percentage of total content
- **Note**: Only includes countries with at least 5 titles

#### `content_by_genre`
- **Description**: Statistics grouped by genre (expands comma-separated genres)
- **Metrics**:
  - Total content per genre
  - Movies vs TV shows breakdown
  - Years spanned and release year range
  - Average durations
  - Percentage of total content

#### `director_statistics`
- **Description**: Statistics for directors (expands comma-separated directors)
- **Metrics**:
  - Total content per director
  - Movies vs TV shows breakdown
  - Years active and release year range
  - Ratings used
  - Average durations
- **Note**: Only includes directors with at least 2 titles

#### `recent_additions`
- **Description**: Statistics for content added to Netflix by date
- **Metrics**:
  - Content added by day, month, and year
  - Movies vs TV shows breakdown
  - Countries and ratings represented
  - Average durations
- **Grouped by**: Date added, month added, year added

#### `content_summary`
- **Description**: Overall summary statistics in a key-value format
- **Metrics Included**:
  - Total content count
  - Total movies and TV shows
  - Unique countries and directors
  - Earliest and latest release years
  - Average movie duration and TV show seasons
  - Recent additions (last 30 days, last year)

## Usage

To run all models:
```bash
dbt run --models staging.*
```

To run a specific model:
```bash
dbt run --models content_by_type
```

To test the models:
```bash
dbt test --models staging.*
```

## Data Source

All models source data from `public.netflix_titles` table, which should contain the following columns:
- show_id
- type
- title
- director
- cast
- country
- date_added
- release_year
- rating
- duration
- listed_in (genres)
- description

## Notes

- The models use PostgreSQL-specific functions (string_to_array, unnest, regexp_replace, to_date)
- If using a different database adapter, you may need to adjust the SQL syntax
- Date parsing assumes the format "Month DD, YYYY" (e.g., "September 25, 2021")
- Duration parsing extracts numeric values from strings like "90 min" or "2 Seasons"

