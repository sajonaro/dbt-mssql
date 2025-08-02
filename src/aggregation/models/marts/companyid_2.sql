-- Fixed denormalized model for CompanyID 2 using UNION ALL with NULL padding
-- This replaces the problematic cross join approach that was causing transaction log overflow
-- Uses a custom macro to automatically handle NULL padding for different column structures

-- Tables: DS126, DS128, DS149, DS152, DS219, DS220, DS221, DS222, DS223, DS224, DS225, DS226, DS227, DS228, DS229, DS230, DS231, DS232, DS234, DS256, DS26, DS27, DS272, DS273, DS314, DS315, DS319, DS321, DS37, DS38, DS40, DS41, DS98

{% set relations = [
    ref('ds26'), ref('ds27'), ref('ds37'), ref('ds38'), ref('ds40'), ref('ds41'), ref('ds98'),
    ref('ds126'), ref('ds128'), ref('ds149'), ref('ds152'), ref('ds219'), ref('ds220'), ref('ds221'),
    ref('ds222'), ref('ds223'), ref('ds224'), ref('ds225'), ref('ds226'), ref('ds227'), ref('ds228'),
    ref('ds229'), ref('ds230'), ref('ds231'), ref('ds232'), ref('ds234'), ref('ds256'), ref('ds272'),
    ref('ds273'), ref('ds314'), ref('ds315'), ref('ds319'), ref('ds321'), ref('ds322')
] %}

{{ union_relations(relations) }}
