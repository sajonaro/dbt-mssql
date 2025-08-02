with derived_from_ds230 as (

  select
    {{ select_columns_except(source('input_db', 'DS230'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS230') }}

),


final as (
    select *
    from derived_from_ds230
)

select * from final
