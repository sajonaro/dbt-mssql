with derived_from_ds76 as (

  select
    {{ select_columns_except(source('input_db', 'DS76'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS76') }}

),


final as (
    select *
    from derived_from_ds76
)

select * from final
