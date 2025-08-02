with derived_from_ds29 as (

  select
    {{ select_columns_except(source('input_db', 'DS29'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS29') }}

),


final as (
    select *
    from derived_from_ds29
)

select * from final
