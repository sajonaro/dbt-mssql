with derived_from_ds123 as (

  select
    {{ select_columns_except(source('input_db', 'DS123'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS123') }}

),


final as (
    select *
    from derived_from_ds123
)

select * from final
