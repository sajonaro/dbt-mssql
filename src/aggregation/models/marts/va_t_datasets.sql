with derived_from_VA_T_Datasets as (

  select
    {{ select_columns_except(source('input_db', 'VA_T_Datasets'), ['SpecialColumns']) }}
  from {{ source('input_db', 'VA_T_Datasets') }}

),


final as (
    select *
    from derived_from_VA_T_Datasets
)

select * from final
