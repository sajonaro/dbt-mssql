with derived_from_ds138 as (

  select
    {{ select_columns_except(source('input_db', 'DS138'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS138') }}

),


final as (
    select *
    from derived_from_ds138
)

select * from final
