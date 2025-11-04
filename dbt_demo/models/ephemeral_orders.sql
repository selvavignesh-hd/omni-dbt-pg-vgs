{{ config(materialized='ephemeral') }}

select * from {{ source('filing_wh', 'orders') }}