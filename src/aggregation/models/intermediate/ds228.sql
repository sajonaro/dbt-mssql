with derived_from_ds228 as (

  select
    {{ select_columns_except(source('input_db', 'DS228'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS228') }}

),


final as (
    select *
    from derived_from_ds228
)

select * from final
