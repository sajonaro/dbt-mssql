with derived_from_ds165 as (

  select
    {{ select_columns_except(source('input_db', 'DS165'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS165') }}

),


final as (
    select *
    from derived_from_ds165
)

select * from final
