with derived_from_ds148 as (

  select
    {{ select_columns_except(source('input_db', 'DS148'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS148') }}

),


final as (
    select *
    from derived_from_ds148
)

select * from final
