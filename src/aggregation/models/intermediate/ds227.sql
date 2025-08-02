with derived_from_ds227 as (

  select
    {{ select_columns_except(source('input_db', 'DS227'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS227') }}

),


final as (
    select *
    from derived_from_ds227
)

select * from final
