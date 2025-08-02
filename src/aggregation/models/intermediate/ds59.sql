with derived_from_ds59 as (

  select
    {{ select_columns_except(source('input_db', 'DS59'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS59') }}

),


final as (
    select *
    from derived_from_ds59
)

select * from final
