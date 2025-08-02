with derived_from_ds322 as (

  select
    {{ select_columns_except(source('input_db', 'DS322'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS322') }}

),


final as (
    select *
    from derived_from_ds322
)

select * from final
