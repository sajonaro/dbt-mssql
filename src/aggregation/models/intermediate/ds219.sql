with derived_from_ds219 as (

  select
    {{ select_columns_except(source('input_db', 'DS219'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS219') }}

),


final as (
    select *
    from derived_from_ds219
)

select * from final
