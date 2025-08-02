with derived_from_ds126 as (

  select
    {{ select_columns_except(source('input_db', 'DS126'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS126') }}

),


final as (
    select *
    from derived_from_ds126
)

select * from final
