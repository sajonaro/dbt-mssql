with derived_from_ds157 as (

  select
    {{ select_columns_except(source('input_db', 'DS157'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS157') }}

),


final as (
    select *
    from derived_from_ds157
)

select * from final
