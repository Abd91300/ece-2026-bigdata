{{ config(severity='warn') }}

-- Exercise 4: the 3 first digits of the ZIP code must belong to a range of the state
-- Reference data: USPS ZIP code prefixes per state (seed state_zip_ranges)
select
    u.user_id,
    u.state,
    u.zip_code
from {{ ref('stg_users') }} u
where not exists (
    select 1
    from {{ ref('state_zip_ranges') }} r
    where r.state = u.state
      and cast(left(u.zip_code, 3) as integer) between r.zip3_min and r.zip3_max
)
