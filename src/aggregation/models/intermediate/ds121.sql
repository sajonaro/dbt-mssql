with derived_from_ds121 as (

  select
    {{ select_columns_except(source('input_db', 'DS121'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS121') }}

),


final as (
    select *
    from derived_from_ds121
)

select * from final
