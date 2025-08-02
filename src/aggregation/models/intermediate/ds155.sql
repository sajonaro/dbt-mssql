with derived_from_ds155 as (

  select
    {{ select_columns_except(source('input_db', 'DS155'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS155') }}

),


final as (
    select *
    from derived_from_ds155
)

select * from final
