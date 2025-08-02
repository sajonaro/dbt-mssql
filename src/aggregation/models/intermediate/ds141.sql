with derived_from_ds141 as (

  select
    {{ select_columns_except(source('input_db', 'DS141'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS141') }}

),


final as (
    select *
    from derived_from_ds141
)

select * from final
