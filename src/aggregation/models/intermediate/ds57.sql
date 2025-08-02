with derived_from_ds57 as (

  select
    {{ select_columns_except(source('input_db', 'DS57'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS57') }}

),


final as (
    select *
    from derived_from_ds57
)

select * from final
