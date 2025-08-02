with derived_from_ds272 as (

  select
    {{ select_columns_except(source('input_db', 'DS272'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS272') }}

),


final as (
    select *
    from derived_from_ds272
)

select * from final
