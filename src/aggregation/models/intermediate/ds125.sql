with derived_from_ds125 as (

  select
    {{ select_columns_except(source('input_db', 'DS125'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS125') }}

),


final as (
    select *
    from derived_from_ds125
)

select * from final
