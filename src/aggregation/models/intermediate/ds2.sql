with derived_from_ds2 as (

  select
    {{ select_columns_except(source('input_db', 'DS2'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS2') }}

),


final as (
    select *
    from derived_from_ds2
)

select * from final
