with derived_from_ds100 as (

  select
    {{ select_columns_except(source('input_db', 'DS100'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS100') }}

),


final as (
    select *
    from derived_from_ds100
)

select * from final
