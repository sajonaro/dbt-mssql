with derived_from_ds118 as (

  select
    {{ select_columns_except(source('input_db', 'DS118'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS118') }}

),


final as (
    select *
    from derived_from_ds118
)

select * from final
