-- Base model for player selection data with transformations
with player_selection_base as (
    select 
        id,
        name,
        area,
        status,
        updated_at,
        upper(trim(name)) as name_clean,
        upper(trim(area)) as area_clean,
        upper(trim(status)) as status_clean,
        extract(year from updated_at) as year_updated,
        extract(month from updated_at) as month_updated,
        extract(day from updated_at) as day_updated,
        {{ expand_states('area') }} as state_full_name,
        case 
            when upper(trim(status)) in ('APPROVED', 'PROCESSING') then 'ACTIVE'
            when upper(trim(status)) = 'APPLIED' then 'PENDING'
            when upper(trim(status)) = 'REJECTED' then 'INACTIVE'
            else 'UNKNOWN'
        end as status_category,
        case 
            when upper(trim(area)) in ('TN', 'KA', 'KL', 'AP', 'TS') then 'SOUTH'
            when upper(trim(area)) in ('MH', 'GA', 'MP', 'RJ') then 'WEST'
            when upper(trim(area)) in ('UP', 'PN', 'SP') then 'NORTH'
            else 'OTHER'
        end as region,
        case 
            when updated_at >= current_date - 7 then 'RECENT'
            when updated_at >= current_date - 30 then 'MONTHLY'
            else 'OLDER'
        end as recency_flag
    from {{ source('filing_wh', 'player_selection') }}
)

select 
    id,
    name,
    name_clean,
    area,
    area_clean,
    status,
    status_clean,
    status_category,
    region,
    updated_at,
    state_full_name,
    year_updated,
    month_updated,
    day_updated,
    recency_flag,
    row_number() over (partition by id order by updated_at desc) as rn
from player_selection_base
