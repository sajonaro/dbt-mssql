with derived_from_FactOnlineSales as (
    select *
    from {{ source('input_db', 'FactOnlineSales') }}

),

final as (
    select *
    from derived_from_FactOnlineSales
)


select * from final
