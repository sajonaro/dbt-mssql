with derived_from_ds133 as (

  select
    {{ select_columns_except(source('input_db', 'DS133'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS133') }}

),


final as (
    select *
    from derived_from_ds133
)

select * from final
