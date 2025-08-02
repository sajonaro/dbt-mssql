with derived_from_ds5 as (

  select
    {{ select_columns_except(source('input_db', 'DS5'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS5') }}

),


final as (
    select *
    from derived_from_ds5
)

select * from final
