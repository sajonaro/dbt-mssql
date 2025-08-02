with derived_from_ds224 as (

  select
    {{ select_columns_except(source('input_db', 'DS224'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS224') }}

),


final as (
    select *
    from derived_from_ds224
)

select * from final
