with derived_from_ds143 as (

  select
    {{ select_columns_except(source('input_db', 'DS143'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS143') }}

),


final as (
    select *
    from derived_from_ds143
)

select * from final
