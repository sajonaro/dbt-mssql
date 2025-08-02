with derived_from_ds260 as (

  select
    {{ select_columns_except(source('input_db', 'DS260'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS260') }}

),


final as (
    select *
    from derived_from_ds260
)

select * from final
