with derived_from_ds140 as (

  select
    {{ select_columns_except(source('input_db', 'DS140'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS140') }}

),


final as (
    select *
    from derived_from_ds140
)

select * from final
