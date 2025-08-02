with derived_from_VA_T_Fields as (

  select
    {{ select_columns_except(source('input_db', 'VA_T_Fields'), ['SpecialColumns']) }}
  from {{ source('input_db', 'VA_T_Fields') }}

),


final as (
    select *
    from derived_from_VA_T_Fields
)

select * from final
