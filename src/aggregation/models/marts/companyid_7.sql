-- Fixed denormalized model for CompanyID 7 using UNION ALL with NULL padding
-- This replaces the problematic cross join approach that was causing transaction log overflow
-- Uses a custom macro to automatically handle NULL padding for different column structures

-- Tables: DS155, DS156, DS157, DS158, DS159, DS160, DS161, DS162, DS163, DS164, DS165, DS166, DS167, DS168, DS274

{% set relations = [
    ref('ds155'), ref('ds156'), ref('ds157'), ref('ds158'), ref('ds159'), ref('ds160'), ref('ds161'),
    ref('ds162'), ref('ds163'), ref('ds164'), ref('ds165'), ref('ds166'), ref('ds167'), ref('ds168'),
    ref('ds274')
] %}

{{ union_relations(relations) }}
