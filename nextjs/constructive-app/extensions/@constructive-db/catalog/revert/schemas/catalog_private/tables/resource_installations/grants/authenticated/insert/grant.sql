-- Revert: schemas/catalog_private/tables/resource_installations/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.resource_installations FROM authenticated RESTRICT;