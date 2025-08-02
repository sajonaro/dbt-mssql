with derived_from_ds33 as (

  select
    {{ select_columns_except(source('input_db', 'DS33'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS33') }}

),


final as (
    select *
    from derived_from_ds33
)

select * from final
