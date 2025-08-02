with derived_from_ds321 as (

  select
    {{ select_columns_except(source('input_db', 'DS321'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS321') }}

),


final as (
    select *
    from derived_from_ds321
)

select * from final
