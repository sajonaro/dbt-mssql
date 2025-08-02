with derived_from_ds273 as (

  select
    {{ select_columns_except(source('input_db', 'DS273'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS273') }}

),


final as (
    select *
    from derived_from_ds273
)

select * from final
