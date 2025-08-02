with derived_from_ds55 as (

  select
    {{ select_columns_except(source('input_db', 'DS55'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS55') }}

),


final as (
    select *
    from derived_from_ds55
)

select * from final
