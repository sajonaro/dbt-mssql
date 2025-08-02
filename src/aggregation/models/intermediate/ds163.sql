with derived_from_ds163 as (

  select
    {{ select_columns_except(source('input_db', 'DS163'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS163') }}

),


final as (
    select *
    from derived_from_ds163
)

select * from final
