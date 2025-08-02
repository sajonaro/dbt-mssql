with derived_from_DimCustomer as (
    select *
    from {{ source('input_db', 'DimCustomer') }}

),

final as (
    select *
    from derived_from_DimCustomer
)


select * from final
