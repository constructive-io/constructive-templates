-- Revert: schemas/catalog_public/tables/resource_installations/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.resource_installations FROM authenticated RESTRICT;