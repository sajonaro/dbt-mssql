with derived_from_ds265 as (

  select
    {{ select_columns_except(source('input_db', 'DS265'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS265') }}

),


final as (
    select *
    from derived_from_ds265
)

select * from final
