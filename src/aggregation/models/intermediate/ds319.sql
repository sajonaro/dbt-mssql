with derived_from_ds319 as (

  select
    {{ select_columns_except(source('input_db', 'DS319'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS319') }}

),


final as (
    select *
    from derived_from_ds319
)

select * from final
