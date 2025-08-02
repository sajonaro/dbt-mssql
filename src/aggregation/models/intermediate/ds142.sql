with derived_from_ds142 as (

  select
    {{ select_columns_except(source('input_db', 'DS142'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS142') }}

),


final as (
    select *
    from derived_from_ds142
)

select * from final
