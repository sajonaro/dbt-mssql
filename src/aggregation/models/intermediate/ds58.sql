with derived_from_ds58 as (

  select
    {{ select_columns_except(source('input_db', 'DS58'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS58') }}

),


final as (
    select *
    from derived_from_ds58
)

select * from final
