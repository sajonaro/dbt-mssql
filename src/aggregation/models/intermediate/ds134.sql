with derived_from_ds134 as (

  select
    {{ select_columns_except(source('input_db', 'DS134'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS134') }}

),


final as (
    select *
    from derived_from_ds134
)

select * from final
