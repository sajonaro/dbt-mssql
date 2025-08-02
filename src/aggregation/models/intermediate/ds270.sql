with derived_from_ds270 as (

  select
    {{ select_columns_except(source('input_db', 'DS270'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS270') }}

),


final as (
    select *
    from derived_from_ds270
)

select * from final
