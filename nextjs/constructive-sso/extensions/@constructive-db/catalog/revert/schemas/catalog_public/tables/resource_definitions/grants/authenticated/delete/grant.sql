-- Revert: schemas/catalog_public/tables/resource_definitions/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.resource_definitions FROM authenticated RESTRICT;