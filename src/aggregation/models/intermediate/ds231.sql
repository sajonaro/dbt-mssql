with derived_from_ds231 as (

  select
    {{ select_columns_except(source('input_db', 'DS231'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS231') }}

),


final as (
    select *
    from derived_from_ds231
)

select * from final
