with derived_from_ds120 as (

  select
    {{ select_columns_except(source('input_db', 'DS120'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS120') }}

),


final as (
    select *
    from derived_from_ds120
)

select * from final
