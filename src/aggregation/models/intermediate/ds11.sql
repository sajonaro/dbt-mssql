with derived_from_ds11 as (

  select
    {{ select_columns_except(source('input_db', 'DS11'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS11') }}

),


final as (
    select *
    from derived_from_ds11
)

select * from final