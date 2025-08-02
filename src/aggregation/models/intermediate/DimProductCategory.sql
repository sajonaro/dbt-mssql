with derived_from_DimProductCategory as (
    select *
    from {{ source('input_db', 'DimProductCategory') }}

),

final as (
    select *
    from derived_from_DimProductCategory
)


select * from final
