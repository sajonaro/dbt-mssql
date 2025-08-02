with derived_from_ds146 as (

  select
    {{ select_columns_except(source('input_db', 'DS146'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS146') }}

),


final as (
    select *
    from derived_from_ds146
)

select * from final
