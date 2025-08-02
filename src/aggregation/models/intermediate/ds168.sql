with derived_from_ds168 as (

  select
    {{ select_columns_except(source('input_db', 'DS168'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS168') }}

),


final as (
    select *
    from derived_from_ds168
)

select * from final
