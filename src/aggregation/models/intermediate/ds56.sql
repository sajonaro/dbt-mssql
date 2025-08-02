with derived_from_ds56 as (

  select
    {{ select_columns_except(source('input_db', 'DS56'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS56') }}

),


final as (
    select *
    from derived_from_ds56
)

select * from final
