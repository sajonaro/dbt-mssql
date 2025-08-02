with derived_from_ds137 as (

  select
    {{ select_columns_except(source('input_db', 'DS137'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS137') }}

),


final as (
    select *
    from derived_from_ds137
)

select * from final
