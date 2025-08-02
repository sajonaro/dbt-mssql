with derived_from_ds7 as (

  select
    {{ select_columns_except(source('input_db', 'DS7'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS7') }}

),


final as (
    select *
    from derived_from_ds7
)

select * from final
