with derived_from_ds136 as (

  select
    {{ select_columns_except(source('input_db', 'DS136'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS136') }}

),


final as (
    select *
    from derived_from_ds136
)

select * from final
