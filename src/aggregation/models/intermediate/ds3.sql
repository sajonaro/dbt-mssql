with derived_from_ds3 as (

  select
    {{ select_columns_except(source('input_db', 'DS3'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS3') }}

),


final as (
    select *
    from derived_from_ds3
)

select * from final
