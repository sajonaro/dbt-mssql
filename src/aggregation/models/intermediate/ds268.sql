with derived_from_ds268 as (

  select
    {{ select_columns_except(source('input_db', 'DS268'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS268') }}

),


final as (
    select *
    from derived_from_ds268
)

select * from final
