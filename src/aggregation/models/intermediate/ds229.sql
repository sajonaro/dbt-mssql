with derived_from_ds229 as (

  select
    {{ select_columns_except(source('input_db', 'DS229'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS229') }}

),


final as (
    select *
    from derived_from_ds229
)

select * from final
