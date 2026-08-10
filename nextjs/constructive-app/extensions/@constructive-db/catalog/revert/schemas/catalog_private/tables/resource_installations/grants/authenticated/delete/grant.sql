-- Revert: schemas/catalog_private/tables/resource_installations/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.resource_installations FROM authenticated RESTRICT;