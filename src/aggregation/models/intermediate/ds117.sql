with derived_from_ds117 as (

  select
    {{ select_columns_except(source('input_db', 'DS117'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS117') }}

),


final as (
    select *
    from derived_from_ds117
)

select * from final
