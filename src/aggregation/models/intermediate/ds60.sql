with derived_from_ds60 as (

  select
    {{ select_columns_except(source('input_db', 'DS60'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS60') }}

),


final as (
    select *
    from derived_from_ds60
)

select * from final
