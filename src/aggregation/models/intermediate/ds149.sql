with derived_from_ds149 as (

  select
    {{ select_columns_except(source('input_db', 'DS149'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS149') }}

),


final as (
    select *
    from derived_from_ds149
)

select * from final
