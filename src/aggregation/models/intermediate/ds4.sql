with derived_from_ds4 as (

  select
    {{ select_columns_except(source('input_db', 'DS4'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS4') }}

),


final as (
    select *
    from derived_from_ds4
)

select * from final
