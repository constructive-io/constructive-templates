-- Revert: schemas/catalog_private/tables/resource_installations/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.resource_installations FROM authenticated RESTRICT;