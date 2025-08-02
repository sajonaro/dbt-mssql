with derived_from_ds6 as (

  select
    {{ select_columns_except(source('input_db', 'DS6'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS6') }}

),


final as (
    select *
    from derived_from_ds6
)

select * from final
