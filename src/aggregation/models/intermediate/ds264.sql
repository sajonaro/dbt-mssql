with derived_from_ds264 as (

  select
    {{ select_columns_except(source('input_db', 'DS264'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS264') }}

),


final as (
    select *
    from derived_from_ds264
)

select * from final
