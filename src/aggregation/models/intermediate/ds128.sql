with derived_from_ds128 as (

  select
    {{ select_columns_except(source('input_db', 'DS128'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS128') }}

),


final as (
    select *
    from derived_from_ds128
)

select * from final
