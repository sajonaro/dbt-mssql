-- Fixed denormalized model for CompanyID 1 using UNION ALL with NULL padding
-- This replaces the problematic cross join approach that was causing transaction log overflow
-- Uses a custom macro to automatically handle NULL padding for different column structures
-- Tables: DS1, DS10, DS100, DS11, DS12, DS125, DS130, DS2, DS25, DS28, DS29, DS3, DS33, DS4, DS5, 
--         DS55, DS56, DS57, DS58, DS59, DS6, DS60, DS7, DS74, DS76, DS79, DS8, DS9, DS91


{% set relations = [
    ref('ds1'), ref('ds2'),ref('ds3'), ref('ds4'), ref('ds5'), ref('ds6'), ref('ds7'), ref('ds8'), ref('ds9'), ref('ds10'),
    ref('ds11'), ref('ds12'), ref('ds25'), ref('ds28'), ref('ds29'), ref('ds33'), ref('ds55'), ref('ds56'), ref('ds57'), ref('ds58'),
    ref('ds59'), ref('ds60'), ref('ds74'), ref('ds76'), ref('ds79'), ref('ds91'), ref('ds100'), ref('ds125'), ref('ds130')
] %}

{{ union_relations(relations) }}
