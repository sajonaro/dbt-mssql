with derived_from_ds115 as (

  select
    {{ select_columns_except(source('input_db', 'DS115'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS115') }}

),


final as (
    select *
    from derived_from_ds115
)

select * from final
