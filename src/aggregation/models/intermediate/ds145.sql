with derived_from_ds145 as (

  select
    {{ select_columns_except(source('input_db', 'DS145'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS145') }}

),


final as (
    select *
    from derived_from_ds145
)

select * from final
