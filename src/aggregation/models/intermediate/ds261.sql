with derived_from_ds261 as (

  select
    {{ select_columns_except(source('input_db', 'DS261'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS261') }}

),


final as (
    select *
    from derived_from_ds261
)

select * from final
