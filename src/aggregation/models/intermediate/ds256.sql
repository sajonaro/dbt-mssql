with derived_from_ds256 as (

  select
    {{ select_columns_except(source('input_db', 'DS256'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS256') }}

),


final as (
    select *
    from derived_from_ds256
)

select * from final
