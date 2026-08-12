-- Revert: schemas/catalog_private/tables/resource_definitions/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.resource_definitions FROM authenticated RESTRICT;