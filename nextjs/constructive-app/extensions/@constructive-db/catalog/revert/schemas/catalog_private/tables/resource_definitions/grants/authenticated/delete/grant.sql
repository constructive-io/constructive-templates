-- Revert: schemas/catalog_private/tables/resource_definitions/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.resource_definitions FROM authenticated RESTRICT;