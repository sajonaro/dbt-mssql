with derived_from_ds151 as (

  select
    {{ select_columns_except(source('input_db', 'DS151'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS151') }}

),


final as (
    select *
    from derived_from_ds151
)

select * from final
