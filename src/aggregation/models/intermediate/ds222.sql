with derived_from_ds222 as (

  select
    {{ select_columns_except(source('input_db', 'DS222'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS222') }}

),


final as (
    select *
    from derived_from_ds222
)

select * from final
