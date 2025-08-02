with derived_from_DimPromotion as (
    select *
    from {{ source('input_db', 'DimPromotion') }}

),

final as (
    select *
    from derived_from_DimPromotion
)


select * from final
