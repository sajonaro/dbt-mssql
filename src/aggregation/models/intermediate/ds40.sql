with derived_from_ds40 as (

  select
    {{ select_columns_except(source('input_db', 'DS40'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS40') }}

),


final as (
    select *
    from derived_from_ds40
)

select * from final
