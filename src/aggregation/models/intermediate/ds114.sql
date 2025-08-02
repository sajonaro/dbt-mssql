with derived_from_ds114 as (

  select
    {{ select_columns_except(source('input_db', 'DS114'), ['SpecialColumns']) }}
  from {{ source('input_db', 'DS114') }}

),


final as (
    select *
    from derived_from_ds114
)

select * from final
