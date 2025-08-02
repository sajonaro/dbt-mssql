with derived_from_ds160 as (

  select
    {{ select_columns_except(source('input_db', 'DS160'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS160') }}

),


final as (
    select *
    from derived_from_ds160
)

select * from final
