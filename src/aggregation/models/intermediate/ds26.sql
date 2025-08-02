with derived_from_ds26 as (

  select
    {{ select_columns_except(source('input_db', 'DS26'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS26') }}

),


final as (
    select *
    from derived_from_ds26
)

select * from final
