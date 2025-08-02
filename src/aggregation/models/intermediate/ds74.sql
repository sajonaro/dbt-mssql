with derived_from_ds74 as (

  select
    {{ select_columns_except(source('input_db', 'DS74'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS74') }}

),


final as (
    select *
    from derived_from_ds74
)

select * from final
