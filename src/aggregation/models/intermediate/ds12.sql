with derived_from_ds12 as (

  select
    {{ select_columns_except(source('input_db', 'DS12'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS12') }}

),


final as (
    select *
    from derived_from_ds12
)

select * from final
