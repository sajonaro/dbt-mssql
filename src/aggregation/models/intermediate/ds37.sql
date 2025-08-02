with derived_from_ds37 as (

  select
    {{ select_columns_except(source('input_db', 'DS37'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS37') }}

),


final as (
    select *
    from derived_from_ds37
)

select * from final
