with derived_from_ds27 as (

  select
    {{ select_columns_except(source('input_db', 'DS27'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS27') }}

),


final as (
    select *
    from derived_from_ds27
)

select * from final
