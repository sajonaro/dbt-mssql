with derived_from_ds91 as (

  select
    {{ select_columns_except(source('input_db', 'DS91'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS91') }}

),


final as (
    select *
    from derived_from_ds91
)

select * from final
