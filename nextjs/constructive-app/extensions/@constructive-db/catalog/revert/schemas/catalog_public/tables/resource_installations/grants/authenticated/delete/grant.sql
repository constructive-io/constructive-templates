-- Revert: schemas/catalog_public/tables/resource_installations/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.resource_installations FROM authenticated RESTRICT;