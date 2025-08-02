with derived_from_ds269 as (

  select
    {{ select_columns_except(source('input_db', 'DS269'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS269') }}

),


final as (
    select *
    from derived_from_ds269
)

select * from final
