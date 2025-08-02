with derived_from_ds164 as (

  select
    {{ select_columns_except(source('input_db', 'DS164'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS164') }}

),


final as (
    select *
    from derived_from_ds164
)

select * from final
