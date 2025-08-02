with derived_from_FactSales as (
    select *
    from {{ source('input_db', 'FactSales') }}

),

final as (
    select *
    from derived_from_FactSales
)


select * from final
