with derived_from_ds221 as (

  select
    {{ select_columns_except(source('input_db', 'DS221'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS221') }}

),


final as (
    select *
    from derived_from_ds221
)

select * from final
