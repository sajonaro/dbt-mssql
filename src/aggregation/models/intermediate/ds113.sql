with derived_from_ds113 as (

  select
    {{ select_columns_except(source('input_db', 'DS113'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS113') }}

),


final as (
    select *
    from derived_from_ds113
)

select * from final
