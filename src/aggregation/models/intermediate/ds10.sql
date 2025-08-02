with derived_from_ds10 as (

  select
    {{ select_columns_except(source('input_db', 'DS10'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS10') }}

),


final as (
    select *
    from derived_from_ds10
)

select * from final
