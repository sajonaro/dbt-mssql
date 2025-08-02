with derived_from_ds38 as (

  select
    {{ select_columns_except(source('input_db', 'DS38'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS38') }}

),


final as (
    select *
    from derived_from_ds38
)

select * from final
