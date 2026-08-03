-- Revert: schemas/catalog_public/tables/resource_installations/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.resource_installations FROM authenticated RESTRICT;