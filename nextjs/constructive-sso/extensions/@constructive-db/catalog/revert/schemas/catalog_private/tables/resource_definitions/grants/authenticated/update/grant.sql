-- Revert: schemas/catalog_private/tables/resource_definitions/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.resource_definitions FROM authenticated RESTRICT;