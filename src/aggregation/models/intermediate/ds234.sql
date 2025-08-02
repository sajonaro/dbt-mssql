with derived_from_ds234 as (

  select
    {{ select_columns_except(source('input_db', 'DS234'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS234') }}

),


final as (
    select *
    from derived_from_ds234
)

select * from final
