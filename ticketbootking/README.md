# Ticket Booking dbt Application

A comprehensive dbt application for ticket booking analytics with semantic models and metrics for metric flow.

## Overview

This dbt project provides a complete data transformation pipeline for a ticket booking system, including:

- **Staging Models**: Clean and standardize raw data from various sources
- **Mart Models**: Business-ready dimensional and fact tables with comprehensive datetime fields
- **Semantic Models**: Define entities, dimensions, and measures for metric flow
- **Metrics**: Pre-defined KPIs and business metrics for analytics
- **Reporting Models**: Aggregated summaries for business intelligence

## Project Structure

```
models/
├── staging/                    # Raw data cleaning and standardization
│   ├── stg_events.sql         # Events data
│   ├── stg_tickets.sql        # Tickets data
│   ├── stg_customers.sql      # Customers data
│   ├── stg_orders.sql         # Orders data
│   ├── sources.yml            # Source definitions
│   └── schema.yml             # Staging model documentation
├── marts/
│   ├── core/                  # Core dimensional and fact tables
│   │   ├── dim_events.sql     # Events dimension with datetime fields
│   │   ├── dim_customers.sql  # Customers dimension with lifecycle analysis
│   │   ├── fact_ticket_sales.sql # Ticket sales fact table
│   │   ├── fact_orders.sql    # Orders fact table
│   │   └── schema.yml         # Core model documentation
│   └── reporting/             # Aggregated reporting models
│       ├── daily_sales_summary.sql      # Daily sales metrics
│       ├── monthly_customer_metrics.sql # Monthly customer analytics
│       └── schema.yml                   # Reporting model documentation
├── semantic_models/           # Semantic layer definitions
│   ├── ticket_sales_semantic_model.yml  # Ticket sales semantic model
│   ├── orders_semantic_model.yml        # Orders semantic model
│   └── customers_semantic_model.yml     # Customers semantic model
├── metrics/                   # Business metrics definitions
│   ├── ticket_booking_metrics.yml       # Ticket booking KPIs
│   ├── order_metrics.yml                # Order-related metrics
│   └── customer_metrics.yml             # Customer analytics metrics
└── example/                   # Example models (from dbt starter)
```

## Key Features

### Comprehensive Datetime Analysis
All models include extensive datetime fields for time-based analytics:
- Multiple time granularities (day, week, month, quarter, year)
- Season and time-of-day analysis
- Business logic flags (future/past events, today's events)
- Time-based calculations (days between events, advance purchase timing)

### Semantic Models for Metric Flow
- **Entities**: Primary and foreign key relationships
- **Dimensions**: Time, categorical, and status dimensions
- **Measures**: Count, sum, average, and conditional measures
- **Time Granularities**: Multiple time dimensions for flexible analysis

### Business Metrics
Pre-defined metrics for common KPIs:
- **Revenue Metrics**: Total revenue, average ticket price, growth rates
- **Volume Metrics**: Tickets sold, unique customers, conversion rates
- **Customer Metrics**: Lifecycle stages, retention rates, engagement
- **Operational Metrics**: Discount rates, refund rates, fulfillment times

### Data Quality & Documentation
- Comprehensive schema documentation
- Model documentation and descriptions
- Source definitions and column descriptions

## Getting Started

### Prerequisites
- dbt Core 1.0+
- Access to a data warehouse (BigQuery, Snowflake, Redshift, etc.)
- Python 3.7+

### Installation

1. **Install dbt packages:**
   ```bash
   dbt deps
   ```

2. **Configure your database connection** in `~/.dbt/profiles.yml`

3. **Run the models:**
   ```bash
   # Run all models
   dbt run
   
   # Run specific model groups
   dbt run --models staging
   dbt run --models marts
   dbt run --models semantic_models
   dbt run --models metrics
   ```

4. **Generate documentation:**
   ```bash
   dbt docs generate
   dbt docs serve
   ```

## Model Materialization

- **Staging Models**: Views (fast development)
- **Core Mart Models**: Tables (performance)
- **Reporting Models**: Tables (performance)
- **Semantic Models**: Views (flexibility)
- **Metrics**: Views (flexibility)

## Key Business Metrics

### Revenue Analytics
- `total_revenue`: Total revenue from ticket sales
- `avg_ticket_price`: Average ticket price
- `revenue_growth_rate`: Month-over-month revenue growth

### Customer Analytics
- `total_customers`: Total number of customers
- `customer_retention_rate`: Percentage of active customers
- `avg_customer_spend`: Average spending per customer

### Operational Analytics
- `conversion_rate`: Percentage of confirmed bookings
- `cancellation_rate`: Percentage of cancelled bookings
- `avg_days_advance_purchase`: Average advance booking time

## Data Sources

The project expects the following source tables:
- `ticket_booking.events`: Event information and venue details
- `ticket_booking.tickets`: Ticket sales and booking data
- `ticket_booking.customers`: Customer information and preferences
- `ticket_booking.orders`: Order details and payment information

## Customization

### Adding New Metrics
1. Define measures in semantic models
2. Create derived metrics in metrics YAML files
3. Use metric flow for complex calculations

### Adding New Dimensions
1. Add columns to staging models
2. Include in mart models with datetime analysis
3. Define in semantic models for metric flow

### Extending Datetime Analysis
All models include comprehensive datetime fields. To add new time-based analysis:
1. Add datetime extractions in mart models
2. Include in semantic model dimensions
3. Create time-based metrics

## Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Semantic Layer](https://docs.getdbt.com/docs/use-dbt-semantic-layer/quickstart-semantic-layer)
- [dbt Metrics](https://docs.getdbt.com/docs/build/metrics)
- [dbt Community](https://community.getdbt.com/)

## Support

For questions or issues:
1. Check the dbt documentation
2. Review model documentation in `dbt docs`
3. Join the dbt Community Slack
4. Create an issue in the project repository
