with derived_from_ds232 as (

  select
    {{ select_columns_except(source('input_db', 'DS232'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS232') }}

),


final as (
    select *
    from derived_from_ds232
)

select * from final
