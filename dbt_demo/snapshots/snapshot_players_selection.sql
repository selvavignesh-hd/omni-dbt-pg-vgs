{% snapshot players_selection_snapshot %}
{{
    config(
        target_schema='snapshots',
        target_database='analytics',
        unique_key='id',
        strategy='timestamp',
        updated_at='updated_at',
    )
}}

select * from {{ source('filing_wh', 'player_selection') }}
{% endsnapshot %}