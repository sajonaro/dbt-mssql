with derived_from_ds291 as (

  select
    {{ select_columns_except(source('input_db', 'DS291'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS291') }}

),


final as (
    select *
    from derived_from_ds291
)

select * from final
