with derived_from_ds223 as (

  select
    {{ select_columns_except(source('input_db', 'DS223'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS223') }}

),


final as (
    select *
    from derived_from_ds223
)

select * from final
