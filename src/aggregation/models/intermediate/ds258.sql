with derived_from_ds258 as (

  select
    {{ select_columns_except(source('input_db', 'DS258'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS258') }}

),


final as (
    select *
    from derived_from_ds258
)

select * from final
