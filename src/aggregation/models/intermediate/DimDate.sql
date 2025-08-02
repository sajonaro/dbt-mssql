with derived_from_DimDate as (
    select *
    from {{ source('input_db', 'DimDate') }}

),

final as (
    select *
    from derived_from_DimDate
)


select * from final
