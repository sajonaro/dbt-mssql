with derived_from_ds263 as (

  select
    {{ select_columns_except(source('input_db', 'DS263'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS263') }}

),


final as (
    select *
    from derived_from_ds263
)

select * from final
