with derived_from_ds79 as (

  select
    {{ select_columns_except(source('input_db', 'DS79'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS79') }}

),


final as (
    select *
    from derived_from_ds79
)

select * from final
