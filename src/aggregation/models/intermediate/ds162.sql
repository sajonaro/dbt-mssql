with derived_from_ds162 as (

  select
    {{ select_columns_except(source('input_db', 'DS162'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS162') }}

),


final as (
    select *
    from derived_from_ds162
)

select * from final
