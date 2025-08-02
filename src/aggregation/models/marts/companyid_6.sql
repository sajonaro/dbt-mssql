-- Fixed denormalized model for CompanyID 6 using UNION ALL with NULL padding
-- This replaces the problematic cross join approach that was causing transaction log overflow
-- Uses a custom macro to automatically handle NULL padding for different column structures

-- Tables: DS135, DS136, DS137, DS138, DS139, DS140, DS141, DS142, DS143, DS145, DS146, DS147, DS148, DS151, DS290, DS291

{% set relations = [
    ref('ds135'), ref('ds136'), ref('ds137'), ref('ds138'), ref('ds139'), ref('ds140'), ref('ds141'),
    ref('ds142'), ref('ds143'), ref('ds145'), ref('ds146'), ref('ds147'), ref('ds148'), ref('ds151'),
    ref('ds290'), ref('ds291')
] %}

{{ union_relations(relations) }}
