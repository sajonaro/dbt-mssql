with derived_from_DimGeography as (
    select *
    from {{ source('input_db', 'DimGeography') }}

),

final as (
    select *
    from derived_from_DimGeography
)


select * from final
