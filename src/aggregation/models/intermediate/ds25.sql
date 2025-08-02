with derived_from_ds25 as (

  select
    {{ select_columns_except(source('input_db', 'DS25'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS25') }}

),


final as (
    select *
    from derived_from_ds25
)

select * from final
