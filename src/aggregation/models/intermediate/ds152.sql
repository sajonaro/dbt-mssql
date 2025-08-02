with derived_from_ds152 as (

  select
    {{ select_columns_except(source('input_db', 'DS152'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS152') }}

),


final as (
    select *
    from derived_from_ds152
)

select * from final
