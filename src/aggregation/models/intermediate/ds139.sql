with derived_from_ds139 as (

  select
    {{ select_columns_except(source('input_db', 'DS139'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS139') }}

),


final as (
    select *
    from derived_from_ds139
)

select * from final
