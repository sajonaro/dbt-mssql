with derived_from_ds1 as (

  select
    {{ select_columns_except(source('input_db', 'DS1'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS1') }}

),


final as (
    select *
    from derived_from_ds1
)

select * from final
