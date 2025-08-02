with derived_from_DimCurrency as (
    select *
    from {{ source('input_db', 'DimCurrency') }}

),

final as (
    select *
    from derived_from_DimCurrency
)


select * from final
