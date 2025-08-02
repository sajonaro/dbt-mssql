with derived_from_ds41 as (

  select
    {{ select_columns_except(source('input_db', 'DS41'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS41') }}

),


final as (
    select *
    from derived_from_ds41
)

select * from final
