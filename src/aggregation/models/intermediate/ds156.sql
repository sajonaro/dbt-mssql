with derived_from_ds156 as (

  select
    {{ select_columns_except(source('input_db', 'DS156'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS156') }}

),


final as (
    select *
    from derived_from_ds156
)

select * from final
