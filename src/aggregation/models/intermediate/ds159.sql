with derived_from_ds159 as (

  select
    {{ select_columns_except(source('input_db', 'DS159'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS159') }}

),


final as (
    select *
    from derived_from_ds159
)

select * from final
