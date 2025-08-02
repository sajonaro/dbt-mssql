with derived_from_ds98 as (

  select
    {{ select_columns_except(source('input_db', 'DS98'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS98') }}

),


final as (
    select *
    from derived_from_ds98
)

select * from final
