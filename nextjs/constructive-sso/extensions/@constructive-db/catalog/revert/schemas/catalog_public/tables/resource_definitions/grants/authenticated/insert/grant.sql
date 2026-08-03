-- Revert: schemas/catalog_public/tables/resource_definitions/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.resource_definitions FROM authenticated RESTRICT;