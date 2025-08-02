with derived_from_ds161 as (

  select
    {{ select_columns_except(source('input_db', 'DS161'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS161') }}

),


final as (
    select *
    from derived_from_ds161
)

select * from final
