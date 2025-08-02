with derived_from_DimChannel as (
    select *
    from {{ source('input_db', 'DimChannel') }}

),

final as (
    select *
    from derived_from_DimChannel
)


select * from final
