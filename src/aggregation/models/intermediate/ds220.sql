with derived_from_ds220 as (

  select
    {{ select_columns_except(source('input_db', 'DS220'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS220') }}

),


final as (
    select *
    from derived_from_ds220
)

select * from final
