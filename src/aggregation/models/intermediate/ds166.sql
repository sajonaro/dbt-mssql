with derived_from_ds166 as (

  select
    {{ select_columns_except(source('input_db', 'DS166'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS166') }}

),


final as (
    select *
    from derived_from_ds166
)

select * from final
