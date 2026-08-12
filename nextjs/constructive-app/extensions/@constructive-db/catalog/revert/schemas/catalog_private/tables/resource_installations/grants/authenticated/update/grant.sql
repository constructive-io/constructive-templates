-- Revert: schemas/catalog_private/tables/resource_installations/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.resource_installations FROM authenticated RESTRICT;