with derived_from_ds116 as (

  select
    {{ select_columns_except(source('input_db', 'DS116'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS116') }}

),


final as (
    select *
    from derived_from_ds116
)

select * from final
