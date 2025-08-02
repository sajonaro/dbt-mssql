with derived_from_ds119 as (

  select
    {{ select_columns_except(source('input_db', 'DS119'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS119') }}

),


final as (
    select *
    from derived_from_ds119
)

select * from final
