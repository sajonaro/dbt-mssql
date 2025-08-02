with derived_from_ds167 as (

  select
    {{ select_columns_except(source('input_db', 'DS167'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS167') }}

),


final as (
    select *
    from derived_from_ds167
)

select * from final
