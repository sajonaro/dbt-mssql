with derived_from_DimProduct as (
    select *
    from {{ source('input_db', 'DimProduct') }}

),

final as (
    select *
    from derived_from_DimProduct
)


select * from final
