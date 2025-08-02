with derived_from_ds274 as (

  select
    {{ select_columns_except(source('input_db', 'DS274'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS274') }}

),


final as (
    select *
    from derived_from_ds274
)

select * from final
