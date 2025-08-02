with derived_from_ds225 as (

  select
    {{ select_columns_except(source('input_db', 'DS225'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS225') }}

),


final as (
    select *
    from derived_from_ds225
)

select * from final
