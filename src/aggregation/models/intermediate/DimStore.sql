with derived_from_DimStore as (
    select *
    from {{ source('input_db', 'DimStore') }}

),

final as (
    select *
    from derived_from_DimStore
)


select * from final
