with derived_from_ds314 as (

  select
    {{ select_columns_except(source('input_db', 'DS314'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS314') }}

),


final as (
    select *
    from derived_from_ds314
)

select * from final
