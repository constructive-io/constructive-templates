-- Revert: schemas/catalog_private/tables/resources/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.resources FROM authenticated RESTRICT;