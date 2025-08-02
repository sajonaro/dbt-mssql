with derived_from_ds267 as (

  select
    {{ select_columns_except(source('input_db', 'DS267'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS267') }}

),


final as (
    select *
    from derived_from_ds267
)

select * from final
