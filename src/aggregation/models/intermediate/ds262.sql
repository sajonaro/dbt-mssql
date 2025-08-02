with derived_from_ds262 as (

  select
    {{ select_columns_except(source('input_db', 'DS262'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS262') }}

),


final as (
    select *
    from derived_from_ds262
)

select * from final
