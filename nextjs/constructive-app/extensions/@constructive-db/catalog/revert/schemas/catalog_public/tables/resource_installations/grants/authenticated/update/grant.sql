-- Revert: schemas/catalog_public/tables/resource_installations/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.resource_installations FROM authenticated RESTRICT;