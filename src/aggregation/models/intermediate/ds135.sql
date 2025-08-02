with derived_from_ds135 as (

  select
    {{ select_columns_except(source('input_db', 'DS135'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS135') }}

),


final as (
    select *
    from derived_from_ds135
)

select * from final
