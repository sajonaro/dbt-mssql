with derived_from_ds158 as (

  select
    {{ select_columns_except(source('input_db', 'DS158'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS158') }}

),


final as (
    select *
    from derived_from_ds158
)

select * from final
