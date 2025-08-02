with derived_from_ds122 as (

  select
    {{ select_columns_except(source('input_db', 'DS122'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS122') }}

),


final as (
    select *
    from derived_from_ds122
)

select * from final
