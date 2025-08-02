with derived_from_ds147 as (

  select
    {{ select_columns_except(source('input_db', 'DS147'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS147') }}

),


final as (
    select *
    from derived_from_ds147
)

select * from final
