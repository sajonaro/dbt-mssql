with derived_from_ds28 as (

  select
    {{ select_columns_except(source('input_db', 'DS28'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS28') }}

),


final as (
    select *
    from derived_from_ds28
)

select * from final
