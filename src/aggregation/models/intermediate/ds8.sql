with derived_from_ds8 as (

  select
    {{ select_columns_except(source('input_db', 'DS8'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS8') }}

),


final as (
    select *
    from derived_from_ds8
)

select * from final
