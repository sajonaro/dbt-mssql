with derived_from_ds9 as (

  select
    {{ select_columns_except(source('input_db', 'DS9'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS9') }}

),


final as (
    select *
    from derived_from_ds9
)

select * from final
