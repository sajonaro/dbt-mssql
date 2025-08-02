with derived_from_ds130 as (

  select
    {{ select_columns_except(source('input_db', 'DS130'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS130') }}

),


final as (
    select *
    from derived_from_ds130
)

select * from final
