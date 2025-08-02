with derived_from_ds315 as (

  select
    {{ select_columns_except(source('input_db', 'DS315'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS315') }}

),


final as (
    select *
    from derived_from_ds315
)

select * from final
