with derived_from_ds290 as (

  select
    {{ select_columns_except(source('input_db', 'DS290'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS290') }}

),


final as (
    select *
    from derived_from_ds290
)

select * from final
