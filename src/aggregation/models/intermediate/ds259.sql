with derived_from_ds259 as (

  select
    {{ select_columns_except(source('input_db', 'DS259'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS259') }}

),


final as (
    select *
    from derived_from_ds259
)

select * from final
