-- Revert: schemas/catalog_private/tables/resource_definitions/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.resource_definitions FROM authenticated RESTRICT;