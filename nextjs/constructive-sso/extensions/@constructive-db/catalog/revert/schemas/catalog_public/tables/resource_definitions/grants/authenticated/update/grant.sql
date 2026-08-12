-- Revert: schemas/catalog_public/tables/resource_definitions/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.resource_definitions FROM authenticated RESTRICT;