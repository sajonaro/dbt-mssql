-- Fixed denormalized model for CompanyID 5 using UNION ALL with NULL padding
-- This replaces the problematic cross join approach that was causing transaction log overflow
-- Uses a custom macro to automatically handle NULL padding for different column structures

-- Tables: DS113, DS114, DS115, DS116, DS117, DS118, DS119, DS120, DS121, DS122, DS123, DS124, DS133, DS134, DS322

{% set relations = [
    ref('ds113'), ref('ds114'), ref('ds115'), ref('ds116'), ref('ds117'), ref('ds118'), ref('ds119'),
    ref('ds120'), ref('ds121'), ref('ds122'), ref('ds123'), ref('ds124'), ref('ds133'), ref('ds134'),
    ref('ds322')
] %}

{{ union_relations(relations) }}
