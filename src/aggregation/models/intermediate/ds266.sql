with derived_from_ds266 as (

  select
    {{ select_columns_except(source('input_db', 'DS266'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS266') }}

),


final as (
    select *
    from derived_from_ds266
)

select * from final
