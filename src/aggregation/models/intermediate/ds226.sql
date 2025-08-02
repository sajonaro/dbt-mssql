with derived_from_ds226 as (

  select
    {{ select_columns_except(source('input_db', 'DS226'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS226') }}

),


final as (
    select *
    from derived_from_ds226
)

select * from final
