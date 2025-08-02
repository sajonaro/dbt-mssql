with derived_from_ds124 as (

  select
    {{ select_columns_except(source('input_db', 'DS124'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS124') }}

),


final as (
    select *
    from derived_from_ds124
)

select * from final
