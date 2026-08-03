-- Revert: schemas/catalog_public/tables/resource_definitions/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.resource_definitions FROM authenticated RESTRICT;